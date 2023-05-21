//
//  FavoritesViewController.swift
//  GymExercise
//
//  Created by Ravindu Dananjaya on 2023-05-16.
//

import UIKit

class FavoritesViewController : UITabBarController {
    
    private let suggestlbl: UILabel = {
        let label = UILabel()
        label.text = "Your Suggest Fitness Plan"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .monospacedSystemFont(ofSize: 20, weight: .bold)
        label.textColor = UIColor(red: 10/255, green: 207/255, blue: 131/255, alpha: 1)
        return label
    }()
    
    private let suggestlblreturn: UILabel = {
        let label = UILabel()
        label.text = "Currently You Haven't Calculate BMI "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    private let myFitnessPlan: UIButton = {
        let button = UIButton()
        button.setTitle("My Fitness Plan", for: .normal)
        button.backgroundColor = UIColor(red: 10/255, green: 207/255, blue: 131/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(navigateToFitnessPlan), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    private let calculateBMIbtnTap: UIButton = {
        let button = UIButton()
        button.setTitle("Calculate My BMI", for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(navigateCalculateBMI), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 10/255, green: 207/255, blue: 131/255, alpha: 1)
        return button
    }()
    
      let userData: UserData
       var userFitness: UserFitness?
       
       init(userData: UserData, userFitness: UserFitness? = nil) {
           self.userData = userData
           self.userFitness = userFitness
           super.init(nibName: nil, bundle: nil)
       }
       
       required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        
        setupUI()
        
        fetchFitnessData()
   
    }
    
    func setupUI() {
        
        navigationItem.hidesBackButton = true
                
        view.addSubview(suggestlbl)
        view.addSubview(suggestlblreturn)
        view.addSubview(calculateBMIbtnTap)
        view.addSubview(myFitnessPlan)
        
        NSLayoutConstraint.activate([
            
            suggestlbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            suggestlbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            suggestlbl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            suggestlblreturn.topAnchor.constraint(equalTo: suggestlbl.bottomAnchor, constant: 50),
            suggestlblreturn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            //suggestlblreturn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            calculateBMIbtnTap.topAnchor.constraint(equalTo: suggestlblreturn.bottomAnchor, constant: 50),
            calculateBMIbtnTap.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calculateBMIbtnTap.widthAnchor.constraint(equalToConstant: 250),
            calculateBMIbtnTap.heightAnchor.constraint(equalToConstant: 50),
            
            myFitnessPlan.topAnchor.constraint(equalTo: calculateBMIbtnTap.bottomAnchor, constant: 50),
            myFitnessPlan.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            myFitnessPlan.widthAnchor.constraint(equalToConstant: 250),
            myFitnessPlan.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    func fetchFitnessData() {
        
        let endpoint = URL(string: "http://localhost:8080/userFitnessPlan/suggestFitnessPlan")!

        let parameters: [String: Any] = [
            "userName": userData.userName,
        ]
        print(parameters)
        
        // Create the request object
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Convert the parameters to JSON data and set it as the request body
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters)
        } catch {
            print("Error serializing JSON: \(error)")
        }
        
        let session = URLSession.shared
        
        // Send the request
        let task = session.dataTask(with: request) { data, response, error in
            // Handle the response
            if let error = error {
                print("Error: \(error)")
            } else if let data = data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    do{
                        let decoder = JSONDecoder()
                        self.userFitness = try decoder.decode(UserFitness.self, from: data)
                       
                    DispatchQueue.main.async {
                        self.updateTextBoxes(data: data)
                   }
                    } catch {
                        print("Error decoding JSON: \(error)")
                    }
                } else {
                        print("Request failed with status code \(response.statusCode)")
                }
            }
        }
        task.resume()
        
    }
    
    @objc func navigateCalculateBMI() {
        let detailViewController = CalculateBMIVewController(userData: self.userData)
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    
    
    @objc func navigateToFitnessPlan() {
        let detailViewController = MyFitnessViewController(userFitness: self.userFitness!)
        navigationController?.pushViewController(detailViewController, animated: true)

        }
    
    func updateTextBoxes(data: Data){
        
        do {
            let userData = try JSONDecoder().decode(UserFitness.self, from: data)
            userFitness = userData
            suggestlblreturn.text = userData.type
            self.calculateBMIbtnTap.isHidden = true
            self.myFitnessPlan.isHidden = false
        } catch {
            print("Error decoding JSON: \(error)")
        }
        
    }
    
}

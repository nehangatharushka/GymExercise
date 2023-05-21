//
//  MyFitnessPlanViewController.swift
//  GymExercise
//
//  Created by Developer on 2023-05-20.
//

import UIKit

class MyFitnessViewController : UITabBarController {
 
    let userFitness: UserFitness
    
    init(userFitness: UserFitness) {
        self.userFitness = userFitness
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let typelbl: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 10/255, green: 207/255, blue: 131/255, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
        private let protienlbl: UILabel = {
            let label = UILabel()
            label.text = "Protien"
            label.translatesAutoresizingMaskIntoConstraints = false
            label.font = UIFont.boldSystemFont(ofSize: 20)
            return label
        }()
    
    private let protienlblreturn: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Protien return"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0 // Allow the label to use as many lines as needed
            label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let carblbl: UILabel = {
        let label = UILabel()
        label.text = "Carbohydrates"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let carbreturn: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0 // Allow the label to use as many lines as needed
            label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let fatlbl: UILabel = {
        let label = UILabel()
        label.text = "Fat"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    private let fatreturn: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0 // Allow the label to use as many lines as needed
            label.lineBreakMode = .byWordWrapping 
        return label
    }()
    
    
    override func viewDidLoad() {
        
        view.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
    
        setupUI()
        
        fetchData()

    }
    
    func setupUI() {
        
                
        view.addSubview(protienlbl)
        view.addSubview(protienlblreturn)
        view.addSubview(typelbl)
        view.addSubview(carblbl)
        view.addSubview(carbreturn)
        view.addSubview(fatlbl)
        view.addSubview(fatreturn)

        
        
        NSLayoutConstraint.activate([
            
            typelbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            typelbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            typelbl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            protienlbl.topAnchor.constraint(equalTo: typelbl.bottomAnchor, constant: 50),
            protienlbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            protienlbl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            protienlblreturn.topAnchor.constraint(equalTo: protienlbl.bottomAnchor, constant: 10),
            protienlblreturn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            protienlblreturn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            carblbl.topAnchor.constraint(equalTo: protienlblreturn.bottomAnchor, constant: 50),
            carblbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            carblbl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            carbreturn.topAnchor.constraint(equalTo: carblbl.bottomAnchor, constant: 10),
            carbreturn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            carbreturn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            fatlbl.topAnchor.constraint(equalTo: carbreturn.bottomAnchor, constant: 50),
            fatlbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fatlbl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            fatreturn.topAnchor.constraint(equalTo: fatlbl.bottomAnchor, constant: 10),
            fatreturn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fatreturn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        ])
        typelbl.text = userFitness.type
    }
    
    func fetchData() {
        
        let endpoint = URL(string: "http://localhost:8080/gym/getFitnessPlan")!

        let parameters: [String: Any] = [
            "type": userFitness.type,
        ]
        
        print("API")
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
                    DispatchQueue.main.async {
                        self.updateTextBoxes(data: data)
                    }
                } else {
                        print("Request failed with status code \(response.statusCode)")
                }
            }
        }
        task.resume()
    }
    
    func updateTextBoxes(data: Data) {
       
        do {
            let fitnessPlan = try JSONDecoder().decode(FitnessPlan.self, from: data)
//            FitnessPlan = fitnessPlan
            protienlblreturn.text = fitnessPlan.Protein
            carbreturn.text = fitnessPlan.Carbohydrates
            fatreturn.text = fitnessPlan.Fat
        } catch {
            print("Error decoding JSON: \(error)")
        }
        
    }
    
    
}

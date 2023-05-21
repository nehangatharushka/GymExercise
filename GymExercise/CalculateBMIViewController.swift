//
//  CalculateBMIViewController.swift
//  GymExercise
//
//  Created by Ravindu Dananjaya on 2023-05-17.
//

import UIKit

class CalculateBMIVewController : UIViewController {
    
    private let titlelbl: UILabel = {
        let label = UILabel()
        label.text = "Calculate Your BMI"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 10/255, green: 207/255, blue: 131/255, alpha: 1)
        label.font = UIFont.boldSystemFont(ofSize: 24)
        return label
    }()
    
    let weightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your weight in kg"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let heightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your height in cm"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
//    let calculateButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Calculate BMI", for: .normal)
//        button.backgroundColor = .UIColor(red: 10/255, green: 207/255, blue: 131/255, alpha: 1)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    private let calculateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Calculate BMI", for: .normal)
        button.backgroundColor = UIColor(red: 10/255, green: 207/255, blue: 131/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.addTarget(self, action: #selector(updateTap), for: .touchUpInside)
        return button
    }()
    
    let resultLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userNamelbl: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let userData: UserData
    
    init(userData: UserData) {
        self.userData = userData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        
        print("Passed Profile userData: \(userData)")
        
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        
        view.addSubview(titlelbl)
        view.addSubview(weightTextField)
        view.addSubview(heightTextField)
        view.addSubview(calculateButton)
        view.addSubview(resultLabel)
        
        calculateButton.addTarget(self, action: #selector(calculateBMI), for: .touchUpInside)
        
        setupConstraints()
        
    }
    
    func setupConstraints(){
        
        NSLayoutConstraint.activate([
            
            titlelbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10),
            titlelbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            weightTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weightTextField.topAnchor.constraint(equalTo: titlelbl.bottomAnchor, constant: 60),
            weightTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            heightTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heightTextField.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 20),
            heightTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calculateButton.topAnchor.constraint(equalTo: heightTextField.bottomAnchor, constant: 60),
            calculateButton.widthAnchor.constraint(equalToConstant: 360),
            calculateButton.heightAnchor.constraint(equalToConstant: 40),
            
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.topAnchor.constraint(equalTo: calculateButton.bottomAnchor, constant: 50),
            resultLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
        ])
        userNamelbl.text = userData.userName
    }
    
    @objc func calculateBMI() {
        guard let weightText = weightTextField.text, let weight = Double(weightText),
              let heightText = heightTextField.text, let height = Double(heightText) else {
            resultLabel.text = "Invalid input"
            return
        }
        
        let bmi = weight / ((height / 100) * (height / 100))
        
        resultLabel.text = String(format: "Your BMI is %.2f", bmi)
        
        suggestPlan(bmi: bmi)
        
    }
    
    func suggestPlan(bmi: Double) {
        
        var plan = ""
        
        if bmi < 18.5 {
            plan = "Gain Weight"
        } else if bmi < 24.9 {
            plan = "Maintain Weight"
        } else {
            plan = "Lose Weight"
        }
        
        let alert = UIAlertController(title: "Suggested Fitness Plan", message: "Based on your BMI, you should: \(plan)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            self.sendPlanToAPI(plan: plan, bmi: bmi)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func sendPlanToAPI(plan: String, bmi: Double) {
        
        // Send registration data to API endpoint
        // Define the endpoint URL
        let endpoint = URL(string: "http://localhost:8080/user/SaveFitnessplan")!
        
        let parameters: [String: Any] = [
            "userName": self.userData.userName,
            "type": plan,
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
        
        // Create the URLSession object
        let session = URLSession.shared
        
        // Send the request
        let task = session.dataTask(with: request) { data, response, error in
            // Handle the response
            if let error = error {
                print("Error: \(error)")
            } else if let data = data, let response = response as? HTTPURLResponse {
                if response.statusCode == 200 {
                    print("Request succeeded")
                    DispatchQueue.main.async {
                        let nextVC = HomeTabBarController(userData: self.userData)
                        self.navigationController?.pushViewController(nextVC, animated: true)
                    }
                } else {
                    print("Request failed with status code \(response.statusCode)")
                }
            }
        }
        
        task.resume()
        
//        navigateToFitnessViewController()
        
    }
    
//    func navigateToFitnessViewController() {
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            let view = FavoritesViewController()
//            self.navigationController?.pushViewController(view, animated: true)
//        }
//    }
}
            
//        registerButtonTapped(userNamelbl ,plan: userplan)
        // Fetch the fitness plans from the API
//        fetchFitnessPlans { (plans, error) in
//           if let error = error {
//               print("Failed to fetch plans: \(error)")
//               return
//           }
//
//             self.plans = plans
//
//         DispatchQueue.main.async {
//                 // Navigate to the plans view controller
//             let plansViewController = FavoritesViewController(plans: self.plans)
//             self.navigationController?.pushViewController(plansViewController, animated: true)
//             }
            
    // Show success message
//        let alert = UIAlertController(title: "Registration Successful", message: "You have successfully registered!", preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .default)
//        alert.addAction(okAction)
//        present(alert, animated: true)


    
//    func fetchFitnessPlans(completion: @escaping ([FitnessPlan], Error?) -> Void) {
//        let url = URL(string: "http://localhost:8080/gym/fitnessPlan")!
//        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//            if let error = error {
//                completion([], error)
//                return
//            }
//
//            guard let data = data else {
//                completion([], nil)
//                return
//            }
//
//            let decoder = JSONDecoder()
//            do {
//                let plans = try decoder.decode([FitnessPlan].self, from: data)
//                completion(plans, nil)
//            } catch {
//                completion([], error)
//            }
//        }
//        task.resume()
//    }

       // FitnessPlansViewControllerDelegate
       
//       func didSelectPlan(_ plan: FitnessPlan) {
//           self.selectedPlan = plan
//
//           let alert = UIAlertController(title: "Suggested Fitness Plan", message: "Fitness Plan: \(plan)", preferredStyle: .alert)
//
//           // Call the POST API with the selected plan and the BMI
//           // This is just a placeholder, you need to implement the actual API call
//           // submitPlan(plan, bmi: bmi) { success in
//           //    ... your code here ...
//           // }
//       }
    

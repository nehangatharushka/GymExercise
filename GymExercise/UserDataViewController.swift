//
//  UserDataViewController.swift
//  GymExercise
//
//  Created by Ravindu Dananjaya on 2023-05-18.
//

import UIKit
////import Alamofire
//
//class UserDataViewController : UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//    }
//}

class UserDataViewController: UIViewController, UITextFieldDelegate {
    
    private let heightTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter your height"
        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.keyboardType = .numberPad
        return textField
    }()
    
    let weightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your weight"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.keyboardType = .numberPad
        return textField
    }()
    
    let ageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your age"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.keyboardType = .numberPad
        return textField
    }()
    
    let fitnessGoalTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your fitness goal"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter your username"
        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.widthAnchor = 100
        return textField
    }()
    
    let fullNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter your FullName"
        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.widthAnchor = 100
        return textField
    }()
    
    let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter your email"
//        textField.keyboardType = .emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let updateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Update Profile", for: .normal)
        button.backgroundColor = UIColor(red: 10/255, green: 207/255, blue: 131/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(updateTap), for: .touchUpInside)
        return button
    }()
    
    private let mylbl: UILabel = {
        let label = UILabel()
        label.text = "Update Your Profile"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = UIColor(red: 10/255, green: 207/255, blue: 131/255, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
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
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
       
        
        heightTextField.delegate = self
        weightTextField.delegate = self
        ageTextField.delegate = self
        fitnessGoalTextField.delegate = self

        view.addSubview(nameTextField)
        view.addSubview(fullNameTextField)
        view.addSubview(emailTextField)
        view.addSubview(heightTextField)
        view.addSubview(weightTextField)
        view.addSubview(ageTextField)
        view.addSubview(fitnessGoalTextField)
        view.addSubview(updateButton)
        view.addSubview(mylbl)
        setConstraints()
        fetchUserData()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            
            mylbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            mylbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            nameTextField.topAnchor.constraint(equalTo: mylbl.bottomAnchor, constant: 50),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            fullNameTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30),
            fullNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fullNameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            emailTextField.topAnchor.constraint(equalTo: fullNameTextField.bottomAnchor, constant: 30),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            heightTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
            heightTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heightTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            weightTextField.topAnchor.constraint(equalTo: heightTextField.bottomAnchor, constant: 30),
            weightTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weightTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            ageTextField.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 30),
            ageTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ageTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            fitnessGoalTextField.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 30),
            fitnessGoalTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fitnessGoalTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            updateButton.topAnchor.constraint(equalTo: fitnessGoalTextField.bottomAnchor, constant: 40),
            updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            updateButton.widthAnchor.constraint(equalToConstant: 200),
            updateButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    
    @objc private func updateTap() {
        guard let name = nameTextField.text,!name.isEmpty,
              let fullName = fullNameTextField.text,!fullName.isEmpty,
              let email = emailTextField.text,!email.isEmpty,
              let height = heightTextField.text,!height.isEmpty,
              let weight = weightTextField.text,!weight.isEmpty,
              let age = ageTextField.text,!age.isEmpty,
              let fitnessGoal = fitnessGoalTextField.text else {
            return
        }

//      let endpoint = URL(string: "http://localhost:8080/user/loginUser)!
        let endpoint = URL(string: "http://localhost:8080/user/update")!
        
        let parameters: [String: Any] = [
            "_id":userData._id,
            "userName": name,
            "fullName":fullName,
            "email":email,
            "height": height,
            "weight":weight,
            "age":age,
            "fitnessGoal":fitnessGoal
        ]
        
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
                    do {
//                        let userData = try JSONDecoder().decode(UserData.self, from: data)
                        let userData = try JSONDecoder().decode(UserData.self, from: data)
                      
                        DispatchQueue.main.async {
                            
                            let alert = UIAlertController(title: "Success", message: "Profile successfully updated", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                
                            let nextVC = HomeTabBarController(userData: userData)
                            self.navigationController?.pushViewController(nextVC, animated: true)
                            }))
                                // Show alert
                                self.present(alert, animated: true, completion: nil)
                        }
                    } catch {
                        print("Error decoding JSON-update: \(error)")
                    }
                } else {
                    print("Request failed with status code \(response.statusCode)")
                }
            }
        }

        task.resume()
        }
                                                      
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func fetchUserData() {
        let endpoint = URL(string: "http://localhost:8080/user/getUser")!

        let parameters: [String: Any] = [
            "_id": userData._id,
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
                    print("Request succeeded")
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
            let userData = try JSONDecoder().decode(UserData.self, from: data)
            nameTextField.text = userData.userName
            fullNameTextField.text = userData.fullName
            emailTextField.text = userData.email
            heightTextField.text = (userData.height)
            weightTextField.text = (userData.weight)
            ageTextField.text = (userData.age)
            fitnessGoalTextField.text = userData.fitnessGoal
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }



}

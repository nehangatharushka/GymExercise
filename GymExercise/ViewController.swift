//
//  ViewController.swift
//  GymExercise
//
//  Created by Ravindu Dananjaya on 2023-05-14.
//

//import UIKit
//
//class ViewController: UIViewController {
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .blue
//        // Do any additional setup after loading the view.
//    }
//
//
//}

import UIKit
//import Alamofire

class ViewController : UIViewController {
    // create UI elements
    private let weightlbl: UILabel = {
        let label = UILabel()
        label.text = "Weight : "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let weightTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter Weight in (KG)"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let heightlbl: UILabel = {
        let label = UILabel()
        label.text = "Height:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let heightTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter Height in Feet"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true
                
        // add UI elements to view
        view.addSubview(heightlbl)
        view.addSubview(heightTextField)
        view.addSubview(weightlbl)
        view.addSubview(weightTextField)
        view.addSubview(submitButton)
        
        // set constraints
        NSLayoutConstraint.activate([
            
            heightlbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            heightlbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            heightTextField.topAnchor.constraint(equalTo: heightlbl.topAnchor),
            heightTextField.leadingAnchor.constraint(equalTo: heightlbl.trailingAnchor, constant: 10),
            heightTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
//            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
//            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//
//            nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor),
//            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
//            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//
//            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
//            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//
//            emailTextField.topAnchor.constraint(equalTo: emailLabel.topAnchor),
//            emailTextField.leadingAnchor.constraint(equalTo: emailLabel.trailingAnchor, constant: 10),
//            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//
//            submitButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
//            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            submitButton.widthAnchor.constraint(equalToConstant: 100),
//            submitButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        // add target action to submit button
       // submitButton.addTarget(self, for: .touchUpInside)
    }
    
//    @objc func submitButtonTapped() {
//        guard let name = nameTextField.text,
//              let email = emailTextField.text else {
//            return
//        }
//
//        let parameters: [String: Any] = [
//            "name": name,
//            "email": email
//        ]
//
//        AF.request("https://your-api-url.com", method: .post, parameters: parameters)
//            .validate(statusCode: 200..<300)
//            .response { response in
//                switch response.result {
//                case .success:
//                    print("Data sent successfully")
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//            }
//    }
}



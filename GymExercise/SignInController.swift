//
//  SignInController.swift
//  GymExercise
//
//  Created by Ravindu Dananjaya on 2023-05-15.
//
import UIKit
//import Alamofire

class SignInController : UIViewController {
    // create UI elements
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter your name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email:"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter your email"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let signIn: UIButton = {
        let button = UIButton()
        button.setTitle("Don't Have an Account , Register", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signInTap), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        
        // add UI elements to view
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)
        view.addSubview(submitButton)
        view.addSubview(signIn)
        
        // set constraints
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.topAnchor),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 10),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.topAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: emailLabel.trailingAnchor, constant: 10),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            submitButton.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            submitButton.widthAnchor.constraint(equalToConstant: 100),
            submitButton.heightAnchor.constraint(equalToConstant: 50),
            
            signIn.topAnchor.constraint(equalTo: submitButton.bottomAnchor,constant: 10),
            signIn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        // add target action to submit button
//        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    }
    
    @objc func signInTap() {
            let detailViewController = RegisterViewController()
            navigationController?.pushViewController(detailViewController, animated: true)
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


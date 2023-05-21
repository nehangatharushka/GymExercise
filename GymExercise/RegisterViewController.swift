//
//  RegisterViewController.swift
//  GymExercise
//
//  Created by Ravindu Dananjaya on 2023-05-15.
//

import UIKit

class RegisterViewController : UIViewController {
    
    // MARK: - Properties
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Register"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let userName: UILabel = {
        let label = UILabel()
        label.text = "UserName"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter your username"
        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.widthAnchor = 100
        return textField
    }()
    
    private let fullName: UILabel = {
        let label = UILabel()
        label.text = "FullName"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let fullNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter your FullName"
        textField.translatesAutoresizingMaskIntoConstraints = false
//        textField.widthAnchor = 100
        return textField
    }()
//    private let emailLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Email"
//        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
    private let email: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter your email"
        textField.keyboardType = .emailAddress
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let password: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
//    private let passwordLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Password"
//        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter your password"
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = UIColor(red: 10/255, green: 207/255, blue: 131/255, alpha: 1)
        button.layer.cornerRadius = 8
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let signIn: UIButton = {
        let button = UIButton()
        button.setTitle("Already Have an Account , SignIn", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signInTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Image")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill

        // Add the UIImageView as a subview
        self.view.insertSubview(backgroundImage, at: 0)
        
        navigationItem.hidesBackButton = true
        
        view.backgroundColor = .darkGray
        // add UI elements to view
//        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
       view.addSubview(fullNameTextField)
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(registerButton)
        view.addSubview(signIn)
        view.addSubview(nameLabel)
        view.addSubview(userName)
        view.addSubview(fullName)
        view.addSubview(email)
        view.addSubview(password)
        
        // set constraints
        NSLayoutConstraint.activate([
            
//            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
//            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.widthAnchor.constraint(equalToConstant: 350),
            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            userName.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 40),
            userName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userName.widthAnchor.constraint(equalToConstant: 350),
            userName.heightAnchor.constraint(equalToConstant: 40),
            
            nameTextField.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 2),
            nameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameTextField.widthAnchor.constraint(equalToConstant: 350),
            nameTextField.heightAnchor.constraint(equalToConstant: 40),
//            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 20),
//            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            fullName.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 30),
            fullName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fullName.widthAnchor.constraint(equalToConstant: 350),
            fullName.heightAnchor.constraint(equalToConstant: 40),
            
   
            fullNameTextField.topAnchor.constraint(equalTo: fullName.bottomAnchor,constant: 2),
            fullNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fullNameTextField.heightAnchor.constraint(equalToConstant: 40),
            fullNameTextField.widthAnchor.constraint(equalToConstant: 350),
            
            email.topAnchor.constraint(equalTo: fullNameTextField.bottomAnchor, constant: 30),
            email.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            email.widthAnchor.constraint(equalToConstant: 350),
            email.heightAnchor.constraint(equalToConstant: 40),
            
            emailTextField.topAnchor.constraint(equalTo: email.bottomAnchor,constant: 2),
            emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 40),
            emailTextField.widthAnchor.constraint(equalToConstant: 350),
            
            password.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 30),
            password.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            password.widthAnchor.constraint(equalToConstant: 350),
            password.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTextField.topAnchor.constraint(equalTo: password.bottomAnchor,constant: 2),
            passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            passwordTextField.widthAnchor.constraint(equalToConstant: 350),
            
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 20),
            registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            registerButton.widthAnchor.constraint(equalToConstant: 100),
            registerButton.heightAnchor.constraint(equalToConstant: 50),
            
            signIn.topAnchor.constraint(equalTo: registerButton.bottomAnchor,constant: 10),
            signIn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc private func registerButtonTapped() {
        guard let name = nameTextField.text, !name.isEmpty,
              let fullName = fullNameTextField.text, !fullName.isEmpty,
              let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty else {
            return
        }
        
        // Send registration data to API endpoint
        // Define the endpoint URL
        let endpoint = URL(string: "http://localhost:8080/user/Register")!

        // Define the request parameters
        let parameters: [String: Any] = [
            "fullName":fullName,
            "userName": name,
            "email":email,
            "password": password
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
                        let nextVC = SignInController()
                        self.navigationController?.pushViewController(nextVC, animated: true)
                    }
                } else {
                    print("Request failed with status code \(response.statusCode)")
                }
            }
        }

        task.resume()

        
        // Show success message
//        let alert = UIAlertController(title: "Registration Successful", message: "You have successfully registered!", preferredStyle: .alert)
//        let okAction = UIAlertAction(title: "OK", style: .default)
//        alert.addAction(okAction)
//        present(alert, animated: true)
        
        
    }
    
    @objc func signInTap() {
            let detailViewController = SignInController()
            navigationController?.pushViewController(detailViewController, animated: true)
        }
}


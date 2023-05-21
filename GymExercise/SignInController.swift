//
//  SignInController.swift
//  GymExercise
//
//  Created by Ravindu Dananjaya on 2023-05-15.
//
import UIKit

class SignInController : UIViewController {
    // create UI elements
//    private let nameLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Name:"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    private let loginlbl: UILabel = {
        let label = UILabel()
        label.text = "Login"
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    
    private let userNameTxtField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter your name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
//    private let emailLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Email:"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
    
    private let passwordTxtField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter your password"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor(red: 10/255, green: 207/255, blue: 131/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
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
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Image")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill

        // Add the UIImageView as a subview
        self.view.insertSubview(backgroundImage, at: 0)
        
        navigationItem.hidesBackButton = true
        
        // add UI elements to view
        view.addSubview(userNameTxtField)
        view.addSubview(passwordTxtField)
        view.addSubview(submitButton)
        view.addSubview(signIn)
        view.addSubview(loginlbl)
        
        // set constraints
        NSLayoutConstraint.activate([
            
            loginlbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 60),
            loginlbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginlbl.widthAnchor.constraint(equalToConstant: 350),
            loginlbl.heightAnchor.constraint(equalToConstant: 40),
            
            userNameTxtField.topAnchor.constraint(equalTo: loginlbl.bottomAnchor , constant: 40),
            userNameTxtField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userNameTxtField.widthAnchor.constraint(equalToConstant: 350),
            userNameTxtField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordTxtField.topAnchor.constraint(equalTo: userNameTxtField.bottomAnchor, constant: 20),
            passwordTxtField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            passwordTxtField.widthAnchor.constraint(equalToConstant: 350),
            passwordTxtField.heightAnchor.constraint(equalToConstant: 40),
            
            submitButton.topAnchor.constraint(equalTo: passwordTxtField.bottomAnchor, constant: 40),
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
    
    @objc func submitButtonTapped() {
        guard let name = userNameTxtField.text,
              let pw = passwordTxtField.text else {
            return
        }

        let endpoint = URL(string: "http://localhost:8080/user/loginUser")!
        
        let parameters: [String: Any] = [
            "userName": name,
            "password": pw
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
                        let userData = try JSONDecoder().decode(UserData.self, from: data)
                        DispatchQueue.main.async {
                            let nextVC = HomeTabBarController(userData: userData)
                            self.navigationController?.pushViewController(nextVC, animated: true)
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
}


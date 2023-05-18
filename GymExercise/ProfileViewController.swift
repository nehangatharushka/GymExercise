//
//  ProfileViewController.swift
//  GymExercise
//
//  Created by Ravindu Dananjaya on 2023-05-16.
//


import UIKit
//import Alamofire

class ProfileViewController : UIViewController {
  
    private let userNamelbl: UILabel = {
        let label = UILabel()
        label.text = "Weight : "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let emaillbl: UILabel = {
        let label = UILabel()
        label.text = "Weight : "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let fullNamelbl: UILabel = {
        let label = UILabel()
        label.text = "Weight : "
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
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
    
    private let calculateButton: UIButton = {
           let button = UIButton()
           button.setTitle("Calculate BMI", for: .normal)
           button.backgroundColor = .systemBlue
           button.layer.cornerRadius = 5
           button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(calculateButtonTapped), for: .touchUpInside)
           return button
       }()
    
    private let profileViewButton: UIButton = {
           let button = UIButton()
           button.setTitle("View", for: .normal)
           button.backgroundColor = .systemBlue
           button.layer.cornerRadius = 5
           button.translatesAutoresizingMaskIntoConstraints = false
           button.addTarget(self, action: #selector(profileViewBtnTapped), for: .touchUpInside)
           return button
       }()
       
       private let resultLabel: UILabel = {
           let label = UILabel()
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
        super.viewDidLoad()
            
        print("Passed Profile userData: \(userData)")
        
        navigationItem.hidesBackButton = true
                
        view.backgroundColor = .darkGray
        
        // add UI elements to view
        view.addSubview(userNamelbl)
        view.addSubview(emaillbl)
        view.addSubview(fullNamelbl)
        view.addSubview(calculateButton)
        view.addSubview(profileViewButton)
//        view.addSubview(resultLabel)
        
        // set constraints
        NSLayoutConstraint.activate([
            
            profileViewButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2),
            calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileViewButton.widthAnchor.constraint(equalToConstant: 360),
            profileViewButton.heightAnchor.constraint(equalToConstant: 40),
            
            calculateButton.topAnchor.constraint(equalTo: profileViewButton.bottomAnchor, constant: 15),
            calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calculateButton.widthAnchor.constraint(equalToConstant: 360),
            calculateButton.heightAnchor.constraint(equalToConstant: 40),
            
            userNamelbl.topAnchor.constraint(equalTo: calculateButton.bottomAnchor, constant: 50),
            userNamelbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            emaillbl.topAnchor.constraint(equalTo: userNamelbl.bottomAnchor, constant: 50),
            emaillbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            fullNamelbl.topAnchor.constraint(equalTo: emaillbl.bottomAnchor, constant: 50),
            fullNamelbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
         
//
//            heightTextField.topAnchor.constraint(equalTo: heightlbl.topAnchor),
//            heightTextField.leadingAnchor.constraint(equalTo: heightlbl.trailingAnchor, constant: 10),
//            heightTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//
//            weightlbl.topAnchor.constraint(equalTo: heightTextField.bottomAnchor, constant: 50),
//            weightlbl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//
//            weightTextField.topAnchor.constraint(equalTo: weightlbl.topAnchor),
//            weightTextField.leadingAnchor.constraint(equalTo: weightlbl.trailingAnchor, constant: 10),
//            weightTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//
////            submitButton.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 20),
////            submitButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
////            submitButton.widthAnchor.constraint(equalToConstant: 100),
////            submitButton.heightAnchor.constraint(equalToConstant: 50),
//            calculateButton.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 30),
//            calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            calculateButton.widthAnchor.constraint(equalToConstant: 150),
//            calculateButton.heightAnchor.constraint(equalToConstant: 40),
//
//            resultLabel.topAnchor.constraint(equalTo: calculateButton.bottomAnchor, constant: 30),
//            resultLabel.leadingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
//            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        userNamelbl.text = userData.userName
        emaillbl.text = userData.email
        fullNamelbl.text = userData.fullName
//        calculateButton.addTarget(self, action: #selector(calculateButtonTapped), for: .touchUpInside)
    }
    
    @objc func calculateButtonTapped(_ sender:UIButton) {
        let detailViewController = CalculateBMIVewController()
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
    @objc func profileViewBtnTapped(_ sender:UIButton) {
        let detailViewController = UserDataViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}




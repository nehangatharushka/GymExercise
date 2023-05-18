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
    
    let heightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your height"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let weightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your weight"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let ageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your age"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let fitnessGoalTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your fitness goal"
        textField.borderStyle = .roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        heightTextField.delegate = self
        weightTextField.delegate = self
        ageTextField.delegate = self
        fitnessGoalTextField.delegate = self

        view.addSubview(heightTextField)
        view.addSubview(weightTextField)
        view.addSubview(ageTextField)
        view.addSubview(fitnessGoalTextField)
        
        setConstraints()
    }
    
    func setConstraints() {
        NSLayoutConstraint.activate([
            heightTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            heightTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heightTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            weightTextField.topAnchor.constraint(equalTo: heightTextField.bottomAnchor, constant: 20),
            weightTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weightTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            ageTextField.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 20),
            ageTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            ageTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            fitnessGoalTextField.topAnchor.constraint(equalTo: ageTextField.bottomAnchor, constant: 20),
            fitnessGoalTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fitnessGoalTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8)
        ])
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

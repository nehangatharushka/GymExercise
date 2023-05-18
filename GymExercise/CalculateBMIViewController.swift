//
//  CalculateBMIViewController.swift
//  GymExercise
//
//  Created by Ravindu Dananjaya on 2023-05-17.
//

import UIKit
//import Alamofire

class CalculateBMIVewController : UIViewController {

    private let titlelbl: UILabel = {
        let label = UILabel()
        label.text = "Calculate Your BMI"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
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
        
        let calculateButton: UIButton = {
            let button = UIButton()
            button.setTitle("Calculate BMI", for: .normal)
            button.backgroundColor = .blue
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        let resultLabel: UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.textAlignment = .center
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
        view.addSubview(titlelbl)
        view.backgroundColor = .white
        view.addSubview(weightTextField)
        view.addSubview(heightTextField)
        view.addSubview(calculateButton)
        view.addSubview(resultLabel)
       
        calculateButton.addTarget(self, action: #selector(calculateBMI), for: .touchUpInside)
       
        setupConstraints()
        
    }
    
    func setupConstraints(){
        
        NSLayoutConstraint.activate([

            titlelbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 1),
            titlelbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            weightTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            weightTextField.topAnchor.constraint(equalTo: titlelbl.bottomAnchor, constant: 50),
            weightTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
           
            heightTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            heightTextField.topAnchor.constraint(equalTo: weightTextField.bottomAnchor, constant: 20),
            heightTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
           
            calculateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            calculateButton.topAnchor.constraint(equalTo: heightTextField.bottomAnchor, constant: 20),
           
            resultLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            resultLabel.topAnchor.constraint(equalTo: calculateButton.bottomAnchor, constant: 20),
            resultLabel.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
        ])
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
            // You can call your POST API here to submit the plan and the BMI
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

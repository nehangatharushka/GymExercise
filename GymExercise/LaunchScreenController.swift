//
//  LaunchScreenController.swift
//  GymExercise
//
//  Created by Ravindu Dananjaya on 2023-05-14.
//

import UIKit

class LanunchScreenController : UIViewController {
    
    private let labelOne: UILabel = {
        let label = UILabel()
        label.text = "Your Peronal Free"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .monospacedSystemFont(ofSize: 24, weight: .bold)
        label.textColor = .white
        label.backgroundColor = .black
        return label
    }()
    
    private let labelTwo: UILabel = {
        let label = UILabel()
        label.text = "GYM Center"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .monospacedSystemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.backgroundColor = .black
        label.textColor = .white
        return label
    }()
    
    private let signIn: UIButton = {
        let button = UIButton()
        button.setTitle("Already Have an Account , SignIn", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signInTap), for: .touchUpInside)
        button.backgroundColor = .black
        return button
    }()
    
    private let nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("Next", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = UIColor(red: 10/255, green: 207/255, blue: 131/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Image")
        backgroundImage.contentMode =  UIView.ContentMode.scaleAspectFill

        // Add the UIImageView as a subview
        self.view.insertSubview(backgroundImage, at: 0)
        
        super.viewDidLoad()
        setupUI()
    }
    func setupUI(){
        view.backgroundColor = .blue
        view.addSubview(labelOne)
        view.addSubview(labelTwo)
        view.addSubview(nextButton)
        view.addSubview(signIn)
        
        NSLayoutConstraint.activate([
        
            labelOne.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 560),
            labelOne.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 25),
            labelOne.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 20),
            
            labelTwo.topAnchor.constraint(equalTo: labelOne.bottomAnchor,constant: 10),
            labelTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 25),
            labelTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: 20),
            
            nextButton.topAnchor.constraint(equalTo: labelTwo.bottomAnchor,constant: 10),
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.widthAnchor.constraint(equalToConstant: 350),
            nextButton.heightAnchor.constraint(equalToConstant: 50),
            
            signIn.topAnchor.constraint(equalTo: nextButton.bottomAnchor,constant: 10),
            signIn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            signIn.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
                        
    @objc func buttonTapped(_ sender:UIButton) {
            let detailViewController = RegisterViewController()
            navigationController?.pushViewController(detailViewController, animated: true)
        }
                        
    @objc func signInTap(_ sender:UIButton) {
            let detailViewController = SignInController()
            navigationController?.pushViewController(detailViewController, animated: true)
        }
}

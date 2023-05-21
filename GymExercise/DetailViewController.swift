//
//  DetailViewController.swift
//  GymExercise
//
//  Created by Developer on 2023-05-20.
//

//import UIKit
//import AVKit
//
//class DetailViewController: UIViewController {
//    var exercise: Exercise?
//
//    private var playerViewController: AVPlayerViewController?
//
//    private let repCountLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    private let setCountLabel: UILabel = {
//        let label = UILabel()
//        label.translatesAutoresizingMaskIntoConstraints = false
//        return label
//    }()
//
//    // Add more labels as needed...
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.backgroundColor = .white
//        setupPlayer()
//        setupLabels()
//
//        if let exercise = exercise {
//            // TODO: Replace these with actual properties from your `Exercise` struct
//            repCountLabel.text = "Reps: 2"
//            setCountLabel.text = "Sets: 4"
//        }
//    }
//
//    func setupPlayer() {
//        // Your existing `setupPlayer` method...
//    }
//
//    func setupLabels() {
//        view.addSubview(repCountLabel)
//        view.addSubview(setCountLabel)
//
//        NSLayoutConstraint.activate([
//            repCountLabel.topAnchor.constraint(equalTo: playerViewController?.view.bottomAnchor ?? view.topAnchor, constant: 20),
//            repCountLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//
//            setCountLabel.topAnchor.constraint(equalTo: repCountLabel.bottomAnchor, constant: 20),
//            setCountLabel.leadingAnchor.constraint(equalTo: repCountLabel.leadingAnchor),
//        ])
//    }
//}
//
//
import UIKit
import WebKit

class DetailViewController: UIViewController {
    
    var exerciseName: String?
    let userData: UserData
    var webView: WKWebView!
    var weightLabel: UILabel!
    var timeLabel: UILabel!
    var setLabel: UILabel!
    var repsLabel: UILabel!

//    let completedBtn: UIButton = {
//        let button = UIButton()
//        button.setTitle("Completed ", for: .normal)
//        button.backgroundColor = .blue
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    private let completedBtn: UIButton = {
        let button = UIButton()
        button.setTitle("  Completed Task  ", for: .normal)
        button.backgroundColor = UIColor(red: 10/255, green: 207/255, blue: 131/255, alpha: 1)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
        
        let exerciseLabel = UILabel()
        exerciseLabel.text = exerciseName
        exerciseLabel.textAlignment = .center
        exerciseLabel.textColor = UIColor(red: 10/255, green: 207/255, blue: 131/255, alpha: 1)

        weightLabel = UILabel()
        timeLabel = UILabel()
        setLabel = UILabel()
        repsLabel = UILabel()
        
        setLabel.textColor = UIColor(red: 10/255, green: 207/255, blue: 131/255, alpha: 1)
        repsLabel.textColor = UIColor(red: 10/255, green: 207/255, blue: 131/255, alpha: 1)
        timeLabel.textColor = UIColor(red: 10/255, green: 207/255, blue: 131/255, alpha: 1)
        weightLabel.textColor = UIColor(red: 10/255, green: 207/255, blue: 131/255, alpha: 1)

        let stackView1 = UIStackView(arrangedSubviews: [exerciseLabel, weightLabel, timeLabel])
        stackView1.axis = .horizontal
        stackView1.distribution = .equalSpacing
        stackView1.translatesAutoresizingMaskIntoConstraints = false

        let stackView2 = UIStackView(arrangedSubviews: [setLabel, repsLabel])
        stackView2.axis = .horizontal
        stackView2.distribution = .equalSpacing
        stackView2.translatesAutoresizingMaskIntoConstraints = false

        webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)

        view.addSubview(stackView1)
        view.addSubview(stackView2)
        view.addSubview(completedBtn)
        
        completedBtn.addTarget(self, action: #selector(completedBtnFunc), for: .touchUpInside)

        // Constraints for webView and stackViews
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            webView.heightAnchor.constraint(equalToConstant: view.bounds.height / 3),

            stackView1.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: 50),
            stackView1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),

            stackView2.topAnchor.constraint(equalTo: stackView1.bottomAnchor, constant: 20),
            stackView2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            completedBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            completedBtn.topAnchor.constraint(equalTo: stackView2.bottomAnchor, constant: 20),
        
        ])

        // Fetch data from API
        fetchData()
    }
    
    @objc func completedBtnFunc(){
        
        let endpoint = URL(string: "http://localhost:8080/completed/insertCompleted")!
        
        let parameters: [String: Any] = [
            "userName": userData.userName,
            "name":exerciseName,
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
                      
                        DispatchQueue.main.async {
                            
                            let alert = UIAlertController(title: "Success", message: "Thank You For Completed Today Task", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                                
                                let nextVC = HomeTabBarController(userData: self.userData)
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

    func fetchData() {
        
        let endpoint = URL(string: "http://localhost:8080/exercise/SelectExercise")!
        
        let parameters: [String: Any] = [
            "name": exerciseName,
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
    
    func updateTextBoxes(data:Data){
        do {
            let exercise = try JSONDecoder().decode(Exercise.self, from: data)
            //weightLabel.text =  "Weight : \(exercise.weight)"
            if let weight = exercise.weight {
                weightLabel.text = "Weight: \(weight)"
            } else {
                weightLabel.text = "Weight: N/A" // or any default value
            }
            if let time = exercise.time {
                timeLabel.text = "Time (s): \(time)"
            } else {
                timeLabel.text = "Time (s): N/A" // or any default value
            }
           // timeLabel.text = exercise.time
            //setLabel.text = exercise.set
            if let set = exercise.set {
                setLabel.text = "Set : \(set)"
            } else {
                setLabel.text = "Set : N/A" // or any default value
            }
            // repsLabel.text = exercise.reps
            if let rep = exercise.set {
                repsLabel.text = "Rep : \(rep)"
            } else {
                repsLabel.text = "Rep : N/A" // or any default value
            }
            
            if let youtubeURL = URL(string: exercise.url!) {
                 webView.load(URLRequest(url: youtubeURL))
             }
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
}





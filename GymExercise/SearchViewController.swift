//
//  SearchViewController.swift
//  GymExercise
//
//  Created by Ravindu Dananjaya on 2023-05-16.
//

import UIKit

class SearchViewController : UITabBarController, UITableViewDataSource, UITableViewDelegate {
    
    private let tableView: UITableView = {
            let tableView = UITableView()
            tableView.translatesAutoresizingMaskIntoConstraints = false
            return tableView
        }()

     private var exercises: [String] = []
    
    private let ScheduleBtn : UIButton = {
        let button = UIButton()
        button.setTitle("Set", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(navigateSchedule), for: .touchUpInside)
        button.backgroundColor = UIColor(red: 10/255, green: 207/255, blue: 131/255, alpha: 1)
        return button
    }()
    
    private let time: UILabel = {
        let label = UILabel()
        label.text = "Time"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        return label
    }()
    
    private let timereturn: UILabel = {
        let label = UILabel()
        label.text = "10.30"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let suggesttimelbl: UILabel = {
        let label = UILabel()
        label.text = "My Current Schedule"
        label.textColor = UIColor(red: 10/255, green: 207/255, blue: 131/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
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
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)

       view.addSubview(tableView)
        
        navigationItem.hidesBackButton = true
        
        view.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
                
        view.addSubview(suggesttimelbl)
        view.addSubview(ScheduleBtn)
        view.addSubview(time)
        view.addSubview(timereturn)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            ScheduleBtn.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            ScheduleBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 340),
            ScheduleBtn.widthAnchor.constraint(equalToConstant: 160),
            ScheduleBtn.heightAnchor.constraint(equalToConstant: 50),
            
            suggesttimelbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            suggesttimelbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            suggesttimelbl.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            suggesttimelbl.leadingAnchor.constraint(equalTo: ScheduleBtn.trailingAnchor, constant: 20),
        
            
            time.topAnchor.constraint(equalTo: suggesttimelbl.bottomAnchor, constant: 20),
            time.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            time.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            timereturn.topAnchor.constraint(equalTo: time.bottomAnchor, constant: 5),
            timereturn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            timereturn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            tableView.topAnchor.constraint(equalTo: timereturn.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: 20),
           tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
//            ScheduleBtn.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 10),
//            ScheduleBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            ScheduleBtn.widthAnchor.constraint(equalToConstant: 250),
//            ScheduleBtn.heightAnchor.constraint(equalToConstant: 50),

           
        ])
        fetchData()
        
    }
    
    func fetchData() {
        
        let endpoint = URL(string: "http://localhost:8080/completed/getCompleted")!
        
        let parameters: [String: Any] = [
            "userName": userData.userName
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
                        let items = try JSONDecoder().decode([Completed].self, from: data)
                        self.exercises = items.map { $0.name }
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    } catch {
                        print("Error: \(error)")
                    }
                }
           
            }
           
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return exercises.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let exercise = exercises[indexPath.row]
            cell.textLabel?.text = "\(exercise) | Completed"
            cell.textLabel?.textColor = .green
            return cell
        }
    
    
    @objc func navigateSchedule() {
        let detailViewController = ScheduleViewController(userData:userData)
            navigationController?.pushViewController(detailViewController, animated: true)
        }
    
}


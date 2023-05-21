//
//  ScheduleViewController.swift
//  GymExercise
//
//  Created by Developer on 2023-05-21.
//

import UIKit

class ScheduleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    let daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
    var selectedDays = Set<String>()
    let datePicker = UIDatePicker()
    let tableView = UITableView()

    var userData: UserData
    
    init(userData: UserData) {
        self.userData = userData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let mylbl: UILabel = {
        let label = UILabel()
        label.text = "Select Time"
        label.textColor = UIColor(red: 10/255, green: 207/255, blue: 131/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.numberOfLines = 0 // Allow the label to use as many lines as needed
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let mylbl2: UILabel = {
        let label = UILabel()
        label.text = "& Days , You Can Exercise"
        label.textColor = UIColor(red: 10/255, green: 207/255, blue: 131/255, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        label.numberOfLines = 0 // Allow the label to use as many lines as needed
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(red: 238/255, green: 238/255, blue: 238/255, alpha: 1)
        view.addSubview(mylbl)
        view.addSubview(mylbl2)
        datePicker.datePickerMode = .time
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.backgroundColor = UIColor(red: 10/255, green: 207/255, blue: 131/255, alpha: 1)
        //datePicker.sizeToFit(18)
        view.addSubview(datePicker)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tintColor = UIColor(red: 10/255, green: 207/255, blue: 131/255, alpha: 1)
        view.addSubview(tableView)
        
        let saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.backgroundColor = UIColor(red: 10/255, green: 207/255, blue: 131/255, alpha: 1)
        saveButton.tintColor = .white
        view.addSubview(saveButton)
        
        NSLayoutConstraint.activate([
            
            mylbl.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mylbl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            mylbl2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mylbl2.topAnchor.constraint(equalTo: mylbl.bottomAnchor , constant: 2),
            
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.topAnchor.constraint(equalTo: mylbl2.bottomAnchor, constant: 30),
            
            tableView.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 30),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.heightAnchor.constraint(equalToConstant: 300),
            
            saveButton.topAnchor.constraint(equalTo: tableView.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return daysOfWeek.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = daysOfWeek[indexPath.row]
        if selectedDays.contains(daysOfWeek[indexPath.row]) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedDay = daysOfWeek[indexPath.row]
        if selectedDays.contains(selectedDay) {
            selectedDays.remove(selectedDay)
        } else {
            selectedDays.insert(selectedDay)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    @objc func saveButtonTapped() {
        let selectedTime = datePicker.date
        saveSchedule(days: selectedDays, time: selectedTime)
    }
    
    func saveSchedule(days: Set<String>, time: Date) {
        // save the selected days and time to your database here
        print(days)
        print(time)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm" // ISO 8601 format
        let timeString = dateFormatter.string(from: time)
        
        let daysArray = Array(days)
        
        let endpoint = URL(string: "http://localhost:8080/user/SaveDateTime")!
        
        let Scheduleparameters: [String: Any] = [
            "_id":userData._id,
            "userName": userData.userName,
            "fullName":userData.fullName,
            "email":userData.email,
            "height": userData.height ,
            "weight":userData.weight ,
            "age":userData.age ,
            "fitnessGoal":userData.fitnessGoal ,
            "days":daysArray,
            "time":timeString
        ]
        
        // Create the request object
        var request = URLRequest(url: endpoint)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        // Convert the parameters to JSON data and set it as the request body
        do {
            print(Scheduleparameters)
            request.httpBody = try JSONSerialization.data(withJSONObject: Scheduleparameters)
            //request.httpBody = try JSONSerialization.data(withJSONObject: Scheduleparameters)
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
//                        let userData = try JSONDecoder().decode(UserData.self, from: data)
                        let userData = try JSONDecoder().decode(UserData.self, from: data)
                      
                        DispatchQueue.main.async {
                            
                            let alert = UIAlertController(title: "Success", message: "Updated Schedule", preferredStyle: .alert)
                            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                            
                            let nextVC = HomeTabBarController(userData: userData)
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
}

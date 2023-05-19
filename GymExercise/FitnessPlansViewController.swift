//
//  FitnessPlansViewController.swift
//  GymExercise
//
//  Created by Developer on 2023-05-19.
//

import UIKit

class FitnessPlanViewController : UIViewController {
 
    let plans: [FitnessPlan]
    
    init(plans: [FitnessPlan]) {
        self.plans = plans
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        view.backgroundColor = .blue
    }
}

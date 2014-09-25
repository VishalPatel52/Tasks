//
//  AddTaskViewController.swift
//  Complete Tasks
//
//  Created by Vishal Patel on 24/09/14.
//  Copyright (c) 2014 Vishal Patel. All rights reserved.
//

import Foundation
import UIKit

class AddTaskViewController:UIViewController {
    
    @IBOutlet weak var addTaskLabel: UITextField!
    @IBOutlet weak var addSubtaskLabel: UITextField!
    @IBOutlet weak var addNewtaskDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    println("AddNewTaskViewController is loaded")
    }
    
    
}
//
//  TaskDetailViewController.swift
//  Complete Tasks
//
//  Created by Vishal Patel on 23/09/14.
//  Copyright (c) 2014 Vishal Patel. All rights reserved.
//

import Foundation
import UIKit

class TaskDetailViewController:UIViewController {
    
    @IBOutlet weak var taskFieldLabel: UITextField!
    @IBOutlet weak var subTaskFieldLabel: UITextField!
    @IBOutlet weak var dueDatePicker: UIDatePicker!
       
    
    var detailTaskModel:TaskModel!
    
    
    //load view
    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskFieldLabel.text = detailTaskModel.task
        subTaskFieldLabel.text = detailTaskModel.subTask
        dueDatePicker.date = detailTaskModel.date
        
    }
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
    }
    
}
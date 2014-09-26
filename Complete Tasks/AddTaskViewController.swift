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
    
    //initialise a instance of UIViewController for pasing UIViewController data from TaskViewController to AddTaskViewController (this controller)
    
    var mainVC:ViewController!
    
    @IBOutlet weak var addTaskLabel: UITextField!
    @IBOutlet weak var addSubtaskLabel: UITextField!
    @IBOutlet weak var addNewtaskDatePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    println("AddNewTaskViewController is loaded")
    }
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func addTaskButtonPressed(sender: UIButton) {
        
        var newTask:TaskModel = TaskModel(task: addTaskLabel.text, subTask: addSubtaskLabel.text, date: addNewtaskDatePicker.date, completed: false)
        mainVC.baseArray[0].append(newTask)
        
        self.dismissViewControllerAnimated(true, completion: nil)
        mainVC.tableView.reloadData()

        
    }
}
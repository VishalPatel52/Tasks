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
    
    /*Add a property named mainVC that is of type ViewController.
    load view*/
    //var mainVC:ViewController! no longer needed due use of fetchResultsController using CoreData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.taskFieldLabel.text = detailTaskModel.task
        self.subTaskFieldLabel.text = detailTaskModel.subTask
        self.dueDatePicker.date = detailTaskModel.date
        
    }
    
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func saveButtonPressed(sender: UIBarButtonItem) {
        /*We want to create the task, and then instead of adding the task to our array, we are going to replace the one we are editing with the edited task.*/
        //A temporary task created for was updated by user at detailViewController
        //var thisTask = TaskModel(task: taskFieldLabel.text, subTask: subTaskFieldLabel.text, date: dueDatePicker.date, completed:false)
        //and now update the taskArray with updated task
        //mainVC.baseArray[0][mainVC.tableView.indexPathForSelectedRow()!.row] = thisTask
        //mainVC.tableView.reloadData()
        
        //using CoreData
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        detailTaskModel.task = taskFieldLabel.text
        detailTaskModel.subTask = subTaskFieldLabel.text
        detailTaskModel.date = dueDatePicker.date
        detailTaskModel.completed = detailTaskModel.completed
        
        
        //change back to main task controller view with save button pressed
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
}
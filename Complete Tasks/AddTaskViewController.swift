//
//  AddTaskViewController.swift
//  Complete Tasks
//
//  Created by Vishal Patel on 24/09/14.
//  Copyright (c) 2014 Vishal Patel. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AddTaskViewController:UIViewController, UITextFieldDelegate {
    
    //initialise a instance of UIViewController for pasing UIViewController data from TaskViewController to AddTaskViewController (this controller)
    
    //var mainVC:ViewController! no logner needed due to fetchResultsController using CoreDate
    
    @IBOutlet weak var addTaskLabel: UITextField!
    @IBOutlet weak var addSubtaskLabel: UITextField!
    @IBOutlet weak var addNewtaskDatePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func cancelButtonPressed(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func addTaskButtonPressed(sender: UIButton) {
        //Start getting access to appdelegate via defining an instance
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        
        //use appDelegate to access out ManageObjectContext --> a property defined in AppDelegate
        let managedObjectContext = appDelegate.managedObjectContext
        
        //Next, we create an NSEntityDescription instance using the name of our Entity, which is TaskModel and the managedObjectContext from our AppDelegate.
        let entityDescription = NSEntityDescription.entityForName("TaskModel", inManagedObjectContext: managedObjectContext!)
        
        //Now we can create a TaskModel instance. The new function for creation takes 2 parameters. The first is the entityDescription instance we just created, and the second is the managedObjectContext from our AppDelegate.
        let task = TaskModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        
        //We then can update our Task instance's properties using the information from our TextFields and DatePicker.
        task.task = addTaskLabel.text
        task.subTask = addSubtaskLabel.text
        task.date = addNewtaskDatePicker.date
        task.completed = false
        
        //we need to save the changes to CoreData by calling the function saveContext()
        appDelegate.saveContext()
        
        //To make sure this worked, we can use a fetchRequest to view all of the items from coreData.
        
        var request = NSFetchRequest(entityName: "TaskModel")
        var error:NSError? = nil
        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        for res in results {
            println(res)
        }
        
        //Finally we need to close the view and come back to main tableview
        self.dismissViewControllerAnimated(true, completion: nil)
        
        

    }
}
//
//  ViewController.swift
//  Complete Tasks
//
//  Created by Vishal Patel on 23/09/14.
//  Copyright (c) 2014 Vishal Patel. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    // manageObjectContext and fetchResultController for coreData
    
    let manageObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    
    var fetchRequestsController: NSFetchedResultsController = NSFetchedResultsController()
    
    
    var baseArray:[[TaskModel]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //prepare for segue 
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // here we pass the task information to the detail view controller
        
        if segue.identifier == "showTaskDetail" {
            // set detailVC as our destination view controller
            let detailVC:TaskDetailViewController = segue.destinationViewController as TaskDetailViewController
            
            // get the index of the row that the user clicked on
            let indexPath = self.tableView.indexPathForSelectedRow()
            
            // put the data of the task at that index into the thisTask variable
            let currentTask = baseArray[indexPath!.section][indexPath!.row]
            
            // finally, set the detailTaskModel variable (which we created in the TaskDetailViewController file) to thisTask
            detailVC.detailTaskModel = currentTask
            detailVC.mainVC = self
        }
        else if segue.identifier == "showAddTask" {
            let addTaskVC:AddTaskViewController = segue.destinationViewController as AddTaskViewController
            
            addTaskVC.mainVC = self
        }
    }
    
    
    /*We are overriding the viewDidAppear function, which will be called each time the view is presented on the screen. This is different then viewDidLoad which is only called the first time a given ViewController (in this case, the main ViewController) is created. Next, we call the viewDidAppear function on the keyword super, which implements the viewDidAppear functionality from the main ViewController's super classes implementation of viewDidAppear. In effect, we get access to the default functionality of viewDidAppear for free. Finally, we call the function reloadData on the the tableView. This function causes the tableView to recall it's dataSource functions and repopulate the tableView with the updated array.*/
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //sorting tasks by date everytime new is added or existing task is changed
        baseArray[0] = baseArray[0].sorted({ (T1:TaskModel, T2:TaskModel) -> Bool in
            return T1.date.timeIntervalSince1970 < T2.date.timeIntervalSince1970
        })
        self.tableView.reloadData()
        
    }
    
    
    // fuction for sorting tasks by date
    func sortTaskByDate (taskOne:TaskModel, taskTwo:TaskModel) -> Bool {
        return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
    }
    
    /* UITableViewDataSource
    follwing two methods are implemented due to protocols and delegate of the TableView (UITableViewDelegate and UITableViewDataSource )*/
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return baseArray.count // actually 2 sections: one section for not completed tasks and other for completed tasks
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return baseArray[section].count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        
        let currentTask = baseArray[indexPath.section][indexPath.row]
        
        //accessing dictionary suing keys
//        cell.taskLabel.text = taskDict["task"]
//        cell.taskDetailLabel.text = taskDict["subtask"]
//        cell.dateLabel.text = taskDict["date"]
        
        cell.taskLabel.text = currentTask.task
        cell.taskDetailLabel.text = currentTask.subTask
        cell.dateLabel.text = Date.toString(date: currentTask.date)
        
        return cell
    }
    
    //UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //print line to check which row in the tableview is pressed
        println("\(indexPath.section) \(indexPath.row)")
        
        //opening a TaskDetailViewController view using defined segue
        
        self.performSegueWithIdentifier("showTaskDetail", sender: self)
        
    }
    
    /* functions for sections*/
    //height for header of the section
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "To Do:"
        }
        else {
            return "Completed:"
        }
    }

    
    /*We want to allow the user to swipe a task to mark it as complete. We’ll do that using another tableview delegate and replace our incomplete task with a complete one.
We'll use the function commitEditingStyle, to detect the delete button being tapped when cells are swiped. Once we detect the delete button tapped, we will first determine which TaskModel was being swiped on. Then we create a new TaskModel using the properties from the current TaskModel and set its' completion to true. After we remove the original TaskModel from the baseArray, insert the new TaskModel into the baseArray's completed Array. Finally, we call reloadData on our TableView, to display the updates to our baseArray.*/
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let thisTask = baseArray[indexPath.section][indexPath.row]
        
        if indexPath.section == 0 {
            var completeTask = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, completed: true)
            baseArray[1].append(completeTask)
        }
        else {
            var notCompleteTask = TaskModel(task: thisTask.task, subTask: thisTask.subTask, date: thisTask.date, completed: false)
            baseArray[0].append(notCompleteTask)
        }

        baseArray[indexPath.section].removeAtIndex(indexPath.row)
        tableView.reloadData()
        
    }
    
    
    //Helper function 
    
    func taskFetchRequest() -> NSFetchRequest {
        let fetchRequst = NSFetchRequest(entityName: "TaskModel")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        fetchRequst.sortDescriptors = [sortDescriptor]
        return fetchRequst
    }
    


}


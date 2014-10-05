//
//  ViewController.swift
//  Complete Tasks
//
//  Created by Vishal Patel on 23/09/14.
//  Copyright (c) 2014 Vishal Patel. All rights reserved.
//


import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    
    // manageObjectContext and fetchResultController for coreData
    
    let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext! //directly getting managedObjects from AppDelegate
    
    var fetchRequestsController: NSFetchedResultsController = NSFetchedResultsController() //Fetch request  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor(red: (48/255), green: (123/255), blue: (27/255), alpha: 1)
        
        //fetchRequest
        fetchRequestsController = getFetchRequest()
        fetchRequestsController.delegate = self
        fetchRequestsController.performFetch(nil)

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
            
            // put the data of the task at that index into the thisTask coreData Taskmodel
            let currentTask = fetchRequestsController.objectAtIndexPath(indexPath!) as TaskModel
            
            // finally, set the detailTaskModel variable (which we created in the TaskDetailViewController file) to thisTask
            detailVC.detailTaskModel = currentTask
        }
        else if segue.identifier == "showAddTask" {
            let addTaskVC:AddTaskViewController = segue.destinationViewController as AddTaskViewController
            
        }
    }
    
    
    /*We are overriding the viewDidAppear function, which will be called each time the view is presented on the screen. This is different then viewDidLoad which is only called the first time a given ViewController (in this case, the main ViewController) is created. Next, we call the viewDidAppear function on the keyword super, which implements the viewDidAppear functionality from the main ViewController's super classes implementation of viewDidAppear. In effect, we get access to the default functionality of viewDidAppear for free. Finally, we call the function reloadData on the the tableView. This function causes the tableView to recall it's dataSource functions and repopulate the tableView with the updated array. This is no longer needed due to CoreData implementation, which takes care of sorting*/
    
    /*override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //sorting tasks by date everytime new is added or existing task is changed
        baseArray[0] = baseArray[0].sorted({ (T1:TaskModel, T2:TaskModel) -> Bool in
            return T1.date.timeIntervalSince1970 < T2.date.timeIntervalSince1970
        })
        self.tableView.reloadData()
        
    }*/
    
    
    // fuction for sorting tasks by date
    func sortTaskByDate (taskOne:TaskModel, taskTwo:TaskModel) -> Bool {
        return taskOne.date.timeIntervalSince1970 < taskTwo.date.timeIntervalSince1970
    }
    
    /* UITableViewDataSource
    follwing two methods are implemented due to protocols and delegate of the TableView (UITableViewDelegate and UITableViewDataSource )*/
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return fetchRequestsController.sections!.count // actually 2 sections: one section for not completed tasks and other for completed tasks
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return fetchRequestsController.sections![section].numberOfObjects
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        
        let currentTask = fetchRequestsController.objectAtIndexPath(indexPath) as TaskModel
        
        
        // changing tableview cell color
        
        if indexPath.row%2 == 0 {
            cell.backgroundColor = UIColor.clearColor()
        }
        
        else {
            cell.backgroundColor = UIColor.clearColor()
        }
        
        
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

        
        //opening a TaskDetailViewController view using defined segue
        
        self.performSegueWithIdentifier("showTaskDetail", sender: self)
        
    }
    
    /* functions for sections*/
    //height for header of the section
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            
            return "To Do:"
        }
        else {
            return "Completed:"
        }
    }
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String! {
        
        if indexPath.section == 0 {
            return "Done"
        }
        else {
            return "Delete"

        }
    }
    // NSFetchedResultsControllerDelegate
    /*We need to implement the function controllDidChangeContext. This function is called when the NSFetchedResults controller detects changes made in the CoreData stack. Each time it detects changes, we want to reload the information in the tableView. This is easier then having to call reload ourselves throught the ViewController.*/
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    /*We want to allow the user to swipe a task to mark it as complete. We’ll do that using another tableview delegate and replace our incomplete task with a complete one.
    We'll use the function commitEditingStyle, to detect the delete button being tapped when cells are swiped. Once we detect the delete button tapped, we will first determine which TaskModel was being swiped on. Then we create a new TaskModel using the properties from the current TaskModel and set its' completion to true. After we remove the original TaskModel from the baseArray, insert the new TaskModel into the baseArray's completed Array. Finally, we call reloadData on our TableView, to display the updates to our baseArray.*/
    
    /*
    * call this function to add more options when user swipes the tableview cell
    */
    
    //    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
    //        let deleteClosure = { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
    //            println("Delete closure called")
    //        }
    //
    //        let moreClosure = { (action: UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
    //            println("More closure called")
    //        }
    //
    //        let deleteAction = UITableViewRowAction(style: .Default, title: "Delete", handler: deleteClosure)
    //        let moreAction = UITableViewRowAction(style: .Normal, title: "More", handler: moreClosure)
    //
    //        return [deleteAction, moreAction]
    //    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        let thisTask = fetchRequestsController.objectAtIndexPath(indexPath) as TaskModel

        if indexPath.section == 0 {
            thisTask.completed = true
        }
        else {
            //thisTask.completed = false
            if editingStyle == UITableViewCellEditingStyle.Delete {
                /*
                * here comes the delete row from tableview
                */
                
                if let tv = self.tableView {
                    managedObjectContext.deleteObject(thisTask as NSManagedObject)
                    tv.reloadData()
                }
                else {
                    var error:NSError? = nil
                    if !managedObjectContext.save(&error){
                        abort()
                    }
                }
            }
            
        }
        
    
        
        //access to AppDelegate instance via (UIApplication.sharedApplication().delegate as AppDelegate)
        (UIApplication.sharedApplication().delegate as AppDelegate).saveContext()
        
    }
 
 
    
    
    
    //Helper function 
    
    func taskFetchRequest() -> NSFetchRequest {
        let fetchRequst = NSFetchRequest(entityName: "TaskModel")
        let sortDescriptor = NSSortDescriptor(key: "date", ascending: true)
        let completedSortDesciptor = NSSortDescriptor(key: "completed", ascending: true)
        fetchRequst.sortDescriptors = [completedSortDesciptor, sortDescriptor]
        return fetchRequst
    }
    

    func getFetchRequest() -> NSFetchedResultsController {
        
        fetchRequestsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: managedObjectContext, sectionNameKeyPath: "completed", cacheName: nil)
        return fetchRequestsController
    }
}



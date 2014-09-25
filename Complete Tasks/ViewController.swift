//
//  ViewController.swift
//  Complete Tasks
//
//  Created by Vishal Patel on 23/09/14.
//  Copyright (c) 2014 Vishal Patel. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    
    //Create emptey of Dictionary for holding different tasks
    
    var taskArray:[TaskModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        // defining tasks with Dictionary
//        let task1:Dictionary<String, String> = ["task":"fill up forms for the passport", "subtask":"print form", "date":"01/12/2014"]
//        let task2:Dictionary<String, String> = ["task":"buy medicine","subtask":"get the prescription", "date":"21/11/2014"]
//        let task3:Dictionary<String, String> = ["task":"finish project", "subtask":"prepare documentation", "date":"30/09/2014"]

        println("TEST")

        var date1 = Date.from(year: 2015, month: 12, day: 11)
        var date2 = Date.from(year: 2014, month: 09, day: 30)
        var date3 = Date.from(year: 2014, month: 11, day: 25)

        let task1 = TaskModel(task: "get food", subTask: "cook it first", date: date1)
        let task2 = TaskModel(task: "buy medicine", subTask:"print fasdf", date:date2)
        let task3 = TaskModel(task: "go to pub", subTask: "drink beer", date:date3)
        
        taskArray = [task1, task2, task3]
        
        tableView.reloadData()
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
            let currentTask = taskArray[indexPath!.row]
            
            // finally, set the detailTaskModel variable (which we created in the TaskDetailViewController file) to thisTask
            detailVC.detailTaskModel = currentTask
        }
    }
    
    
    // follwing two methods are implemented due to protocols and delegate of the TableView (UITableViewDelegate and UITableViewDataSource )
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return taskArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:TaskCell = tableView.dequeueReusableCellWithIdentifier("myCell") as TaskCell
        
        let currentTask = taskArray[indexPath.row]
        
        //accessing dictionary suing keys
//        cell.taskLabel.text = taskDict["task"]
//        cell.taskDetailLabel.text = taskDict["subtask"]
//        cell.dateLabel.text = taskDict["date"]
        
        cell.taskLabel.text = currentTask.task
        cell.taskDetailLabel.text = currentTask.subTask
        cell.dateLabel.text = Date.toString(date: currentTask.date)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //print line to check which row in the tableview is pressed
        println("\(indexPath.row)")
        
        //opening a TaskDetailViewController view using defined segue 
        
        self.performSegueWithIdentifier("showTaskDetail", sender: self)
        
    }


}


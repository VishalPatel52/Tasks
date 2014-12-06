//
//  SettingsViewController.swift
//  Complete Tasks
//
//  Created by Vishal Patel on 06/12/14.
//  Copyright (c) 2014 Vishal Patel. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var capitalizeTableView: UITableView!
    @IBOutlet weak var completeNewToDoTableView: UITableView!
    @IBOutlet weak var versionLabel: UILabel!
    
    let kVersionNumber = "1.0"
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //delegate and dataSource of tableViews in code
        self.capitalizeTableView.delegate = self
        self.capitalizeTableView.dataSource = self
        self.capitalizeTableView.scrollEnabled = false
        
        self.completeNewToDoTableView.delegate = self
        self.completeNewToDoTableView.dataSource = self
        self.completeNewToDoTableView.scrollEnabled = false
        
        //title of this screen on navigation bar
        
        self.title = "Settings"
        
        self.versionLabel.text = kVersionNumber
        
        //override the navigation backButton via code
        
        var doneBarButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: Selector("doneBarButtonItemPressed:"))
        
        self.navigationItem.backBarButtonItem = doneBarButton
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func doneBarButtonItemPressed (barButtonItem: UIBarButtonItem) {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    
    //UITableViewDelegate
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //first (upper) tableView
        if tableView == self.capitalizeTableView {
            
            var capitalizeCell: UITableViewCell = tableView.dequeueReusableCellWithIdentifier("capitalizeCell") as UITableViewCell
            if indexPath.row == 0 {
                capitalizeCell.textLabel.text = "No, do not Capitalize"
                
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) == false {
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
                else {
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            else {
                capitalizeCell.textLabel.text = "Yes, Capitalize!"
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCapitalizeTaskKey) == true {
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
                else {
                    capitalizeCell.accessoryType = UITableViewCellAccessoryType.None
                }
            }
            return capitalizeCell
        }
            
            //second (lower) tableView
        else {
            var cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("completeNewToDoCell") as UITableViewCell
            if indexPath.row == 0 {
                cell.textLabel.text = "Do not complete task"
                
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewToDoKey) == false {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
                else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
                }
                
            }
            else {
                cell.textLabel.text = "Complete task"
                
                if NSUserDefaults.standardUserDefaults().boolForKey(kShouldCompleteNewToDoKey) == true {
                    cell.accessoryType = UITableViewCellAccessoryType.Checkmark
                }
                else {
                    cell.accessoryType = UITableViewCellAccessoryType.None
                }
                
            }
            return cell
            
        }
    }
    
    //UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 30.0
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if tableView == self.capitalizeTableView {
            return "Capitalize new task?"
        }
        else {
            return "Complete new task?"
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if tableView == self.capitalizeTableView {
            if indexPath.row == 0 {
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: kShouldCapitalizeTaskKey)
            }
            else {
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: kShouldCapitalizeTaskKey)
            }
        }
        else {
            if indexPath.row == 0 {
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: kShouldCompleteNewToDoKey)
            }
            else {
                NSUserDefaults.standardUserDefaults().setBool(true, forKey: kShouldCompleteNewToDoKey)
            }
            
        }
        
        //super important that it saves the changes on the tableView content
        NSUserDefaults.standardUserDefaults().synchronize()
        tableView.reloadData()
    }
}

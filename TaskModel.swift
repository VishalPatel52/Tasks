//
//  TaskModel.swift
//  Complete Tasks
//
//  Created by Vishal Patel on 27/09/14.
//  Copyright (c) 2014 Vishal Patel. All rights reserved.
//

import Foundation
import CoreData

@objc(TaskModel) // objective-c bridge, in-case if we want to use objective-c in future
class TaskModel: NSManagedObject {

    @NSManaged var completed: Bool
    @NSManaged var date: NSDate
    @NSManaged var subTask: String
    @NSManaged var task: String

}

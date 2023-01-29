//
//  User.swift
//  TaskBully
//
//  Created by Fernando Borrell on 1/28/23.
//

import Foundation

class User {
    var preferredAnger: AngerLevels
    var taskList: [TBTasks]
    
    init(preferredAnger: AngerLevels, taskList: [TBTasks]) {
        self.preferredAnger = preferredAnger
        self.taskList = taskList
    }
    
    func addTask(pName: String, pDuration : Float){
        let newTask = TBTasks(name: pName, duration: pDuration)
        taskList.append(newTask)
    }
    
    func setAnger(pAngerLevel : AngerLevels){
        self.preferredAnger = pAngerLevel
    }
}


//
//  User.swift
//  TaskBully
//
//  Created by Fernando Borrell on 1/28/23.
//

import Foundation

class User : ObservableObject {
    @Published var preferredAnger: AngerLevels
    @Published var taskList: [TBTasks]
    
    init(preferredAnger: AngerLevels, taskList: [TBTasks]) {
        self.preferredAnger = preferredAnger
        self.taskList = taskList
    }
    
    func addTask(pName: String,pDescription: String, pDuration : Float){
        let newTask = TBTasks(name: pName, description: pDescription, duration: pDuration)
        taskList.append(newTask)
    }
    
    func setAnger(pAngerLevel : Int){
        switch pAngerLevel {
        case 1:
            preferredAnger = .ENCOURAGING
        case 2:
            preferredAnger = .PASSIVEAGGRESSIVE
        case 3:
            preferredAnger = .ABUSIVE
        default:
            preferredAnger = .PASSIVEAGGRESSIVE
        }
    }
    
    func getAnger() -> AngerLevels{
        return preferredAnger
    }
}


//
//  Sentences.swift
//  TaskBully
//
//  Created by Fernando Borrell on 1/28/23.
//

import Foundation
import SwiftUI
import UserNotifications


struct SentenceBank {
    private var abuse = ["abusive Sentence 1","abusive Sentence 2","abusive Sentence 3","abusive Sentence 4"]
    private var passive = ["Pass Aggr Sentence 1","Pass Aggr Sentence 2","Pass Aggr Sentence 3","Pass Aggr Sentence 4"]
    private var encourage = ["Encouraging sentence 1","Encouraging sentence 2","Encouraging sentence 3","Encouraging sentence 4"]
    
    init(){
        abuse = abuse.shuffled()
        passive = passive.shuffled()
        encourage = encourage.shuffled()
    }
    
    
    mutating func get(angerLevel : AngerLevels) -> String {
        if(angerLevel == .ABUSIVE){
            let sentence = abuse.removeFirst()
            abuse.append(sentence)
            return sentence
        }else if(angerLevel == .ENCOURAGING){
            let sentence = encourage.removeFirst()
            encourage.append(sentence)
            return sentence
        }else{
            let sentence = passive.removeFirst()
            passive.append(sentence)
            return sentence
        }
    }
}

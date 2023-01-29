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
    private var abuse = ["A fucking break already?",
                         "Back to work bitch",
                         "Holy fuck, you're lazy",
                         "Damn, you are embarrassing 🙈",
                         "Fuck! again??",
                         "You probably lost so much money in NFT scams",
                         "You're fucking hopeless 😂",
                         "Just drop out already.",
                         "Back to work four-eyes 🤓",
                         "Want a knuckle sandwich?👊🥪",
                         "This you? 🤡"]
    private var passive = ["Not too concerned, huh?",
                           "Maybe get some help.",
                           "Slacking off, huh 👀?",
                           "Oh, that's your best?",
                           "Sigh... really? 😬",
                           "Another day wasted 😅",
                           "You'd better marry rich."]
    private var encourage = ["You're doing great!",
                             "Keep going! You got this!",
                             "You've gotten so much done today 🤩",
                             "Great progress!",
                             "Another hard days work 😤💪",
                             "You deserve a break.",
                             "Nice job on that task!",
                             "Keep up the good work :)",
                             "I believe in you 🙂"]

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

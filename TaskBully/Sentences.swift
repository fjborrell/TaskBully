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
    private var abuse = ["A break already?",
                         "You gotta be kidding me...",
                         "Wow, you're lazy",
                         "Embarrassing 🙈",
                         "Again!?",
                         "You're hopeless 😂",
                         "Might as well give up.",
                         "Back to work nerd 🤓",
                         "Want a knuckle sandwich?👊🥪",
                         "This you? 🤡"]
    private var passive = ["Not too concerned, huh?",
                           "Maybe get some help.",
                           "Slacking off, huh 👀?",
                           "Oh, that's your best?",
                           "Sigh... really? 😬",
                           "Another day wasted 😅"]
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

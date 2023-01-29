//
//  Sentences.swift
//  TaskBully
//
//  Created by Fernando Borrell on 1/28/23.
//

import Foundation
import SwiftUI

struct SentenceBank {
    @State var sentenceBank: [AngerLevels : [String]] = [:]
    let a = AbusiveBank()
    let b = PassiveAggressiveBank()
    let c = EncouragingBank()
    
    init() {
        populateBank()
    }
    
    func populateBank() {
        self.sentenceBank[.ABUSIVE] = a.abusiveSentences
        self.sentenceBank[.PASSIVEAGGRESSIVE] = b.passiveAggressiveSentences
        self.sentenceBank[.ENCOURAGING] = c.encouragingSentences
    }
    
    func get() -> [AngerLevels : [String]] {
        return sentenceBank
    }
}

struct AbusiveBank {
    let abusiveSentences: [String] = [
        "You fucking suck"
    ]
}

struct PassiveAggressiveBank {
    let passiveAggressiveSentences: [String] = [
        "Wow, you're not good at this"
    ]
}

struct EncouragingBank {
    let encouragingSentences: [String] = [
        "I know this is hard, but you got it!"
    ]
}

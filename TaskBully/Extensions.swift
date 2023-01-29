//
//  Extensions.swift
//  TaskBully
//
//  Created by Fernando Borrell on 1/28/23.
//

import Foundation
import SwiftUI

extension Color {
    init(hex: Int, opacity: Double = 1.0) {
        let red = Double((hex & 0xff0000) >> 16) / 255.0
        let green = Double((hex & 0xff00) >> 8) / 255.0
        let blue = Double((hex & 0xff) >> 0) / 255.0
        self.init(.sRGB, red: red, green: green, blue: blue, opacity: opacity)
    }
}

struct TBTask : Identifiable,Hashable,Equatable{
    var id: UUID = .init()
    var taskTitle: String
    var taskDescription: String
    var taskColor: Color
}

var tasks: [TBTask] = [
    .init(taskTitle: "Laundry", taskDescription: "Wash and fold clothes", taskColor: Color("TBblack")),
    .init(taskTitle: "Study COMP 421", taskDescription: "Review ER Mapping slides", taskColor: Color("TBgrey")),
    .init(taskTitle: "Exercise", taskDescription: "Push day!", taskColor: Color("TBpurple")),
    .init(taskTitle: "Meditate", taskDescription: "practice mindfulness", taskColor: Color("TBpurple"))
]

struct NavButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .tint(.purple)
            .buttonStyle(.bordered)
            .controlSize(.large)
            .padding(50)
    }
}

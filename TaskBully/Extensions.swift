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

struct ColorValue : Identifiable,Hashable,Equatable{
    var id: UUID = .init()
    var colorCode: String
    var title: String
    var color: Color
}

var colors: [ColorValue] = [
    .init(colorCode: "171717", title: "Jet Black", color: Color("TBblack")),
    .init(colorCode: "444444", title: "Jet Grey", color: Color("TBgrey")),
    .init(colorCode: "5F27CD", title: "Jet Purple", color: Color("TBpurple")),
    .init(colorCode: "EDEDED", title: "Jet White", color: Color("TBwhite"))
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

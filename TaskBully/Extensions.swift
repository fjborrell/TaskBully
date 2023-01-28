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

//struct NavLabel: View {
//    var prompt: String
//
//    init(prompt: String) {
//        self.prompt = prompt
//    }
//
//    var body: some View {
//        Label {
//            Text(prompt)
//                .font(.headline)
//        } icon: {
//            Image(systemName: "arrow.right.circle")
//        }
//        .tint(.purple)
//        .buttonStyle(.bordered)
//        .controlSize(.large)
//        .padding(50)
//    }
//}

struct NavButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .tint(.purple)
            .buttonStyle(.bordered)
            .controlSize(.large)
            .padding(50)
    }
}

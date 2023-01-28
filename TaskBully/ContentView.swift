//
//  ContentView.swift
//  TaskBully
//
//  Created by Fernando Borrell on 1/28/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "ruler")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Task Bully")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

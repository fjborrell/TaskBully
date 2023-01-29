//
//  AddTaskView.swift
//  TaskBully
//
//  Created by Fernando Borrell on 1/29/23.
//

import SwiftUI

struct AddTaskView: View {
    @State private var title: String = ""
    @State private var description: String = ""
    @State private var color: Color = Color.blue
    @Binding var showModal: Bool
    
    var body: some View {
        ZStack {
            //Background Color
            Color(hex:0x171717)
                .ignoresSafeArea()
            
            VStack {
                TextField("Title", text: $title)
                    .font(.title.bold())
                    .textFieldStyle(.roundedBorder)
                    .padding([.leading, .trailing, .top], 25)
                    .foregroundColor(Color("TBblack"))
                    .opacity(0.85)
                TextField("Description", text: $description)
                    .textFieldStyle(.roundedBorder)
                    .padding([.leading, .trailing], 25)
                    .foregroundColor(Color("TBblack"))
                    .opacity(0.85)
                ColorPicker("Color", selection: $color)
                    .font(.title3.bold())
                    .padding([.leading, .trailing, .top], 20)
                    .foregroundColor(.white)
                
                Button(action: {
                    // Generate the array here with the title, description, and color
                    let generatedTask = TBTask(taskTitle: title, taskDescription: description, taskColor: Color("TBpurple"))
                    tasks.append(generatedTask)
                    showModal.toggle()
                }) {
                    Text("Add task")
                }
                .tint(.green)
                .padding(.init(top: 100, leading: 20, bottom: 40, trailing: 20))
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
            .background {
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    //.fill(.ultraThinMaterial)
                    .foregroundColor(Color("TBpurple"))
                    .opacity(0.45)
            }
            .padding(40)
            .multilineTextAlignment(.leading)
        }
    }
}

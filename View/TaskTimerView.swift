//
//  TaskTimerView.swift
//  TaskBully
//
//  Created by Fernando Borrell on 1/28/23.
//

import SwiftUI

struct TaskTimerView: View {
    @StateObject private var vm = ViewModel()
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    private let width: Double = 250
    
    var body: some View {
        VStack {
            Text("\(vm.time)")
                .font(.system(size: 70, weight: .medium, design: .rounded))
                .alert("Task Timer Complete!", isPresented: $vm.showingAlert) {
                    Button("Continue", role: .cancel) {
                        // Code
                    }
                }
                .padding()
                .frame(width: width)
                .background(.thinMaterial)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.gray, lineWidth: 4)
                )
            
            Slider(value: $vm.minutes, in: 0...60, step: 5)
                .padding()
                .disabled(vm.isActive)
                .animation(.easeInOut, value: vm.minutes)
                .frame(width: width)
            
            HStack(spacing:50) {
                //START TIMER BUTTON
                Button(action: {
                    vm.start(minutes: vm.minutes)
                }) {
                    Text("Start")
                        .bold()
                    Image(systemName: "play.circle")
                }
                .disabled(vm.isActive)
                .tint(.green)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                
                
                //RESET TIMER BUTTON
                Button(action: vm.reset) {
                    Text("Reset")
                        .bold()
                    Image(systemName: "stop.circle")
                }
                .disabled(!vm.isActive)
                .tint(.red)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
            }
        }
        .onReceive(timer) { _ in
            vm.updateCountdown()
        }
        
    }
}

struct TaskTimerView_Previews: PreviewProvider {
    static var previews: some View {
        TaskTimerView()
    }
}

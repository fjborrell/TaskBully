//
//  RootView.swift
//  TaskBully
//
//  Created by Bob  Jones on 2023-01-28.
//

import SwiftUI

struct RootView: View {
    @State private var showHomePage: Bool = false
    @State var allowAlerts: Bool = false
    let user: User = User(preferredAnger: .PASSIVEAGGRESSIVE, taskList: [TBTasks(name: "Laundry", description: "fold cloths", duration: 10)])

    
    var body: some View {
        NavigationStack {
            ZStack {
                //Background Color
                Color(hex:0x171717)
                    .ignoresSafeArea()
                
                
                VStack {
                    //Welcome Hand
                    Image(systemName: "hand.wave.fill")
                        .font(.title.bold())
                        .foregroundColor(Color(hex: 0xEDEDED))
                        .padding(1)
                    //Welcome Text
                    HStack {
                        Text("Welcome to")
                            .foregroundColor(Color(hex: 0xEDEDED))
                            .font(.title)
                        Text("TaskBully")
                            .font(.title.bold())
                            .foregroundColor(.purple)
                    }
                    
                    //Image
                    Image("angrydude")
                                        
                    //Get Started Button
                    NavigationLink {
                        SetupView(allowAlerts: $allowAlerts).environmentObject(user)
                    } label: {
                        HStack {
                            Text("Get Started")
                                .font(.title3.bold())
                            Image(systemName: "arrow.right.circle")
                        }
                    }
                    .tint(.purple)
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    .padding(50)
                }
            }
        }
        .background(AppLifecycle(allowAlerts: $allowAlerts).environmentObject(user))
    }
    
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}

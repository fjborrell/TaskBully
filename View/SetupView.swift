//
//  Setup.swift
//  TaskBully
//
//  Created by Fernando Borrell on 1/28/23.
//

import SwiftUI

struct SetupView: View {
    @State var angerSliderValue: Double = 2
    @State var angerLevel: AngerLevels = .PASSIVEAGGRESSIVE
    
    var body: some View {
        ZStack {
            //Background Color
            Color(hex:0x171717)
                .ignoresSafeArea()
            
            
            VStack {
                //Welcome Hand
                Image(systemName: "gear")
                    .font(.title.bold())
                    .foregroundColor(Color(hex: 0xEDEDED))
                    .padding(1)
                //Welcome Text
                HStack {
                    Text("Customize your experience!")
                        .foregroundColor(Color(hex: 0xEDEDED))
                        .font(.title)
                }
                
                //Image
                Image("settingsgirl")
                    .resizable()
                    .frame(width: 250, height: 250)
                
                VStack {
                    //NOTIFICATION ACCESS
                    Button(action: {}) {
                        Text("Authorize Notifications")
                            .bold()
                        Image(systemName: "bell.badge.fill")
                    }
                    .tint(.purple)
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    .padding(50)
                    
                    //ANGER LEVEL SETTER
                    VStack {
                        Slider(value: $angerSliderValue, in: 1...3, step: 1)
                        HStack {
                            Text("Anger Level:")
                                .foregroundColor(Color(hex: 0xEDEDED))
                                .padding(1)
                            Text("\(intToAnger(levelAsInt: Int(angerSliderValue)))")
                                .foregroundColor(Color(hex: 0xEDEDED))
                                .padding(1)
                                .bold()
                        }
                        
                        
                    }
                    
                    //TO TASK LIST
                    NavigationLink {
                        Home()
                    } label: {
                        HStack {
                            Text("Finish")
                                .font(.title3.bold())
                            Image(systemName: "arrow.right.circle")
                        }
                    }
                    .tint(.purple)
                    .buttonStyle(.bordered)
                    .controlSize(.large)
                    .padding(50)
                }
                .padding(50)
            }
        }
    }
}

func intToAnger(levelAsInt: Int) -> String {
    switch levelAsInt {
    case 1:
        return "Encouraging"
    case 2:
        return "Passive Aggressive"
    case 3:
        return "Abusive"
    default:
        return "Passive Aggressive"
    }
}

struct SetupView_Previews: PreviewProvider {
    static var previews: some View {
        SetupView(angerSliderValue: 0)
    }
}

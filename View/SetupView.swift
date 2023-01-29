//
//  Setup.swift
//  TaskBully
//
//  Created by Fernando Borrell on 1/28/23.
//

import SwiftUI
import UserNotifications

struct SetupView: View {
    @State var angerSliderValue: Double = 2
    @State var angerLevel: AngerLevels = .PASSIVEAGGRESSIVE
    @State var authorizedNotifications = false
    @EnvironmentObject var user: User
    
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
                    .frame(width: 200, height: 200)
                
                //NOTIFICATION ACCESS
                Button(action: {
                    authorizedNotifications = true
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                        if success {
                            print("All set!")
                        } else if let error = error {
                            print(error.localizedDescription)
                        }
                    }
                }) {
                    Text("Authorize Notifications")
                        .bold()
                    Image(systemName: "bell.badge.fill")
                }
                .tint(.purple)
                .buttonStyle(.bordered)
                .controlSize(.large)
                .padding(40)
                
                VStack {
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
<<<<<<< HEAD
=======
                    
                    //TO TASK LIST
                    NavigationLink {
                        Home()
                            .navigationBarBackButtonHidden()
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
                    .onTapGesture {
                        user.setAnger(pAngerLevel: Int(angerSliderValue))
                    }
>>>>>>> f4e682a2395f621c65c66ca79b2c2e60274c94da
                }
                .padding([.leading, .trailing], 50)
                
                //TO TASK LIST
                NavigationLink {
                    Home()
                        .navigationBarBackButtonHidden()
                } label: {
                    HStack {
                        Text("Finish")
                            .font(.title3.bold())
                        Image(systemName: "arrow.right.circle")
                    }
                }
                .disabled(!authorizedNotifications)
                .tint(.purple)
                .buttonStyle(.bordered)
                .controlSize(.large)
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

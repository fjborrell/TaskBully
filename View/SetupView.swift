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
    @State var authorizedNotifications: Bool = false
    @State var isShowingConsentAlert: Bool = false
    @State var userConsentedToBullyMode: Bool = false
    @Binding var allowAlerts: Bool
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
                .padding([.leading, .trailing], 50)
                
                //TO TASK LIST
                ZStack {
                    NavigationLink {
                        Home(allowAlerts: $allowAlerts)
                            .navigationBarBackButtonHidden().environmentObject(user)
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
                    .simultaneousGesture(TapGesture().onEnded {
                        user.setAnger(pAngerLevel: Int(angerSliderValue))
                        
                    })
                    
                    if angerSliderValue == 3 && !userConsentedToBullyMode {
                        //Invisible Consent Button
                        Button(action: {
                            isShowingConsentAlert.toggle()
                        }) {
                            Color.clear
                        }
                        .frame(width: 125, height: 85)
                    }
                }
                .alert("Warning!", isPresented: $isShowingConsentAlert, actions: {
                    Button("I Accept", role: .destructive, action: {
                        userConsentedToBullyMode = true
                    })
                    Button("Go Back", role: .cancel, action: {
                        userConsentedToBullyMode = false
                    })
                }, message: {
                    Text("By setting the app intensity to level three, please confirm that you are OK with receiving messages that some may find mean, uncomfortable, or hurtful")
                })
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
        return "Bully"
    default:
        return "Passive Aggressive"
    }
}

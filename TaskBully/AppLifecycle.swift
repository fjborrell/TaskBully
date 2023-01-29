//
//  AppLifecycle.swift
//  T
//
//  Created by  on 1/28/23.
//

import SwiftUI

struct AppLifecycle: View {
    @State private var isActive = true
    @StateObject private var timerManager = TimerManager()
    @StateObject private var sentenceManager = SentenceManager()
    @EnvironmentObject var user: User
    
    var body: some View {
        Color.clear
            //SHORT BACKGROUND
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                self.isActive = false
                self.sentenceManager.alertUser(pAnger: user.getAnger())
            
            }
            //LONG BACKGROUND (SUSPENDED)
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
                timerManager.startTimer()
            }
            //ACTIVE FOREGROUND
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                self.timerManager.stopTimer()
                print("DEBUG: Welcome back!")
            }
    }
}

class SentenceManager: ObservableObject {
    private var sentenceBank: SentenceBank = SentenceBank()
    
    
    func alertUser(pAnger: AngerLevels) {
        let content = UNMutableNotificationContent()
        content.title = "TaskBully says:"
        content.subtitle = "\"\(sentenceBank.get(angerLevel: pAnger))\""
        content.sound = UNNotificationSound.defaultCritical
        
        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
}

class TimerManager: ObservableObject {
    private var timer: Timer?
    
    //Make a new X second timer.
    func startTimer() {
        stopTimer()
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: false) { _ in
            print("DEBUG: You failed :(")
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
}

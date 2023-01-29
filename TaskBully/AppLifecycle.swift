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
    @Binding var allowAlerts: Bool
    @EnvironmentObject var user: User
    
    var body: some View {
        Color.clear
            //SHORT BACKGROUND
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                self.isActive = false
                if allowAlerts {
                    self.sentenceManager.alertUser(pAnger: user.getAnger())
                }
            
            }
            //LONG BACKGROUND (SUSPENDED)
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
                if allowAlerts {
                    self.sentenceManager.delayedAlert(pAnger: user.getAnger())
                    self.sentenceManager.lastAlert(pAnger: user.getAnger())
                }
            }
            //ACTIVE FOREGROUND
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                self.isActive = true
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
    
    func delayedAlert(pAnger: AngerLevels) {
        let content = UNMutableNotificationContent()
        content.title = "TaskBully says:"
        content.subtitle = "\"\(sentenceBank.get(angerLevel: pAnger))\""
        content.sound = UNNotificationSound.defaultCritical
        
        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        // add our notification request
        UNUserNotificationCenter.current().add(request)
    }
    
    func lastAlert(pAnger: AngerLevels) {
        let content = UNMutableNotificationContent()
        content.title = "TaskBully says:"
        content.subtitle = "\"\(sentenceBank.get(angerLevel: pAnger))\""
        content.sound = UNNotificationSound.defaultCritical
        
        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 6, repeats: false)
        
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
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: false) { _ in
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
    }
    
}

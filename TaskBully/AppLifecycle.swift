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
    
    var body: some View {
        Color.clear
            //SHORT BACKGROUND
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                self.isActive = false
                print("DEBUG: Go back to the app")
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

struct AppLifecycle_Previews: PreviewProvider {
    static var previews: some View {
        AppLifecycle()
    }
}

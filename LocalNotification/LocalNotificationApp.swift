//
//  LocalNotificationApp.swift
//  LocalNotification
//
//  Created by Sidi Praptama Aurelius Nurhalim on 15/07/25.
//

import SwiftUI
import UserNotifications

@main
struct LocalNotificationApp: App {
    @AppStorage("lastOpenedDate") var lastOpenedDate: String = ""
    
    init() {
        requestNotificationPermission()
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    // Menghapus notif terjadwal hari ini (harusnya)
                    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["daily2130"])
                }
        }
    }

    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Permission error: \(error.localizedDescription)")
            }
            if granted {
                print("Permission granted ✅")
                scheduleRepeating2130Notification()
            } else {
                print("Permission denied ❌")
            }
        }
    }
    
    func scheduleRepeating2130Notification() {
        let content = UNMutableNotificationContent()
        content.title = "Waktunya latihan!"
        content.body = "Kamu belum buka aplikasi hari ini. Yuk mulai latihanmu 💪"
        content.sound = UNNotificationSound(named: UNNotificationSoundName("custom-notification.caf")) // custom sound

        var dateComponents = DateComponents()
        dateComponents.hour = 21
        dateComponents.minute = 30

        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)

        let request = UNNotificationRequest(identifier: "daily2130", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request)
    }
}

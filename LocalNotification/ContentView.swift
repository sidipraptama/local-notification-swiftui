//
//  ContentView.swift
//  LocalNotification
//
//  Created by Sidi Praptama Aurelius Nurhalim on 15/07/25.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Local Notification Demo")
                .font(.title)
                .padding()

            Button("Kirim Notifikasi dalam 5 detik") {
                scheduleNotification()
            }
            .padding()
            .foregroundColor(.white)
            .background(Color.blue)
            .cornerRadius(12)
        }
    }

    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Halo!"
        content.body = "Ini notifikasi lokal yang dikirim setelah 5 detik"
        content.sound = UNNotificationSound(named: UNNotificationSoundName("custom-notification.caf")) // custom sound
        
        // Notif terkirim setelah 5 detik dengan syarat app berjalan dibackground atau tertutup

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: "demoNotification", content: content, trigger: trigger)

        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Gagal menjadwalkan notifikasi: \(error)")
            } else {
                print("Notifikasi berhasil dijadwalkan")
            }
        }
    }
}


#Preview {
    ContentView()
}

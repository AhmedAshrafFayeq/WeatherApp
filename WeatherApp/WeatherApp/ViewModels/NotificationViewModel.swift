//
//  NotificationViewModel.swift
//  WeatherApp
//
//  Created by Ahmed Fayeq on 19/06/2022.
//

import Foundation
import UserNotifications

class NotificationViewModel {
    
    func createNotification(title: String, body: String)   {
        let content =  UNMutableNotificationContent()
        content.title = "Today Weather State in \(title)"
        content.body = body
        content.sound = .default
        
        
        // show this notification five seconds from now
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)

        // choose a random identifier
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

        // add our notification request
        UNUserNotificationCenter.current().add(request)
        
    }
}

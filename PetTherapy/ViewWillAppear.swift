
import UIKit
import UserNotifications

extension GiphyVC {
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound]) {
                granted, error in
            let generalCategory = UNNotificationCategory(identifier: "GENERAL", actions: [], intentIdentifiers: [], options: .customDismissAction)
            center.setNotificationCategories([generalCategory])
            }
        }
        if #available(iOS 10.0, *) {
            let content = UNMutableNotificationContent()
            content.title = NSString.localizedUserNotificationString(forKey: "Hello", arguments: nil)
            content.body = NSString.localizedUserNotificationString(forKey: "Hello_message_body", arguments: nil)
            
            // Deliver the notificaiton in five seconds.
            content.sound = UNNotificationSound.default()
             let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            let request = UNNotificationRequest(identifier: "FiveSeconds", content: content, trigger: trigger)
             let center = UNUserNotificationCenter.current()
            center.add(request, withCompletionHandler: nil)
        }         
        
    }
}


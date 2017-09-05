
var bluePurple = UIColor(red:0.73, green:0.79, blue:0.98, alpha:1.0)

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let navController = UINavigationController(rootViewController: GiphyVC())
        navController.navigationBar.isTranslucent = false
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        let bar = UINavigationBar.appearance()
        bar.barTintColor = bluePurple
        bar.tintColor = UIColor.white
        bar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        application.statusBarStyle = .lightContent
        bar.isTranslucent = false
        
        UIApplication.shared.cancelAllLocalNotifications()

            application.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil))
            let notificaiton = UILocalNotification()
            let calendar = Calendar.current
            print(Date())
            var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: Date())
            components.minute = components.minute! + 1
            let scheduledNotificationDate = calendar.date(from: components)
            notificaiton.fireDate = scheduledNotificationDate!
            notificaiton.repeatInterval = NSCalendar.Unit.day
            notificaiton.alertBody = "It is time for your daily dose of cute!"
            notificaiton.alertAction = "Visit Daily Dose of Cute!"
            notificaiton.soundName = UILocalNotificationDefaultSoundName
            UIApplication.shared.scheduleLocalNotification(notificaiton)
   
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}



var bluePurple = UIColor(red:0.73, green:0.79, blue:0.98, alpha:1.0)

import UIKit
import UserNotifications
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var isIOS10 = true

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
       
        scheduleNotifications()
   
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        if !isIOS10 {
            let notification = UILocalNotification()
            notification.alertAction = "Ok"
            notification.alertBody = "Saving Gifs is only possible on iOS 10 and later.  Please update your OS to save gifs."
            notification.alertTitle = "Notice"
            application.presentLocalNotificationNow(notification)
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {
        scheduleNotifications()
        
        
    }


    func scheduleNotifications() {
        
        UIApplication.shared.cancelAllLocalNotifications()
        
        let notificaiton = UILocalNotification()
        
        let calendar = Calendar.current
        
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second, .nanosecond], from: Date())
        
        components.hour = 14
        
        components.minute = 0
        
        components.second = 0
        
        components.nanosecond = 0
        
        let scheduledNotificationDate = calendar.date(from: components)
        
        notificaiton.fireDate = scheduledNotificationDate!
        
        notificaiton.repeatInterval = NSCalendar.Unit.day
        
        notificaiton.alertBody = "It is time for your daily dose of cute!"
        
        notificaiton.alertAction = "Visit Daily Dose of Cute!"
        
        notificaiton.soundName = UILocalNotificationDefaultSoundName
        
        UIApplication.shared.scheduleLocalNotification(notificaiton)
  }
    
    
    @available(iOS 10.0, *)
    lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "PetTherapy")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        if #available(iOS 10.0, *) {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        } else {
            isIOS10 = false
            applicationDidEnterBackground(UIApplication())
        }
       
    }
}


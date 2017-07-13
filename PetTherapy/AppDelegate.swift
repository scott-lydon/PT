
var bluePurple = UIColor(red:0.73, green:0.79, blue:0.98, alpha:1.0)

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.rootViewController = UINavigationController(rootViewController: GiphyVC())
  
        let bar = UINavigationBar.appearance()
        bar.barTintColor = bluePurple
        bar.tintColor = UIColor.white
        bar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        application.statusBarStyle = .lightContent
        bar.isTranslucent = false
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


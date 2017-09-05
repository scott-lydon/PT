
import UIKit


extension GiphyVC {
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        
//        //Test:
//        guard let settings = UIApplication.shared.currentUserNotificationSettings else {return}
//        if settings.types == [] {
//            let ac = UIAlertController(title: "can't schedule", message: "either we don't have permission to schedule notifications or we haven't asked yet", preferredStyle: .alert)
//            ac.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
//            self.present(ac, animated: true, completion: nil)
//            return
//        }

    }
}


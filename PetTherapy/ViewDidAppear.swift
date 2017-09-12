//
//  ViewDidAppear.swift
//  PetTherapy
//
//  Created by Scott Lydon on 9/12/17.
//  Copyright © 2017 Scott Lydon. All rights reserved.
//
import UIKit
import Foundation

extension GiphyVC {

    override func viewDidAppear(_ animated: Bool) {
    
        let key = "isAfterFirstTime"
        let isFirstTime = !UserDefaults.standard.bool(forKey: key)
        if isFirstTime {
            
            print("is first time")
            let alert = UIAlertController(title: "FYI", message: "Research by psychological scientists from Hiroshima University, led by Hiroshi Nittono demonstrated that “cute” pictures of baby animals, including puppies and kittens, can facilitate improved performance on detail-oriented tasks that require concentration.  \nAllow push notifications so that you can boost your concentration at 2PM daily with your Daily Dose of Cute!", preferredStyle: .alert)
            let action = UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil))
            })
            alert.addAction(action)
            self.present(alert, animated: true, completion: nil)
            UserDefaults.standard.set(true, forKey: key)
        }
    }
}

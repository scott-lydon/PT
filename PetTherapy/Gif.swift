//
//  Gif.swift
//  PetTherapy
//
//  Created by Jiten Devlani on 13/07/17.
//  Copyright © 2017 Scott Lydon. All rights reserved.
//

import UIKit

class Gif: NSObject {
    var url:URL!
    var data:Data?
    var name:String?
    
    init(withDictionary dic:NSDictionary) {
        url     = dic.value(forKey: kURL) as! URL
        data    = dic.value(forKey: kData) as? Data
        name    = dic.value(forKey: kName) as? String
    }
}

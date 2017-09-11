//
//  CellCache.swift
//  PetTherapy
//
//  Created by Scott Lydon on 9/10/17.
//  Copyright © 2017 Scott Lydon. All rights reserved.
//

import Foundation

class GifCache {
    static var shared = GifCache()
    private init() {}
    
    var favs = NSCache<AnyObject, AnyObject>()
    var general = NSCache<AnyObject, AnyObject>()
}

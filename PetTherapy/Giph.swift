//
//  Gif.swift
//  PetTherapy
//
//  Created by Jiten Devlani on 13/07/17.
//  Copyright © 2017 Scott Lydon. All rights reserved.
//

import UIKit

class Giph: NSObject {
    var width: Double
    var height: Double
    var url: String
    var youtubeURL: String
    var data: Data?
    init(_ width: Double, _ height: Double, _ url: String, _ youtubeURL: String) {
        self.width = width
        self.height = height
        self.url = url
        self.youtubeURL = youtubeURL
    }
}

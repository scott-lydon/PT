//
//  Gif.swift
//  PetTherapy
//
//  Created by Jiten Devlani on 13/07/17.
//  Copyright © 2017 Scott Lydon. All rights reserved.
//

import UIKit

class Giph: NSObject {
    var url: String
    var youtubeURL: String
    init(_ url: String, _ youtubeURL: String) {
        self.url = url
        self.youtubeURL = youtubeURL
    }
}

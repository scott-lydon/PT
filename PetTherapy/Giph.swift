

import Foundation
import UIKit

class Giph: NSObject {
    let gif: UIImage
    let width: CGSize
    let height: CGSize
    
    init(gif: UIImage, width: CGSize, height: CGSize) {
        self.gif = gif
        self.width = width
        self.height = height
    }
}

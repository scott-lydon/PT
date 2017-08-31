

import Foundation
import UIKit

class Giph: NSObject {
    let gif: UIImage?
    let width: CGSize?
    let height: CGSize?
    let youtubeURL: String?
    let data: Data?

    
    init(gif: UIImage?, width: CGSize?, height: CGSize?, youtubeURL: String?, data: Data?) {
        self.gif = gif
        self.width = width
        self.height = height
        self.youtubeURL = youtubeURL
        self.data = data
    }
}

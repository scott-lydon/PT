

import Foundation
import UIKit

class Giph: NSObject {
    let url: URL?
    let id: String?
    let youtubeURL: String?
    
    var gif: UIImage?
    var width: CGSize?
    var height: CGSize?
    var data: Data?
    var buttonState: UIImage = #imageLiteral(resourceName: "WhiteHeartR")


    init(giphyEndPoint: String?, id: String?, youtubeURL: String?, gif: UIImage?, width: CGSize?, height: CGSize?, data: Data?) {
        self.id = id
        self.youtubeURL = youtubeURL
        self.url = URL(string: "\(String(describing: giphyEndPoint!))")
        self.gif = gif
        self.width = width
        self.height = height
        self.data = data
    }
}

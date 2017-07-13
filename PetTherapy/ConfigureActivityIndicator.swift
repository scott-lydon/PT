

import Foundation
import UIKit

extension GiphyVC {
    func configureActivityIndicator() {
        self.view.addSubview(activityIndicator)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
    }
}

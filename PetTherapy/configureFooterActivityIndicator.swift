
import UIKit
import Foundation

extension GiphyVC {
    func configureActivityIndicatorInFooter() {
        activityIndicator2.removeFromSuperview()
        tableView.tableFooterView?.addSubview(activityIndicator2)
        activityIndicator2.center = CGPoint(x: tableView.tableFooterView!.center.x, y: 70)
        activityIndicator2.hidesWhenStopped = true
        activityIndicator2.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityIndicator2.startAnimating()
    }
}

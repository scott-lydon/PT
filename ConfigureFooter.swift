
import UIKit
import Foundation

extension GiphyVC {
    
    func configureFooter() {
        self.automaticallyAdjustsScrollViewInsets = false
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 100))
        footer.backgroundColor = bluePurple
        let loadMoreLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 25))
        loadMoreLabel.text = "  Pull to load more!"
        loadMoreLabel.textColor = UIColor.white
        
        self.tableView.tableFooterView = footer
        let imgView = UIImageView(image: #imageLiteral(resourceName: "tail"))
        imgView.frame = CGRect(x: self.view.bounds.size.width / 2 - 20, y: -5, width: 40, height: 80)
        self.tableView.tableFooterView?.addSubview(imgView)
        self.tableView.tableFooterView?.addSubview(loadMoreLabel)
        self.tableView.tableFooterView?.isHidden = true
        
        _ = CGPoint(x: self.view.bounds.size.width / 2, y: -5) //rotationPoint
        
        
        
    }
}


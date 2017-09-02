
import UIKit
import Foundation

extension GiphyVC: UITableViewDataSource, UITableViewDelegate {
  
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        tableView.tableFooterView?.isHidden = false
        if scrollView == tableView{
            if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height)
            {
                if !isNewDataLoading{
                    
                    isNewDataLoading = true
                    getSetGifs()
                    configureActivityIndicatorInFooter()
                }
            }
        }
    }
}

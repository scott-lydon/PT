import UIKit
import Foundation

extension GiphyVC {
 
    
    
    func showFavoritesOrGeneral(sender: UISegmentedControl!)  {
        
        if sender.selectedSegmentIndex == 0 {
            showOnlyFavorites = false
            self.tableView.tableFooterView?.isHidden = false
            print("0 for segcont")
            tableView.reloadData()
        } else if sender.selectedSegmentIndex == 1 {
            showOnlyFavorites = true
            print("1 for segcont")
            self.tableView.tableFooterView?.isHidden = true
            tableView.reloadData()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.tableView.contentOffset = .zero
            self.tableView.layoutIfNeeded()
        })
        
    }    
}

import UIKit
import Foundation

extension GiphyVC {
 
    
    
    func showFavoritesOrGeneral(sender: UISegmentedControl!)  {
        
        if sender.selectedSegmentIndex == 0 {
            showOnlyFavorites = false
            tableView.reloadData()
        } else if sender.selectedSegmentIndex == 1 {
            showOnlyFavorites = true
            tableView.reloadData()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2, execute: {
            self.tableView.contentOffset = .zero
            self.tableView.layoutIfNeeded()
        })
        
    }
    
    
    
    
    
    
} // Giphy extension

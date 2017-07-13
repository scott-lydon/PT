import UIKit

extension GiphyVC {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if showOnlyFavorites {
            return onlyFavoriteGifs.count
        } else {
            return gifDatas.count
        }
        
        
    }
    
}

import UIKit

extension GiphyVC {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if showOnlyFavorites {
            if let image = UIImage.gif(data: onlyFavoriteGifs[indexPath.row].data!) {
                let ratio = image.size.width/image.size.height
                return tableView.frame.size.width/ratio
            } else {
                return 0
            }
        } else {
            if let image = UIImage.gif(data: gifDatas[indexPath.row].data!) {
                let ratio = image.size.width/image.size.height
                return tableView.frame.size.width/ratio
            } else {
                return 0
            }
        }
        
    }
}

import UIKit

extension GiphyVC {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let controller = WebViewVC()
        let row = indexPath.row
         if showOnlyFavorites {
            controller.webURLStr = onlyFavoriteGifs[row / fetchCount].youtubeURL
         } else {
            controller.webURLStr = giphs[row / fetchCount].youtubeURL
        }
        navigationController?.pushViewController(controller, animated: true)
        
    }
}


import UIKit

extension GiphyVC {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print("didSelectRow")
       let controller = WebViewVC()
        let row = indexPath.row
        print("clicked ", row, giphs[row].url)
         if showOnlyFavorites {
            controller.webURLStr = (onlyFavoriteGifs[row / fetchCount].value(forKeyPath: "youtubeURL") as? String)!
         } else {
            controller.webURLStr = giphs[row / fetchCount].youtubeURL
        }
        navigationController?.pushViewController(controller, animated: true)
        
    }
}


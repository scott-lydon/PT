import UIKit

extension GiphyVC {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let controller = WebViewVC()
        controller.webURLStr = List.shared.animalURLs[indexPath.row / 30]
        navigationController?.pushViewController(controller, animated: true)
        
        
    }
}


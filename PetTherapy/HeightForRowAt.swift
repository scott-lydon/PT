import UIKit

extension GiphyVC {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let image = UIImage.gif(data: readyToDisplayGiphs[indexPath.row].data!) {
            let ratio = image.size.width/image.size.height
            return tableView.frame.size.width/ratio
        } else {
            return 0
        }
    }
}

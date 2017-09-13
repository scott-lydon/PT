import UIKit

extension GiphyVC {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var giph: Giph
        var ratio: CGFloat
        if showOnlyFavorites {
            let width = onlyFavoriteGifs[indexPath.row].value(forKey: "width") as? Double
            let height = onlyFavoriteGifs[indexPath.row].value(forKey: "height") as? Double
            ratio = CGFloat(width!/height!)
        } else {
            giph = giphs[indexPath.row]
            ratio = CGFloat(giph.width / giph.height)
        }
        return tableView.frame.size.width/ratio
    }
}

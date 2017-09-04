import UIKit

extension GiphyVC {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var giph: Giph
        if showOnlyFavorites {
            giph = onlyFavoriteGifs[indexPath.row]
        } else {
            giph = giphs[indexPath.row]
        }
        let ratio = CGFloat(giph.width / giph.height)
        return tableView.frame.size.width/ratio
    }
}


//extension UIImageView {
//    func downloadImageFrom(link:String, contentMode: UIViewContentMode) {
//        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
//            (data, response, error) -> Void in
//            DispatchQueue.main.async {
//                self.contentMode =  contentMode
//                if let data = data {
//                    let img = UIImage.gif(data: data)
//                    self.image = img
//                }
//            }
//        }).resume()
//    }
//}
//cell.img.image = UIImage.gif(data: onlyFavoriteGifs[row].data!)
//albumArt.image = UIImage(named: "placeholder")
//albumArt.downloadImageFrom(link: "http://someurl.com/image.jpg", contentMode: UIViewContentMode.scaleAspectFit)

import UIKit

extension GiphyVC {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        let imgView = UIImageView()
//        let row = indexPath.row
//        var height = 0
//        if showOnlyFavorites {
//            imgView.downloadImageFrom(link: onlyFavoriteGifs[row].url, contentMode: UIViewContentMode.scaleAspectFit)
//            if let image = imgView.image {
//                let ratio = image.size.width/image.size.height
//                return tableView.frame.size.width/ratio
//            }
//        } else {
//            imgView.downloadImageFrom(link: giphs[row].url, contentMode: UIViewContentMode.scaleAspectFit)
//            if let image = imgView.image {
//                let ratio = image.size.width/image.size.height
//                return tableView.frame.size.width/ratio
//            }
//        }
//        return CGFloat(height)
        return UITableViewAutomaticDimension
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

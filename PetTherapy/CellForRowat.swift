import UIKit

extension GiphyVC {
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: giphCellReuseIdentifier, for: indexPath) as! GifTableViewCell
        
        setCellAppearance(cell, row)
        cell.btn.addTarget(self, action: #selector(btnPress), for: .touchUpInside)
        cell.btn.tag = row
        
        cell.favoriteBtn.addTarget(self, action: #selector(alterFavCount), for: .touchUpInside)
        cell.favoriteBtn.tag = row
        
        return cell
    }
    
    
    
    func setCellAppearance(_ cell: GifTableViewCell, _ row: Int) {
        if showOnlyFavorites {
            cell.img.downloadImageFrom(link: onlyFavoriteGifs[row].url, contentMode: UIViewContentMode.scaleAspectFill)
            cell.favoriteBtn.setImage(#imageLiteral(resourceName: "purpleHeartR"), for: .normal)
        } else {
            cell.img.downloadImageFrom(link: giphs[row].url, contentMode: UIViewContentMode.scaleAspectFill)
            if let x = buttonStates[giphs[row]] {
                if x == true {
                    cell.favoriteBtn.setImage(#imageLiteral(resourceName: "purpleHeartR"), for: .normal)
                } else {
                    cell.favoriteBtn.setImage(#imageLiteral(resourceName: "WhiteHeartR"), for: .normal)
                }
            } else {
                cell.favoriteBtn.setImage(#imageLiteral(resourceName: "WhiteHeartR"), for: .normal)
            }
        }
    }
    
    func btnPress(sender: UIButton!) {
        print("button tapped")
        let activityVC = UIActivityViewController(activityItems: [self.giphs[sender.tag].url], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    func alterFavCount(sender: UIButton!) {
        
        let gifID = giphs[sender.tag]
        
        if sender.imageView?.image == #imageLiteral(resourceName: "purpleHeartR") {
            DispatchQueue.global(qos: .background).async {
                //remove the value to the favorites array if it isn't there already.
                for (index, gifData) in self.onlyFavoriteGifs.enumerated() {
                    if gifData == gifID {
                        self.onlyFavoriteGifs.remove(at: index)
                    }
                }
            }
            sender.setImage(#imageLiteral(resourceName: "WhiteHeartR"), for: .normal)
            buttonStates[gifID] = false
        } else {
            DispatchQueue.global(qos: .background).async {
                //add the value to the favorites array if it isn't there already.
                var has = false
                for gifData in self.onlyFavoriteGifs {
                    if gifData == gifID {
                        has = true
                    }
                }
                if !has {
                    self.onlyFavoriteGifs += [gifID]
                }
            }
            sender.setImage(#imageLiteral(resourceName: "purpleHeartR"), for: .normal)
            buttonStates[gifID] = true
        }
    }
}



extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIViewContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data {
                    let img = UIImage.gif(data: data)
                    self.image = img
                    
                }
            }
        }).resume()
    }
}
//cell.img.image = UIImage.gif(data: onlyFavoriteGifs[row].data!)
//albumArt.image = UIImage(named: "placeholder")
//albumArt.downloadImageFrom(link: "http://someurl.com/image.jpg", contentMode: UIViewContentMode.scaleAspectFit)

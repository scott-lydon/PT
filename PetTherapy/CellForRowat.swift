import UIKit

extension GiphyVC {
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: giphCellReuseIdentifier, for: indexPath) as! GifTableViewCell
        
        if showOnlyFavorites {
            cell.img.image = UIImage.gif(data: onlyFavoriteGifs[indexPath.row])
        } else {
            cell.img.image = UIImage.gif(data: gifDatas[indexPath.row])
        }
        
        
        cell.btn.addTarget(self, action: #selector(btnPress), for: .touchUpInside)
        cell.btn.tag = indexPath.row
        
        cell.favoriteBtn.addTarget(self, action: #selector(alterFavCount), for: .touchUpInside)
        cell.favoriteBtn.tag = indexPath.row
        
        if let x = buttonStates[gifDatas[indexPath.row]] {
            if x == true {
                cell.favoriteBtn.setImage(#imageLiteral(resourceName: "purpleHeartR"), for: .normal)
            } else {
                cell.favoriteBtn.setImage(#imageLiteral(resourceName: "WhiteHeartR"), for: .normal)
            }
        }
        
        return cell
    }
    
    func btnPress(sender: UIButton!) {
        print("button tapped")
        let activityVC = UIActivityViewController(activityItems: [self.gifDatas[sender.tag]], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    func alterFavCount(sender: UIButton!) {
        
        let gifID = gifDatas[sender.tag]
        
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


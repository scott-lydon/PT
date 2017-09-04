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
        isScrollingUp = row > lastCellForRowAtIndex
        lastCellForRowAtIndex = row
        getNext(5, currentRow: row)
        cleanUp()

        if showOnlyFavorites {
            if let data = onlyFavoriteGifs[row].data {
                cell.img.image = UIImage.gif(data: data)
            } else {
                cell.img.downloadImageFrom(link: onlyFavoriteGifs[row].url, row, showOnlyFavorites)
            }
            cell.favoriteBtn.setImage(#imageLiteral(resourceName: "purpleHeartR"), for: .normal)
        } else {
            if let data = giphs[row].data {
                cell.img.image = UIImage.gif(data: data)
            } else {
                cell.img.downloadImageFrom(link: giphs[row].url, row, showOnlyFavorites)
                
            }
            
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
    
    enum DirectionFavOrAll {
        case scrollUpFavs, scrollDownFavs, scrollUpAll, scrollDownAll
    }
    
    var directionFavOrAll: DirectionFavOrAll {
        if isScrollingUp {
            if showOnlyFavorites {
                return .scrollUpFavs
            } else {
                return .scrollUpAll
            }
        } else {
            if showOnlyFavorites {
                return .scrollDownFavs
            } else {
                return .scrollDownAll
            }
        }
    }
    
    
    func getNext(_ count: Int, currentRow: Int) {
        var farthestIndex: Int
        switch directionFavOrAll {
        case .scrollUpFavs:
            farthestIndex = currentRow + count
            if farthestIndex >= onlyFavoriteGifs.count {farthestIndex = onlyFavoriteGifs.count - 1}
            while onlyFavoriteGifs[farthestIndex].data == nil && farthestIndex > currentRow {
                onlyFavoriteGifs[farthestIndex].getGifData()
                farthestIndex -= 1
            }
        case .scrollUpAll:
            farthestIndex = currentRow + count
            if farthestIndex >= giphs.count {farthestIndex = giphs.count - 1}
            while giphs[farthestIndex].data == nil && farthestIndex > currentRow {
                giphs[farthestIndex].getGifData()
                farthestIndex -= 1
            }
        case .scrollDownFavs:
            farthestIndex = currentRow - count
            if farthestIndex < 0 {farthestIndex = 0}
            while onlyFavoriteGifs[farthestIndex].data == nil && farthestIndex < currentRow {
                onlyFavoriteGifs[farthestIndex].getGifData()
                farthestIndex += 1
            }
        case .scrollDownAll:
            farthestIndex = currentRow - count
            if farthestIndex < 0 {farthestIndex = 0}
            while giphs[farthestIndex].data == nil && farthestIndex < currentRow {
                giphs[farthestIndex].getGifData()
                farthestIndex += 1
                }
            }
        }
    
    
    func cleanUp() {
        switch directionFavOrAll {
            
        case .scrollUpFavs:
            
            onlyFavoriteGifs[favLowestIndexWithData].data = nil
            favLowestIndexWithData += 1
            if favLowestIndexWithData >= onlyFavoriteGifs.count {favLowestIndexWithData = onlyFavoriteGifs.count - 1}
            
        case .scrollUpAll:
            
            giphs[lowestIndexWithData].data = nil
            lowestIndexWithData += 1
            if lowestIndexWithData >= giphs.count {lowestIndexWithData = giphs.count - 1}
            
        case .scrollDownFavs:
            
            onlyFavoriteGifs[favHighestIndexWithData].data = nil
            favLowestIndexWithData -= 1
            if favLowestIndexWithData < 0 {favLowestIndexWithData = 0}
            
        case .scrollDownAll:
            
            giphs[highestIndexWithData].data = nil
            highestIndexWithData -= 1
            if highestIndexWithData < 0 {highestIndexWithData = 0}
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
    func downloadImageFrom(link:String, _ row: Int, _ favsOnly: Bool) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  UIViewContentMode.scaleAspectFill
                if let data = data {
                    let img = UIImage.gif(data: data)
                    self.image = img
                }
            }
        }).resume()
    }
}

extension Giph {
    func getGifData() {
        URLSession.shared.dataTask( with: NSURL(string:self.url)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                if let data = data {
                    self.data = data
                }
            }
        }).resume()
    }
}
//cell.img.image = UIImage.gif(data: onlyFavoriteGifs[row].data!)
//albumArt.image = UIImage(named: "placeholder")
//albumArt.downloadImageFrom(link: "http://someurl.com/image.jpg", contentMode: UIViewContentMode.scaleAspectFit)

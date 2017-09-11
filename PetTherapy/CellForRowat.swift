import UIKit
import CoreData

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


        if showOnlyFavorites {
            if let data = onlyFavoriteGifs[row].value(forKey: "data") as? Data {
                cell.img.downloadImageFrom(data)
            } else {
                cell.img.downloadImageFrom(cell, link: (onlyFavoriteGifs[row].value(forKey: "url") as? String)!, row, showOnlyFavorites)
                print("We should have called the fetch favs", giphs[row].url)
            }
            cell.favoriteBtn.setImage(#imageLiteral(resourceName: "purpleHeartR"), for: .normal)
        } else {
            if let data = GifCache.shared.general.object(forKey: row as AnyObject) {
                print("we cached this one: \(row)")
                cell.img.downloadImageFrom(data as! Data)
                print("we should have used it\(row)")
            } else {
                
                cell.img.downloadImageFrom(cell, link: giphs[row].url, row, showOnlyFavorites)
                print("we should have called the fetch", giphs[row].url)
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
        
        //getNext(5, currentRow: row)
        //cleanUp(currentRow: row)
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
    
    
//    func getNext(_ count: Int, currentRow: Int) {
//        var farthestIndex: Int
//        switch directionFavOrAll {
//        case .scrollUpFavs:
//            farthestIndex = currentRow + count
//            if farthestIndex >= onlyFavoriteGifs.count {farthestIndex = onlyFavoriteGifs.count - 1}
//            while onlyFavoriteGifs[farthestIndex].value(forKey: "data") == nil && farthestIndex > currentRow {
//                onlyFavoriteGifs[farthestIndex].getGifData()
//                farthestIndex -= 1
//            }
//        case .scrollUpAll:
//            farthestIndex = currentRow + count
//            if farthestIndex >= giphs.count {farthestIndex = giphs.count - 1}
//            while giphs[farthestIndex].data == nil && farthestIndex > currentRow {
//                giphs[farthestIndex].getGifData()
//                farthestIndex -= 1
//            }
//        case .scrollDownFavs:
//            farthestIndex = currentRow - count
//            if farthestIndex < 0 {farthestIndex = 0}
//            while onlyFavoriteGifs[farthestIndex].value(forKey: "data") == nil && farthestIndex < currentRow {
//                onlyFavoriteGifs[farthestIndex].getGifData()
//                farthestIndex += 1
//            }
//        case .scrollDownAll:
//            farthestIndex = currentRow - count
//            if farthestIndex < 0 {farthestIndex = 0}
//            while giphs[farthestIndex].data == nil && farthestIndex < currentRow {
//                giphs[farthestIndex].getGifData()
//                farthestIndex += 1
//                }
//            }
//        }
//    
//    
//    func cleanUp(currentRow: Int) {
//        
//        switch directionFavOrAll {
//        case .scrollUpFavs:
//            favLowestIndexWithData = currentRow - 10
//            if favLowestIndexWithData < 0 {return}
//            for index in 0...favLowestIndexWithData {
//                onlyFavoriteGifs[index].value(forKey: "data") = nil
//            }
//            favLowestIndexWithData += 1
//            
//        case .scrollUpAll:
//            lowestIndexWithData = currentRow - 10
//            if lowestIndexWithData < 0 {return}
//            for index in 0...lowestIndexWithData {
//                giphs[index].data = nil
//            }
//            lowestIndexWithData += 1
//            
//        case .scrollDownFavs:
//            favHighestIndexWithData = currentRow + 10
//            if favHighestIndexWithData >= onlyFavoriteGifs.count {return}
//            for index in favHighestIndexWithData..<onlyFavoriteGifs.count {
//                onlyFavoriteGifs[index].data = nil
//            }
//            favHighestIndexWithData -= 1
//            
//        case .scrollDownAll:
//            highestIndexWithData = currentRow + 10
//            if highestIndexWithData >= giphs.count {return}
//            for index in highestIndexWithData..<giphs.count {
//                giphs[index].data = nil
//            }
//            highestIndexWithData -= 1
//        }
//    }
    
    
    
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
                    if #available(iOS 10.0, *) {
                        self.saveFavorite(gifID)
                    } else {
                        print("notify user that favorites will not be saved")
                    }
                    
                }
            }
            sender.setImage(#imageLiteral(resourceName: "purpleHeartR"), for: .normal)
            buttonStates[gifID] = true
        }
    }
    
    func saveFavorite(_ fav: Giph) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        if #available(iOS 10.0, *) {
            let context = appDelegate.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "FavGiph", in: context)!
            
            let favoriteGiph = NSManagedObject(entity: entity, insertInto: context)
                favoriteGiph.setValue(fav.data, forKey: "data")
                favoriteGiph.setValue(fav.height, forKey: "height")
                favoriteGiph.setValue(fav.width, forKey: "width")
                favoriteGiph.setValue(fav.url, forKey: "url")
                favoriteGiph.setValue(fav.youtubeURL, forKey: "youtubeURL")
            do {
                try context.save()
                onlyFavoriteGifs.append(favoriteGiph)
            } catch let error as NSError {
                print("could not save. \(error), \(error.userInfo)")
            }
        }
   }
    
    func deleteFavorite(_ fav: NSManagedObject) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        if #available(iOS 10.0, *) {
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Giph")
            if let result = try? context.fetch(fetchRequest) {
                for object in result {
                    if object.value(forKeyPath: "url") as? String == fav.value(forKeyPath: "url") as? String {
                        context.delete(object)
                    }
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }
    
}



extension UIImageView {
    func downloadImageFrom(_ cell: UITableViewCell, link:String, _ row: Int, _ favsOnly: Bool)  {
        print("call", Date())
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            if error != nil {
                print("error", error!, Date())
            }
            DispatchQueue.main.async {
                self.contentMode =  UIViewContentMode.scaleAspectFill
                if let data = data {
                    let img = UIImage.gif(data: data)
                    self.image = img
                    print("data came in", Date())
                    DispatchQueue.global(qos: .background).async {
                        GifCache.shared.general.setObject(data as AnyObject, forKey: row as AnyObject)
                    }
                }

            }
        }).resume()
        
    }
    
    func downloadImageFrom(_ data: Data) {
        let img = UIImage.gif(data: data)
        self.image = img
        
    }
}

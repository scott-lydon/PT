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

        cell.img.image = nil
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
            
            if let wasSelected = buttonStates[giphs[row].url] {
                if wasSelected {
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

    
    func btnPress(sender: UIButton!) {
        print("button tapped")
        let activityVC = UIActivityViewController(activityItems: [self.giphs[sender.tag].url], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        self.present(activityVC, animated: true, completion: nil)
    }
    
    func alterFavCount(sender: UIButton!) {
        if sender.imageView?.image == #imageLiteral(resourceName: "purpleHeartR") {
            removeGifFromFavs(sender)
        } else {
            addGifToFavs(sender)
        }
    }

    func removeGifFromFavs(_ sender: UIButton) {
        let row = sender.tag
        var gifURL = giphs[row].url
        if !showOnlyFavorites {
            for (index, nsManagedObj) in onlyFavoriteGifs.enumerated() {
                if gifURL == nsManagedObj.value(forKey: "url") as? String {
                    let test = onlyFavoriteGifs.remove(at: index)
                    print(test.value(forKey: "url"), "should be removed")
                }
            }
        } else {
            let index = row - 1
            let test = onlyFavoriteGifs.remove(at: index)
            print(test.value(forKey: "url"), "should be removed")
            gifURL = (onlyFavoriteGifs[row].value(forKey: "url") as? String)!
        }
        sender.setImage(#imageLiteral(resourceName: "WhiteHeartR"), for: .normal)
        buttonStates[gifURL] = false
    }
    
    
    
    func addGifToFavs(_ sender: UIButton) {
        let gifURL = giphs[sender.tag].url
        DispatchQueue.global(qos: .background).async {
            //add the value to the favorites array if it isn't there already.
            var has = false
            for gifData in self.onlyFavoriteGifs {
                if gifData.value(forKey: "url") as? String == gifURL {
                    has = true
                }
            }
            if !has {
                if #available(iOS 10.0, *) {
                    self.saveFavorite(self.giphs[sender.tag])
                } else {
                    print("notify user that favorites will not be saved")
                }
            }
        }
        sender.setImage(#imageLiteral(resourceName: "purpleHeartR"), for: .normal)
        buttonStates[gifURL] = true
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
                        print(#line, "reached")
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
                    print("data came in for row \(row) at ", Date())
                    
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

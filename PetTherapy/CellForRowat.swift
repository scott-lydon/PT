import UIKit
import CoreData

extension GiphyVC {
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let cell = tableView.dequeueReusableCell(withIdentifier: giphCellReuseIdentifier, for: indexPath) as! GifTableViewCell
        print(#line, "<-Reached")
        cell.imageView?.image = nil
       
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
            }
            cell.favoriteBtn.setImage(#imageLiteral(resourceName: "purpleHeartR"), for: .normal)
        } else {
            if let data = GifCache.shared.general.object(forKey: row as AnyObject) {
                print(#line, "<-Reached", row)
                cell.img.image = nil
                cell.img.downloadImageFrom(data as! Data)
            } else {
                print(#line, "<-Reached", "can't get from cache")
                cell.img.downloadImageFrom(cell, link: giphs[row].url, row, showOnlyFavorites)
            }
            //One time it crashed on the next line...Not sure how or why, it said index was out of range.  wasSelected = nil.  Buttonstates.count = 0, giphs[row].url was a url, 30 count in giphs.
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
        print(#function, #line, sender.tag)
        let row = sender.tag
        var gifURL = giphs[row].url
        if !showOnlyFavorites {
            for (index, nsManagedObj) in onlyFavoriteGifs.enumerated() {
                if gifURL == nsManagedObj.value(forKey: "url") as? String {
                    onlyFavoriteGifs.remove(at: index)
                    deleteFavorite(onlyFavoriteGifs[index])
                }
            }
        } else {
            print(sender.tag, #line)
            let index = row
            print(index)
            gifURL = (onlyFavoriteGifs[row].value(forKey: "url") as? String)!
            print("The index => ", index, "count", onlyFavoriteGifs.count)
            deleteFavorite(onlyFavoriteGifs[index])
            onlyFavoriteGifs.remove(at: index)
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
        print(#function, #line)
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        if #available(iOS 10.0, *) {
            let context = appDelegate.persistentContainer.viewContext
            context.delete(fav)
            do {
                try context.save()
            } catch {
                print("catch")
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            /*
            let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Giph")
            if let result = try? context.fetch(fetchRequest) {
                for object in result {
                    if object.value(forKeyPath: "url") as? String == fav.value(forKeyPath: "url") as? String {
                        context.delete(object)
                    }
                }
            }*/
        }
    }
}



extension UIImageView {
    func downloadImageFrom(_ cell: UITableViewCell, link:String, _ row: Int, _ favsOnly: Bool)  {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            if error != nil {
                print("error", error!, Date())
            }
            DispatchQueue.main.async {
                print(#line, "<-Reached")
                self.image = nil
                self.contentMode =  UIViewContentMode.scaleAspectFill
                if let data = data {
                    let img = UIImage.gif(data: data)
                    self.image = img
                    
                    DispatchQueue.global(qos: .background).async {
                        if !favsOnly {
                            GifCache.shared.general.setObject(data as AnyObject, forKey: row as AnyObject)
                        }
                    }
                }

            }
        }).resume()
        
    }
    
    func downloadImageFrom(_ data: Data) {
        print(#line, "<-Reached")
        self.image = nil
        let img = UIImage.gif(data: data)
        self.image = img
        
    }
}

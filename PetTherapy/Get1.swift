
import UIKit
import Foundation



extension Get {
 
        func firstGiphData(completion: @escaping ([[String]], String) -> Void)  {
            
        var isBigScreen = false
        let deviceName = UIDevice.current.deviceName()
        if deviceName == "iPhone7,1" || deviceName == "iPhone8,2" || deviceName == "iPhone9,2" || deviceName == "iPhone9,4" || UIDevice.current.model == "iPad" {
            isBigScreen = true
        }
            
        let petOptions = ["dogs", "puppies", "kittens", "cats", "penguin", "otter", "red+panda", "fennec+fox", "baby+hamster", "baby+mouse", "baby+elephant", "baby+seal", "baby+raccoon", "baby+pig", "baby+bunny", "bunny", "baby+sloth", "baby+panda", "baby+fox", "baby+monkey", "baby+hedgehog", "duckling", "kitten", "baby+ferret"]
        
        let petChoice = petOptions.randomItem()
          
        
        let kURL = "http://api.giphy.com/v1/gifs/search?q=\(petChoice)&api_key=291f380b87884fc8996bd9d0078c42e3&limit=30&offset=\(callCount)"
        callCount += 30
        let newsURL = URL(string: kURL)
        let task = URLSession.shared.dataTask(with: newsURL! as URL) {
            (data, response, error) in
            if error != nil {
                print("there is an error -SL")
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                    if let giphData = json["data"] as? [[String: Any]] {
                        var giphArr = [[String]]()
                        for giphy in giphData {
                            if let id = giphy["id"] as? String {
                                if let images = giphy["images"] as? [String: Any] {
                                    
                                    var giphSize = "fixed_width"
                                    if isBigScreen {
                                        giphSize = "original"
                                    }
                                    if let fixedWidth = images[giphSize] as? [String: String] {
                                        if let url = fixedWidth["url"] {
                                         
                                                if id != "yjGdFXjeQsDqJNSzE4" {
                                                    giphArr += [[url, id]]
                                                }
                                       }
                                    }
                               }
                            }
                        }
                        completion(giphArr, self.getYoutubeUrl(animalType: petChoice))
                    }
                } catch {print("caught")}
            }
        }// URLSession...
        task.resume()
        
    }//firstGiphData
}//Get





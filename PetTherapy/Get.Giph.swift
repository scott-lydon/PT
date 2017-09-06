
import UIKit
import Foundation

let fetchCount = 30

class Get {
 
    static let shared = Get()
    init() {}
    
    var repeatCheck = [String:Bool]()
    var callCount = 0
    
        func giphs(completion: @escaping (Double, Double, String, String) -> Void)  {
            
        var isBigScreen = false
        let deviceName = UIDevice.current.deviceName()
//        if deviceName == "iPhone7,1" || deviceName == "iPhone8,2" || deviceName == "iPhone9,2" || deviceName == "iPhone9,4" || UIDevice.current.model == "iPad" {
//            isBigScreen = true
//            print("set big screen to true")
//        } else {
//            print("left big screen as falase")
//        }
            
        let petOptions = ["dogs", "puppies", "kittens", "cats", "penguin", "otter", "red+panda", "fennec+fox", "baby+hamster", "baby+mouse", "baby+elephant", "baby+seal", "baby+raccoon", "baby+pig", "baby+bunny", "bunny", "baby+sloth", "baby+panda", "baby+fox", "baby+monkey", "baby+hedgehog", "duckling", "kitten", "baby+ferret"]
        
        let petChoice = petOptions.randomItem()
        
        
        let kURL = "http://api.giphy.com/v1/gifs/search?q=\(petChoice)&api_key=291f380b87884fc8996bd9d0078c42e3&limit=\(fetchCount)&offset=\(callCount)"
            
        callCount += fetchCount
        let newsURL = URL(string: kURL)
        let task = URLSession.shared.dataTask(with: newsURL! as URL) {
            (data, response, error) in
            if error != nil {
                print("there is an error -SL")
            } else {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as! [String: Any]
                    if let giphData = json["data"] as? [[String: Any]] { // All gifs for call
                        //var giphArr = [String]()
                        for giphy in giphData {
                            if let id = giphy["id"] as? String {
                                if id == "yjGdFXjeQsDqJNSzE4" {
                                    continue
                                }
                                if let images = giphy["images"] as? [String: Any] {
                                    
                                    var giphSize = "fixed_width"
                                    if isBigScreen {
                                        giphSize = "original"
                                    }
                                    if let size = images[giphSize] as? [String: String] {

                                        guard let width = size["width"] else {continue}
                                        guard let height = size["height"] else {continue}
                                        guard let url = size["url"] else {continue}
                                        if let widthInt = Double(width) {
                                            if let heightInt = Double(height)  {
                                                if widthInt > 0 && heightInt > 0 {
                                                     completion(widthInt, heightInt, url, self.getYoutubeUrl(animalType: petChoice))
                                                }
                                            }
                                        }
                                    }
                               }
                            }
                        }
                        //completion(giphArr, self.getYoutubeUrl(animalType: petChoice))
                    }
                } catch {print("caught")}
            }
        }// URLSession...
        task.resume()
    }//firstGiphData
}//Get





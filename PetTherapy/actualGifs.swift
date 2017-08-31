import Foundation

class Get {
    
    static let shared = Get()
    init() {}
    
     var repeatCheck = [String:Bool]()
    var callCount = 0
    
    func gifsImages(giphARr: [Giph], completion: @escaping ([Data]) -> Void ) {
        //let disGroup = DispatchGroup()

        var exitArr = [Data]()

        for giph in giphARr {
            if let url = giph.url {
           
                //disGroup.enter()
                let task = URLSession.shared.dataTask(with: url)  {
                    (data, response, error) in
                    
                    //IT TAKES A LONG TIME TO REACH THIS POINT>
                    if error != nil {
                        print("there is an error -SL")
                    }
                    else {
                        exitArr += [data!]
                        completion(exitArr)
                        //disGroup.leave()
                    }
                }
                
                task.resume()
            }
            
        }
//        disGroup.notify(queue: .main) {
//            
//            completion(exitArr)
//        }
     }//func secondGifphData
}//Class Get


//WITH DISPATCH GROUPS INSTEAD OF Loading a few, it waits till all of them are got. The ones that come in should be loaded on to the back of the array, and then the table should be reloaded as each comes in.Not wait until all of them come in to show anything.


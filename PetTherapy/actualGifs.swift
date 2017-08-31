import Foundation

class Get {
    
    static let shared = Get()
    init() {}
    
     var repeatCheck = [String:Bool]()
    var callCount = 0
    
    func actualGiphs(giphARr: [[String]], completion: @escaping ([Data]) -> Void ) {
        //let disGroup = DispatchGroup()

        var exitArr = [Data]()

        for giph in giphARr {

            if giph[0].isEmpty == false {

                //disGroup.enter()
                
                let url = URL(string: "\(giph[0])")
                
                print("-->", #function, #line, Date())
                let task = URLSession.shared.dataTask(with: url! as URL)  {
                    (data, response, error) in
                    
                    //IT TAKES A LONG TIME TO REACH THIS POINT>  WITH DISPATCH GROUPS INSTEAD OF Loading a few, it waits till all of them are got. The ones that come in should be loaded on to the back of the array, and then the table should be reloaded as each comes in.Not wait until all of them come in to show anything. 
                    
                    print("-->", #function, #line, Date())
                    if error != nil
                    {print("-->", #function, #line, Date())
                        print("there is an error -SL")
                    }
                        
                    else
                    {     print("-->", #function, #line, Date())
                        exitArr += [data!]
                        completion(exitArr)
                        //disGroup.leave()
                    }
                }
                print("-->", #function, #line, Date())
                task.resume()
            }
            
        }
//        disGroup.notify(queue: .main) {
//            
//            completion(exitArr)
//        }
     }//func secondGifphData
}//Class Get

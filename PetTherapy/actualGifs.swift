import Foundation

class Get {
    
    static let shared = Get()
    init() {}
    
     var repeatCheck = [String:Bool]()
    var callCount = 0

    func gifsImages(giphArray: inout [Giph], completion: @escaping ([Giph]) -> Void ) {
        var exitArr = [Giph]()
        for giph in giphArray {
            let concurrentQueue = DispatchQueue(label: "queuename", attributes: .concurrent)
            concurrentQueue.sync {
                if let url = giph.url {
                    let task = URLSession.shared.dataTask(with: url)  {
                        (data, response, error) in
                        if error != nil {
                            print("there is an error -SL")
                        }
                        else {
                            giph.data = data!
                            exitArr += [giph]
                            completion(exitArr)
                        }
                    }
                    task.resume()
                }

            }
        }
     }
}


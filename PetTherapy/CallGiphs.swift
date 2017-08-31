
import UIKit
import Foundation


extension GiphyVC{
    func getSetGifs(){
        print("-->", #function, #line, Date())
        Get.shared.giphEndpoints() {
            (gifEndPoints, chosenAnimal) in
          
            Get.shared.actualGiphs(giphARr: gifEndPoints, completion:{
                (dataArr) in
               
                List.shared.animalURLs += [chosenAnimal]
                self.gifDatas += dataArr
                DispatchQueue.main.async
                {
                    
                    self.activityIndicator.stopAnimating()
                    self.view.isUserInteractionEnabled = true
                    self.activityIndicator2.stopAnimating()
                    self.tableView.reloadData()
                    self.isNewDataLoading = false
                    print("-->", #function, #line, Date())
                    print("reached main queue")
                }
            })
        }
    }
}

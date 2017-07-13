
import UIKit
import Foundation


extension GiphyVC
{
    func getSetGifs()
    {
        Get.shared.firstGiphData()
        {
            (gifArr, chosenAnimal) in
            
            
            Get.shared.secondGiphData(giphARr: gifArr, completion:
            { (dataArr) in
                
                List.shared.animalURLs += [chosenAnimal]
                self.gifDatas += dataArr
                DispatchQueue.main.async
                {
                    
                    self.activityIndicator.stopAnimating()
                    self.view.isUserInteractionEnabled = true
                    self.activityIndicator2.stopAnimating()
                    self.tableView.reloadData()
                    self.isNewDataLoading = false
                    print("reached main queue")
                }
            })
        }
    }
}

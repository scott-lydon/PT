
import UIKit
import Foundation


extension GiphyVC{
    func getSetGifs(){
        print("-->", #function, #line, Date())
        // var startingGifs = self.readyToDisplayGiphs
        Get.shared.giphEndpoints() {
            (gifsWithEndPoints) in
            var gifsWithEndPoints = gifsWithEndPoints
            Get.shared.gifsImages(giphArray: &gifsWithEndPoints, completion:{
                (giphs) in
                let giph: Giph = giphs[0]
                List.shared.animalURLs += [giph.youtubeURL!]
                self.readyToDisplayGiphs = giphs
                
                
                DispatchQueue.main.async  {
                    self.activityIndicator.stopAnimating()
                    self.view.isUserInteractionEnabled = true
                    self.activityIndicator2.stopAnimating()
                    self.tableView.reloadData()
                    self.isNewDataLoading = false
                }
            })
        }
    }
}

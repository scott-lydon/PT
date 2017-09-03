
import UIKit
import Foundation


extension GiphyVC
{
    func getSetGifs()
    {
        Get.shared.giphs()
        {
            //(gifEndPoints, animalSoundEndPoint) in
            (width, height, gifEndPoints, animalSoundEndPoint) in
//            for gifEndpoint in gifEndPoints {// GifEndpoints has [url, id] this is why I'm getting every other cell. 
//                self.giphs.append(Giph(gifEndpoint, animalSoundEndPoint))
//            }
            self.giphs.append(Giph(width, height, gifEndPoints, animalSoundEndPoint))
            DispatchQueue.main.async
                {
                    self.activityIndicator.stopAnimating()
                    self.view.isUserInteractionEnabled = true
                    self.activityIndicator2.stopAnimating()
                    self.tableView.reloadData()
                    self.isNewDataLoading = false
                    print("reached main queue")
            }
        }
    }
}

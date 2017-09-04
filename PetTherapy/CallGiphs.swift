
import UIKit
import Foundation


extension GiphyVC
{
    func getSetGifs()
    {
        Get.shared.giphs()
        {
            (width, height, gifEndPoints, animalSoundEndPoint) in
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

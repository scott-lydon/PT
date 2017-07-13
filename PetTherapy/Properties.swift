
import UIKit

class GiphyVC: UIViewController {

    let giphCellReuseIdentifier = "giphCellReuseIdentifier"
    var gifDatas = [Data]()
    let tableView = UITableView()
    var activityIndicator = UIActivityIndicatorView()
    var activityIndicator2 = UIActivityIndicatorView()
    var gifCounter = [String: Bool]()
    var isNewDataLoading = false
    var callCount = 0
    let giphyLogoView = UIImageView()
    var buttonStates = [Data: Bool]()
    var showOnlyFavorites = false
    var onlyFavoriteGifs = [Data]()
    
    }





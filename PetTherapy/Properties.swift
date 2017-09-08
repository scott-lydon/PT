
import UIKit
import CoreData

class GiphyVC: UIViewController {

    let giphCellReuseIdentifier = "giphCellReuseIdentifier"
    var giphs = [Giph]()
    let tableView = UITableView()
    var activityIndicator = UIActivityIndicatorView()
    var activityIndicator2 = UIActivityIndicatorView()
    var gifCounter = [String: Bool]()
    var isNewDataLoading = false
    var callCount = 0
    let giphyLogoView = UIImageView()
    var buttonStates = [Giph: Bool]()
    var showOnlyFavorites = false
    var onlyFavoriteGifs = [Giph]()
    
    var highestIndexWithData = 0
    var lowestIndexWithData = 0
    var lastCellForRowAtIndex = 0
    
    var favHighestIndexWithData = 0
    var favLowestIndexWithData = 0
    var favLastCellForRowAtIndex = 0
    
    var defaults = UserDefaults.standard
    
    var isScrollingUp = false
    
    enum Direction {
        case up, down
        }
    var deleteIndex = 0
    
    }






import UIKit
import CoreData

extension GiphyVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        session = URLSession.shared
        task = URLSessionDownloadTask()
        
        self.refreshCtrl = UIRefreshControl()
        print()
        
        checkConnectivity()
        getSetGifs()
        configureTableView()
        if showOnlyFavorites {
            self.tableView.tableFooterView?.isHidden = true
        } else {
            configureFooter()
        }
        
        configureActivityIndicator()
        tableView.backgroundColor = bluePurple
        tableView.addSubview(giphyLogoView)
        tableView.bringSubview(toFront: giphyLogoView)
        
        giphyLogoView.frame = CGRect(x: 0, y: 0, width: 50, height: 70)
        giphyLogoView.loadGif(name: "giphyLogo")
        
        
        let mySEgmentedControl = UISegmentedControl(items: ["All Gifs", "Favorites"])
        mySEgmentedControl.sizeToFit()
        mySEgmentedControl.tintColor = UIColor.white
        mySEgmentedControl.selectedSegmentIndex = 0
        mySEgmentedControl.addTarget(self, action: #selector(showFavoritesOrGeneral), for: .valueChanged)
        navigationItem.titleView = mySEgmentedControl
    }
    
    


}

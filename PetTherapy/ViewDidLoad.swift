
import UIKit


extension GiphyVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
       
        checkConnectivity()
        getSetGifs()
        configureTableView()
        configureFooter()
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
        
        //print(self.navigationController?.navigationBar.heightAnchor)
    }
    



}

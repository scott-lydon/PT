
import UIKit
import Foundation
import WebKit

class WebViewVC: UIViewController, WKUIDelegate {
    
    var webURLStr =  "http://www.jogendra.com"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var webV: WKWebView!
        webV = WKWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        webV.load(URLRequest(url: URL(string: webURLStr)!))
        webV.uiDelegate = self
        self.view.addSubview(webV)
    }
    
}





/*
 dogs/puppies
 
 
 
 
 
 
 
 */

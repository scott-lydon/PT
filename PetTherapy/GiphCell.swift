
import UIKit
import Foundation


class GiphCell: UITableViewCell {
    
    let btn = UIButton()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let buttonWidth = CGFloat(20)
        let buttonHeight = CGFloat(20)
        let margin = CGFloat(20)
        btn.backgroundColor = bluePurple
        btn.frame = CGRect(x: contentView.bounds.width - buttonWidth - margin, y: contentView.bounds.height - buttonHeight - margin, width: buttonWidth, height: buttonHeight)
    }
    
  
}


/*
 
 



 
 
 
 
 
 var myLabel = UILabel()
 
 override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
 super.init(style: style, reuseIdentifier: reuseIdentifier)
 
 myLabel.backgroundColor = UIColor.yellowColor()
 self.contentView.addSubview(myLabel)
 }
 
 required init?(coder aDecoder: NSCoder) {
 super.init(coder: aDecoder)
 }
 
 override func layoutSubviews() {
 super.layoutSubviews()
 
 myLabel.frame = CGRect(x: 20, y: 0, width: 70, height: 30)
 }
 
 
 */

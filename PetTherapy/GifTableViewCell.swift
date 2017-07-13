
import Foundation
import UIKit

class GifTableViewCell: UITableViewCell {
    
    let img = UIImageView()
    let btn = UIButton()
    let favoriteBtn = UIButton()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
   
        contentView.addSubview(img)
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.translatesAutoresizingMaskIntoConstraints = false
    
        img.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        img.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        img.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        img.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        contentView.addSubview(favoriteBtn)
        favoriteBtn.setBackgroundImage(#imageLiteral(resourceName: "WhiteHeartR"), for: .normal)
        
        let buttonWidth = CGFloat(30)
        let buttonHeight = CGFloat(30)
        let margin = CGFloat(10)
        
        let btnX = contentView.bounds.width - buttonWidth - margin
        let btnY = contentView.bounds.height - buttonHeight - margin
        
        let favX = contentView.bounds.width - buttonWidth - 2 * margin - buttonWidth
        let favY = contentView.bounds.height - buttonHeight - margin
        
        favoriteBtn.frame = CGRect(x: favX, y: favY, width: buttonWidth, height: buttonHeight)

        contentView.addSubview(btn)

        btn.setBackgroundImage(#imageLiteral(resourceName: "share"), for: .normal)
        
        btn.frame = CGRect(x: btnX, y: btnY, width: buttonWidth, height: buttonHeight)
        
        favoriteBtn.addTarget(self, action: #selector(favBtnPress), for: .touchUpInside)
        
        
    }
  
    func favBtnPress(sender: UIButton!) {
       
    }
    
   
       

}

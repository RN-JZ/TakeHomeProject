



import UIKit

class GH_Button: UIButton {
    
    override init(frame: CGRect)
    {
     super.init(frame: frame)
     configure()
     
    }
    
    init(backgroungColor:UIColor , title:String)
    {
        super.init(frame: .zero)
        self.backgroundColor = backgroungColor
        self.setTitle(title, for: .normal)
        configure()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(backgroungColor:UIColor , title:String)
    {
       
        self.backgroundColor = backgroungColor
        self.setTitle(title, for: .normal)
        
        
    }
    
    
    
}


extension GH_Button
{
    
    // MARK: - STYLE
    private func configure()
    {
       
        layer.cornerRadius    =    10
        titleLabel?.textColor =   .white
        titleLabel?.font      =    UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
        
    }
}

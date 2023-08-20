



import UIKit

class GH_TextField: UITextField {

    override init(frame: CGRect)
    {
     super.init(frame: frame)
     configure()
     
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension GH_TextField
{
    
    // MARK: - STYLE
    private func configure()
    {
       
        layer.cornerRadius             = 10
        layer.borderWidth              = 2
        layer.borderColor              = UIColor.systemGray4.cgColor
        
        textColor                      = .label
        tintColor                      = .label // color of cursor
        
        textAlignment                  = .center
        font                           = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth      = true // font will fit for large name and min it goes is 12
        minimumFontSize                = 12

        backgroundColor                = .tertiarySystemBackground
        autocorrectionType             = .no
        returnKeyType                  = .go
        
        placeholder                    = "Enter a userName"
        
        translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    
}


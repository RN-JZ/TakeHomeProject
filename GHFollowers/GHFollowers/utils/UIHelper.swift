



import Foundation
import UIKit


struct UIHelper
{
    static func createThreeColoumnFlowLayout(in view:UIView)->UICollectionViewFlowLayout
    {
        let width                              = view.bounds.width
        let padding:CGFloat                    = 12
        let minimumItemSpacing :CGFloat        = 10
        let availableWidth                     = width - (2*padding)-(2*minimumItemSpacing)
        let itemWidth                          = availableWidth / 3
        
        let flowlayout                         = UICollectionViewFlowLayout()
        flowlayout.sectionInset                = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowlayout.itemSize                    = CGSize(width: itemWidth, height: itemWidth + 40)
        return flowlayout
    }
}

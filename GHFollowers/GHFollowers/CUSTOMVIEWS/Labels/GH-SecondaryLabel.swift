//
//  GH-SecondaryLabel.swift
//  GHFollowers
//
//  Created by jahanzaib on 03/08/2023.
//

import UIKit

class GH_SecondaryLabel: UILabel {

    override init(frame: CGRect) {
           super.init(frame: frame)
           configure()
       }
       
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
       
    init(fontSize:CGFloat) {
           super.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize , weight: .medium)
           configure()
       }
       
       
       private func configure() {
           textColor                   = .secondaryLabel
           font                        = UIFont.preferredFont(forTextStyle: .body)
           adjustsFontSizeToFitWidth   = true
           minimumScaleFactor          = 0.90
           lineBreakMode               = .byTruncatingTail
           translatesAutoresizingMaskIntoConstraints = false
       }

}

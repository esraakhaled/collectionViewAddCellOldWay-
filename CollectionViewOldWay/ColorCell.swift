//
//  ColorCell.swift
//  CollectionViewOldWay
//
//  Created by Esraa Khaled   on 22/08/2022.
//

import UIKit

class ColorCell: UICollectionViewCell {
    
    @IBOutlet weak var musicImg: UIImageView!
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var musicTxt: UILabel!
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        
        setNeedsLayout()
        layoutIfNeeded()
        
        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
        
        var frame = layoutAttributes.frame
        frame.size.height = ceil(size.height)
        layoutAttributes.frame = frame
        
        return layoutAttributes
    }
}

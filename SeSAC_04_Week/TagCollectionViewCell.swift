//
//  TagCollectionViewCell.swift
//  SeSAC_04_Week
//
//  Created by 김정민 on 2021/10/19.
//

import UIKit

class TagCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tagLabel: UILabel!
    
    static let identifier = "TagCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

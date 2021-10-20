//
//  MainCollectionViewCell.swift
//  SeSAC_04_Week
//
//  Created by 김정민 on 2021/10/19.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var heartButton: UIButton!
    static var identifier = "MainCollectionViewCell"
    
    @IBOutlet weak var mainImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    

}

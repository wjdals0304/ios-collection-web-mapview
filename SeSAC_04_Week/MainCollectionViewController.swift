//
//  MainCollectionViewController.swift
//  SeSAC_04_Week
//
//  Created by 김정민 on 2021/10/19.
//

import UIKit

class MainCollectionViewController: UIViewController {
    
    // 1. collectionview 아웃렛 연결
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    var mainArray = Array(repeating: false,count: 100)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainCollectionView.tag = 100
        tagCollectionView.tag = 200
        
        
        //3. delegate
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
        
        tagCollectionView.delegate = self
        tagCollectionView.dataSource = self
        
        
        //4. xlb
        let nibName = UINib(nibName: MainCollectionViewCell.identifier , bundle : nil)
        mainCollectionView.register(nibName, forCellWithReuseIdentifier: MainCollectionViewCell.identifier)
        
        
        let tagnibName = UINib(nibName: TagCollectionViewCell.identifier , bundle : nil)
        tagCollectionView.register(tagnibName, forCellWithReuseIdentifier: TagCollectionViewCell.identifier)

        
        let spacing: CGFloat = 20
        let width = UIScreen.main.bounds.width - (spacing * 4)
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width / 3, height: (width / 3 ) * 1.2)
       
        
        layout.sectionInset = UIEdgeInsets(top:spacing,left:spacing,bottom:spacing,right:spacing)
        
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        layout.scrollDirection = .vertical
        mainCollectionView.collectionViewLayout = layout
        
        mainCollectionView.backgroundColor = .lightGray
        
        let tagLayout = UICollectionViewFlowLayout()
        let tagSpacing: CGFloat = 8
        tagLayout.scrollDirection = .horizontal
        tagLayout.itemSize = CGSize(width:100,height:40)
        tagLayout.sectionInset = UIEdgeInsets(top: 0 ,left: 20,bottom: 0,right: 20)
        tagCollectionView.collectionViewLayout = tagLayout
        
    }
    
    @objc func heartButtonClicked(selectButton: UIButton){
        print("\(selectButton.tag) 버튼 클릭!") // tag == indexPath.item
//
//        if    mainArray[selectButton.tag]  == true {
//            mainArray[selectButton.tag] = false
//        } else {
//            mainArray[selectButton.tag] = true
//        }
        
        mainArray[selectButton.tag] =  !mainArray[selectButton.tag]
        
//        mainCollectionView.reloadData()
        mainCollectionView.reloadItems(at: [ IndexPath(item: selectButton.tag, section: 0) ])
        
    }
    

}
// 2. collectionView
extension MainCollectionViewController : UICollectionViewDataSource ,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView.tag == 200 {
            return 10
        } else {
            return mainArray.count
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView.tag == 200 {
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TagCollectionViewCell.identifier, for: indexPath) as? TagCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            cell.tagLabel.text = "안녕하세욤"
            cell.layer.borderColor = UIColor.black.cgColor
            cell.layer.borderWidth = 1
            cell.layer.cornerRadius = 8
            
            
            return cell
            
        } else {
            
        
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier : MainCollectionViewCell.identifier,  for: indexPath ) as? MainCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            let item = mainArray[indexPath.item]
            
            cell.mainImageView.backgroundColor = .blue
            let image = item == true ? UIImage(systemName:"heart.fill") : UIImage(systemName:"heart")
            cell.heartButton.setImage(image, for: .normal)
            cell.heartButton.tag = indexPath.item
            cell.heartButton.addTarget(self, action: #selector(heartButtonClicked(selectButton:)), for: .touchUpInside)
            
            
            
            return cell
        }
        
 
    }
    
}

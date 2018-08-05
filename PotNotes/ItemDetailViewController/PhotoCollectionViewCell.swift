//
//  PhotoCollectionViewCell.swift
//  PotNotes
//
//  Created by Jimmy Birtwell on 25/03/2018.
//  Copyright © 2018 James Birtwell. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

class PhotoCollectionViewCell: UICollectionViewCell {
    static let id = "PhotoCollectionViewCell"
    
    var path: String? {
        didSet {
            potteryImage.image = #imageLiteral(resourceName: "icn_add_photo")
            guard let path = path else { return }
            ImageCache.default.retrieveImage(forKey: path, options: nil) { [weak self] (image, type) in
                 self?.potteryImage.image = image
            }
        }
    }
    
    lazy var potteryImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = UIColor.background.light
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required public init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    func setupView() {
        addSubview(potteryImage)
        potteryImage.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}

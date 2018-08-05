//
//  PotteryItemTableViewCell.swift
//  PotNotes
//
//  Created by Jimmy Birtwell on 28/01/2018.
//  Copyright © 2018 James Birtwell. All rights reserved.
//

import UIKit
import SnapKit

class PotteryItemTableViewCell: UITableViewCell {

    var potteryItem: PotteryItem? {
        didSet {
            nameLabel.text = potteryItem?.name
            objectType.text = potteryItem?.type?.title
        }
    }
    
    private var cardView = UIView()
    private var potteryImageView = UIImageView()
    private var nameLabel = MediumTitleLabel()
    private var objectType = MediumParagraphLabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupConstraints()
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
    }
    
    func setupCell() {
        backgroundColor = .clear
        cardView.backgroundColor = .white
        potteryImageView.backgroundColor = UIColor.magenta.withAlphaComponent(0.3)
        potteryImageView.image = #imageLiteral(resourceName: "pottery")
        potteryImageView.contentMode = .scaleAspectFit
        nameLabel.text = "Pottery item"
        objectType.text = "Some Pottery"
    }
    
    func setupConstraints() {
        addSubview(cardView)
        cardView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(16)
        }
        cardView.addShadowWith(elevation: 6)
        
        cardView.addSubview(potteryImageView)
        potteryImageView.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4)
        }
        
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .fill
        stackview.distribution = .equalSpacing
        stackview.spacing = 8
        stackview.setContentHuggingPriority(.defaultHigh, for: .vertical)
        cardView.addSubview(stackview)
        stackview.snp.makeConstraints { (make) in
            make.top.right.equalToSuperview().inset(8)
            make.left.equalTo(potteryImageView.snp.right).inset(-8)
//            make.bottom.greaterThanOrEqualToSuperview().inset(8)
        }
        stackview.addArrangedSubview(nameLabel)
        stackview.addArrangedSubview(objectType)

        
    }

}

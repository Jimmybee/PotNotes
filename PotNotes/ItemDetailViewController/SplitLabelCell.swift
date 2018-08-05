//
//  SplitLabelCell.swift
//  PotNotes
//
//  Created by Jimmy Birtwell on 25/03/2018.
//  Copyright © 2018 James Birtwell. All rights reserved.
//

import UIKit
import SnapKit

class SplitLabelCell: UITableViewCell {
    static let id = "SplitLabelCell"
    
    var potteryItem: PotteryItem? {
        didSet {
            titleLabel.text = potteryItem?.name
            splitDetailLabel.leftLabel.text = "Detail 1\nDetails 2\nDetail 3"
            splitDetailLabel.rightLabel.text = "02 Jan 2017\n£20"
            notesLabel.text = "Lorem epsum titum it in atum latun noeium noiem asinodn pnjas. Lorem epsum titum it in atum latun noeium noiem asinodn pnjas."
        }
    }
    let titleLabel = LargeTitleLabel()
    let splitDetailLabel = SplitLabelView()
    let notesLabel = MediumSubtitleLabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required public init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
    }
    
    func setupView() {
        addSubview(titleLabel)
        addSubview(splitDetailLabel)
        addSubview(notesLabel)
        notesLabel.numberOfLines = 0
        titleLabel.snp.makeConstraints { (make) in
            make.top.left.right.equalToSuperview().inset(12)
        }
        splitDetailLabel.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().inset(12)
            make.top.equalTo(titleLabel.snp.bottom).inset(-12)
        }
        notesLabel.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview().inset(12)
            make.top.equalTo(splitDetailLabel.snp.bottom).inset(-12)
        }
    }
}

class SplitLabelView: ReusableViewFromXib {
    
    @IBOutlet weak var leftLabel: MediumSubtitleLabel!
    @IBOutlet weak var rightLabel: UILabel!
    
}

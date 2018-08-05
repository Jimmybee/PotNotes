//
//  PickerViewController.swift
//  easySwitch
//
//  Created by James Birtwell on 30/05/2017.
//  Copyright © 2017 Warmup. All rights reserved.
//

import UIKit
import SnapKit

protocol PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource  {
    
    var scrollView: UIScrollView! { get }
    var pickerView: UIPickerView { get }
    var toolBar: CustomToolBar { get }
    
    func applyPressed()
    func dismissPressed()
    func setupPicker()
    
}

extension PickerViewController where Self: UIViewController {
    
    func setupConstraints() {
        view.addSubview(pickerView)
        view.addSubview(toolBar)
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        pickerView.snp.makeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
        }
        toolBar.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(pickerView.snp.top)
        }
        
        PickerControllerCache.scrollViewInsets = scrollView.contentInset
    }
    
    func displayPickerAs(open: Bool) {
        pickerView.isHidden = false
        toolBar.isHidden = false
        open ? showPickerView() : hidePickerView()
        let heightInset = pickerView.frame.height + toolBar.frame.height
        let contentInsets = open ? UIEdgeInsetsMake(0, 0.0, heightInset, 0.0) : PickerControllerCache.scrollViewInsets
        scrollView.contentInset = contentInsets
    }
    
    func showPickerView() {
        pickerView.snp.remakeConstraints { (make) in
            make.bottom.left.right.equalToSuperview()
        }
        toolBar.snp.remakeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.bottom.equalTo(pickerView.snp.top)
        }
    }
    
    func hidePickerView() {
        pickerView.snp.remakeConstraints { (make) in
            make.left.right.equalToSuperview()
        }
        
        toolBar.snp.remakeConstraints { (make) in
            make.top.equalTo(scrollView.snp.bottom)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(pickerView.snp.top)
        }
        
    }
    
}

struct PickerControllerCache {
    static var scrollViewInsets: UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
}

//
//  SuccessCell.swift
//  PennApps17S
//
//  Created by Arnav Jagasia on 1/20/17.
//  Copyright © 2017 Arnav Jagasia. All rights reserved.
//

import UIKit

class SuccessCell: UICollectionViewCell {
    var delegate: RegisterControllerDelegate?
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}

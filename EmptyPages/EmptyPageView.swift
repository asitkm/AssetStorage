//
//  EmptyPageView.swift
//  AssetStorage
//
//  Created by Asit Kumar Mohanty on 16/02/18.
//  Copyright © 2018 Asit Kumar Mohanty. All rights reserved.
//

import UIKit

class EmptyPageView: UIView
{
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "EmptyPageView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
}

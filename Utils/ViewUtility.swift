//
//  ViewUtility.swift
//  AssetStorage
//
//  Created by Asit Kumar Mohanty on 16/02/18.
//  Copyright © 2018 Asit Kumar Mohanty. All rights reserved.
//

import Foundation
import UIKit

enum EmptyPageType {
    case NoRecordsFound
}

class ViewUtility
{
    class func addEmptyPage(toView view: UIView, forType emptyViewType: EmptyPageType)
    {
        switch emptyViewType {
        case EmptyPageType.NoRecordsFound:
            let emptyPageView = EmptyPageView.instanceFromNib()
            emptyPageView.frame = view.frame
            view.addSubview(emptyPageView)
            addConstraint(fromView: view, toView: emptyPageView, withEdgeInset: UIEdgeInsets.zero)
            break
        }
    }
    
    class func addConstraint(fromView superView: UIView, toView subView: UIView, withEdgeInset edgeInsets: UIEdgeInsets)
    {
        let leftConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: superView, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: edgeInsets.left)
        
        superView.addConstraint(leftConstraint)
        
        let rightConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: superView, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: edgeInsets.right)
        
        superView.addConstraint(rightConstraint)
        
        let topConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: superView, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: edgeInsets.top)
        
        superView.addConstraint(topConstraint)
        
        let bottomConstraint = NSLayoutConstraint(item: subView, attribute: NSLayoutAttribute.left, relatedBy: NSLayoutRelation.equal, toItem: superView, attribute: NSLayoutAttribute.left, multiplier: 1.0, constant: edgeInsets.bottom)
        
        superView.addConstraint(bottomConstraint)
    }
}

//
//  UIView + Ext.swift
//  Image Generator
//
//  Created by Evgeniy Goncharov on 20.05.2023.
//

import UIKit

public extension UIView {

    var leftConstraint:NSLayoutConstraint? {
        return constraintForView(v: self, attribute: .left)
    }

    var rightConstraint:NSLayoutConstraint? {
        return constraintForView(v: self, attribute: .right)
    }

    var topConstraint:NSLayoutConstraint? {
        return constraintForView(v: self, attribute: .top)
    }

    var bottomConstraint:NSLayoutConstraint? {
        return constraintForView(v: self, attribute: .bottom)
    }

    var heightConstraint:NSLayoutConstraint? {
        return constraintForView(v: self, attribute: .height)
    }

    var widthConstraint:NSLayoutConstraint? {
        return constraintForView(v: self, attribute: .width)
    }

}

func constraintForView(v:UIView, attribute:NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
    if let spv = v.superview {
        for c in spv.constraints {
            if let fi = c.firstItem as? NSObject, fi == v && c.firstAttribute == attribute {
                return c
            }
            if let si = c.secondItem as? NSObject, si == v && c.secondAttribute == attribute {
                return c
            }
        }
    }
    return nil
}

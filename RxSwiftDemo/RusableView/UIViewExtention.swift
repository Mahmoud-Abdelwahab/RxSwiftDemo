//
//  UIViewExtention.swift
//  RxSwiftDemo
//
//  Created by Mahmoud Abdul-Wahab on 17/03/2021.
//

import UIKit

extension UIView{
    
   func loadViewFromNib(nibName: String)->UIView?{
       let bundle = Bundle(for: type(of: self))
    let nib = UINib(nibName: nibName, bundle: bundle)
    return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}

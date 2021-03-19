//
//  CustomPopUp.swift
//  RxSwiftDemo
//
//  Created by Mahmoud Abdul-Wahab on 17/03/2021.
//

import UIKit

@IBDesignable
final class CustomPopUp: UIView {
    @IBOutlet weak private var titlelable: UILabel!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    func configureView(){
        guard  let view = loadViewFromNib(nibName: "PopUpView") else {return}
        view.frame = self.bounds
        self.addSubview(view)
        
    }
    
    func setTitle(title: String){
        titlelable.text = title
    }
    
}

//
//  FoodDetailsVC.swift
//  RxSwiftDemo
//
//  Created by Mahmoud Abdul-Wahab on 08/03/2021.
//

import UIKit
import RxSwift
import RxCocoa

class FoodDetailsVC: UIViewController {
    
    @IBOutlet weak var foodImage: UIImageView!
    
    @IBOutlet weak var customView: CustomPopUp!
    @IBOutlet weak var titleTwolable: CustomPopUp!

    //--------------------------------
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var setTitleBtn: UIButton!
    
    var newTitle  = PublishSubject<String>()
    var imageName = BehaviorRelay<String>(value: "")
    let disposeBug = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        
    //    foodImage.image = UIImage(named:imageName)
        // Do any additional setup after loading the view.
       
        customView.setTitle(title: "Hello Mahmoud")
        titleTwolable.setTitle(title: "Zex")
        imageName.map { (name) in
            UIImage.init(named: name)
        }.bind(to: foodImage.rx.image).disposed(by: disposeBug)
        
        //--------------
        setTitleBtn.rx.tap
            .debounce(.milliseconds(3), scheduler: MainScheduler.instance)
            .filter{ !self.titleTF.text!.isEmpty}
            .subscribe(onNext : { [weak self] in
                        self?.newTitle.onNext((self?.titleTF.text!)!)}).disposed(by: disposeBug)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

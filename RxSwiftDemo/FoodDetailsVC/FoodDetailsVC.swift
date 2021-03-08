//
//  FoodDetailsVC.swift
//  RxSwiftDemo
//
//  Created by Mahmoud Abdul-Wahab on 08/03/2021.
//

import UIKit

class FoodDetailsVC: UIViewController {
    @IBOutlet weak var foodImage: UIImageView!
    
    var imageName = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        foodImage.image = UIImage(named:imageName)
        // Do any additional setup after loading the view.
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

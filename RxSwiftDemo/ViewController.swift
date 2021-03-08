//
//  ViewController.swift
//  RxSwiftDemo
//
//  Created by Mahmoud Abdul-Wahab on 08/03/2021.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let tableData = Observable.just([Food(name: "Apple", image: "profile_pic"),Food(name: "Gaqozzy", image: "singer_pic"),Food(name: "Moooz", image: "splash_logo"),Food(name: "Kanary", image: "twitter"),Food(name: "Gaqozzy", image: "singer_pic")])
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        /*
       _ = tableData.bind(to: tableView.rx.items(cellIdentifier: "cell")){
            (tableView,tableData , cell) in
         // the closure takes tableview refereance itself , item data from the array data source , and finally the  cell itself
            cell.textLabel?.text = tableData
       }.disposed(by: disposeBag) // to take care of memory management
 */
        tableData.bind(to: tableView.rx.items(cellIdentifier: "FoodCell",cellType: FoodCell.self)){
            (tableView,modelData,cell) in
            cell.imageView?.image = UIImage.init(named: modelData.image)
            cell.foodNameLable.text = modelData.name
        }.disposed(by: disposeBag)
        
        // did select item at row
        // this get selected model in the selected Cell
        tableView.rx.modelSelected(Food.self).subscribe(onNext: {[weak self] food in
            guard let self = self else{return}
            let foodDetails = self.storyboard?.instantiateViewController(withIdentifier: "FoodDetailsVC") as! FoodDetailsVC
            foodDetails.imageName = food.image
            self.navigationController?.pushViewController(foodDetails, animated: true)
        }, onError: { (error) in
            print(error)
        }).disposed(by: disposeBag)
        
        
        // to get the selected indexpath row number from 0 ->>>>
        
        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            print(indexPath)
        }).disposed(by: disposeBag)
    }


}


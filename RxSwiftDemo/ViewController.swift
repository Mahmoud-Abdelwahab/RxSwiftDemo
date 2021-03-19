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

    @IBOutlet weak var addNewTitleBtn: UIBarButtonItem!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var tableView: UITableView!
    
    let tableData = BehaviorRelay<[Food]>(value: [Food(name: "Apple", image: "profile_pic"),Food(name: "Gaqozzy", image: "singer_pic"),Food(name: "Moooz", image: "splash_logo"),Food(name: "Kanary", image: "twitter"),Food(name: "Gaqozzy", image: "singer_pic"),Food(name: "Kanary", image: "twitter"),Food(name: "Gaqozzy", image: "singer_pic"),Food(name: "Kanary", image: "singer_pic"),Food(name: "mahmoud", image: "singer_pic"),Food(name: "Kanary", image: "Apple"),Food(name: "ali", image: "singer_pic"),Food(name: "Kanary", image: "twitter"),Food(name: "osama", image: "singer_pic"),Food(name: "Kanary", image: "singer_pic"),Food(name: "elwan", image: "singer_pic"),Food(name: "Kanary", image: "twitter"),Food(name: "smida", image: "singer_pic"),Food(name: "Kanary", image: "singer_pic"),Food(name: "haridy", image: "singer_pic"),Food(name: "Kanary", image: "Apple"),Food(name: "aya", image: "singer_pic"),Food(name: "Kanary", image: "twitter"),Food(name: "abdo", image: "Apple")])
    
    
    
    
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        rxLogic()
        
        replaceDelegatWithRX()
        
        handlingOriantationChangedRxWay()
        
        
        flateMapExample()
        
        
        
        
        ///////////////////////////////
        //MARK:- published subject emits all events from the source
//        let pubSub = PublishSubject<String>()
//
//        let observer1 = pubSub.subscribe(onNext: {
//            item in
//            print(item)
//        }).disposed(by: disposeBag)
//
//        pubSub.onNext("Mahmoud")
//        pubSub.onNext("Abdulwahab")
//        pubSub.onNext("AbdulSalam")
//
        
        
        //MARK:- published subject emits all events from the source
 
//        let behaviorSub = BehaviorSubject<String>(value: "Hello")
//
//        let observer2 = behaviorSub.subscribe(onNext: { item in
//            print("****** \(item) ******")
//        })
//
//        behaviorSub.onNext("behavior --->>>>>>>>>>>>>> 1")
//        behaviorSub.onNext("behavior --->>>>>>>>>>>>>> 2")
//        behaviorSub.onNext("behavior --->>>>>>>>>>>>>> 3")
//
//
//        let replaySubject = ReplaySubject<String>.create(bufferSize: 2)
//        let observer3 = replaySubject.subscribe(onNext:{ item in
//            print(item)
//
//        })
//        replaySubject.onNext("A")
//        replaySubject.onNext("B")
//        replaySubject.onNext("C")
//
//        _ = replaySubject.subscribe(onNext:{ item in
//            print(item)
//
//        })
//
//        let pehaviorRlaey = BehaviorRelay<String>(value: "Zex")
//
//        pehaviorRlaey.accept("Kaspersssss")
//
//        _ = pehaviorRlaey.subscribe(onNext: { item in
//            print(item)
//        })
//
        
        
    }


    func  rxLogic(){
        //
        /*
       _ = tableData.bind(to: tableView.rx.items(cellIdentifier: "cell")){
            (tableView,tableData , cell) in
         // the closure takes tableview refereance itself , item data from the array data source , and finally the  cell itself
            cell.textLabel?.text = tableData
       }.disposed(by: disposeBag) // to take care of memory management
 */
        
        searchBar.rx.text.orEmpty.debounce( RxTimeInterval.seconds(1) , scheduler: MainScheduler.instance).distinctUntilChanged()
            .map({ query in
                self.tableData.value.filter({ food in
                    query.isEmpty || food.name.lowercased().contains(query.lowercased())
                    
                    })
            }).bind(to: tableView.rx.items(cellIdentifier: "FoodCell", cellType: FoodCell.self)){
                            (tableView,modelData,cell) in
                            cell.imageView?.image = UIImage.init(named: modelData.image)
                            cell.foodNameLable.text = modelData.name
                        }.disposed(by: disposeBag)
        
         // ******************
//        tableData.bind(to: tableView.rx.items(cellIdentifier: "FoodCell",cellType: FoodCell.self)){
//            (tableView,modelData,cell) in
//            cell.imageView?.image = UIImage.init(named: modelData.image)
//            cell.foodNameLable.text = modelData.name
//        }.disposed(by: disposeBag)
        //***********************
        // did select item at row
        // this get selected model in the selected Cell
        tableView.rx.modelSelected(Food.self).subscribe(onNext: {[weak self] food in
            guard let self = self else{return}
            let foodDetails = self.storyboard?.instantiateViewController(withIdentifier: "FoodDetailsVC") as! FoodDetailsVC
            foodDetails.imageName.accept(food.image)
            self.navigationController?.pushViewController(foodDetails, animated: true)
        }, onError: { (error) in
            print(error)
        }).disposed(by: disposeBag)
        
        
        // to get the selected indexpath row number from 0 ->>>>
        
        tableView.rx.itemSelected.subscribe(onNext: { indexPath in
            print(indexPath)
        }).disposed(by: disposeBag)
    }
    
    
    // i will set the title for this VC from the FoodDetailsVC without delegate
    func replaceDelegatWithRX(){
        addNewTitleBtn.rx.tap
            .debounce(.milliseconds(3), scheduler: MainScheduler.instance)
            .flatMapLatest { [weak self]() -> Observable<String> in
                // i will prsenet foodVC and wait until netTitle publish subject which in it
                // emits onNext event
                // and i will return the foodVC newTile publishsubject observable so i return observable here Observable<String>
                let foodVC = self?.storyboard?.instantiateViewController(withIdentifier: "FoodDetailsVC") as! FoodDetailsVC
                self?.navigationController?.pushViewController(foodVC, animated: true)
                return foodVC.newTitle
            }  .do(onNext: {[weak self] _ in
    
                //.do this as soon as the foodDetailsVC newTitle emite onNext we will dissmiss the VC
                self?.navigationController?.popToRootViewController(animated: true)
            }).subscribe(onNext: { [weak self] newTitle in
                self?.title = newTitle
            }).disposed(by: disposeBag)
    }
    
    
    
    func handlingOriantationChangedRxWay(){
        NotificationCenter.default.rx.notification(UIDevice.orientationDidChangeNotification)
                    .observeOn(MainScheduler.instance)
                    .subscribe(onNext: { data in
                        print("data \(data)")
                    })
                .disposed(by: disposeBag)
    }
    
    func flateMapExample(){
        
        let productList = BehaviorSubject<Product>(value: Product(name: BehaviorSubject(value: "XBox"), price:BehaviorSubject(value:  99.9)))
        
        let productOne =  Product(name: BehaviorSubject(value: "MabBook"), price:BehaviorSubject(value:  1999.9))
        
        let productTwo = Product(name: BehaviorSubject(value: "Iphone"), price:BehaviorSubject(value:  899.9))
        
        productList.onNext(productOne)
        productList.onNext(productTwo)
        
        productTwo.price.onNext(200.0)
    
        productList.flatMap{
            $0.price.asObservable()
        }.subscribe{event in
            switch event{
            case .next( let price):
                print("$$$$$$$" ,price)
            case .error(_):
                print("error")
            case .completed:
                print("completed")
            }
        }.disposed(by: disposeBag)
        
        
    }
}


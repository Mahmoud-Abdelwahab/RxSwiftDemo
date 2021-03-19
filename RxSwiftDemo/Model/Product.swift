//
//  Product.swift
//  RxSwiftDemo
//
//  Created by Mahmoud Abdul-Wahab on 12/03/2021.
//

import Foundation
import RxSwift
import RxCocoa

struct Product {
    var name = BehaviorSubject<String>(value:"No Name")
    var price = BehaviorSubject<Double>(value: 99.9)
}

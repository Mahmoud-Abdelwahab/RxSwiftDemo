//
//  FoodCell.swift
//  RxSwiftDemo
//
//  Created by Mahmoud Abdul-Wahab on 08/03/2021.
//

import UIKit

class FoodCell: UITableViewCell {
    
    @IBOutlet weak var foodImage: UIImageView!
    
    @IBOutlet weak var foodNameLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

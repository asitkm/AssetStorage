//
//  FurnitureTableViewCell.swift
//  AssetStorage
//
//  Created by Asit Kumar Mohanty on 16/02/18.
//  Copyright © 2018 Asit Kumar Mohanty. All rights reserved.
//

import UIKit

class FurnitureTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImgView: UIImageView!
    
    @IBOutlet weak var furnitureNameLbl: UILabel!
    
    @IBOutlet weak var furnitureBrandLbl: UILabel!
    
    @IBOutlet weak var furnitureTypeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(withFurniture furniture:Furniture)
    {
        itemImgView.image = Utility.getImage(forFurnitureImgPath: furniture.furnitureImg)
        furnitureNameLbl.text = furniture.furnitureName
        furnitureBrandLbl.text = "Brand: \(furniture.furnitureBrand)"
        furnitureTypeLbl.text = "Type: \(furniture.furnitureType)"
    }
}

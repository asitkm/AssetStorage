//
//  Furniture.swift
//  AssetStorage
//
//  Created by Asit Kumar Mohanty on 16/02/18.
//  Copyright © 2018 Asit Kumar Mohanty. All rights reserved.
//

import Foundation
enum FurnitureType {
    case bed, sofa, diningTable, chairs, others
}

class Furniture
{
    var _furnitureName: String!
    var _furnitureBrand: String!
    var _furnitureType: FurnitureType!
    
    var furnitureName: String
    {
        if _furnitureName == nil
        {
            _furnitureName = ""
        }
        return _furnitureName
    }
    
    var furnitureBrand: String
    {
        if _furnitureBrand == nil
        {
            _furnitureBrand = "unknown"
        }
        return _furnitureBrand
    }
    
    var furnitureType: FurnitureType
    {
        if _furnitureType == nil
        {
            _furnitureType = FurnitureType.others
        }
        return _furnitureType
    }
}

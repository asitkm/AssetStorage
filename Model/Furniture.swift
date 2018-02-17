//
//  Furniture.swift
//  AssetStorage
//
//  Created by Asit Kumar Mohanty on 16/02/18.
//  Copyright © 2018 Asit Kumar Mohanty. All rights reserved.
//

import Foundation
import UIKit

enum FurnitureType: String {
    case bed = "Bed"
    case sofa = "Sofa"
    case diningTable = "Dining Table"
    case chairs = "Chairs"
    case others = "Others"
}

class Furniture: NSObject, NSCoding
{
    private var _furnitureImg: String!
    private var _furnitureName: String!
    private var _furnitureBrand: String!
    private var _furnitureType: String = FurnitureType.others.rawValue
    
    var furnitureImg: String
    {
        get {
            return _furnitureImg
        }
        
        set {
            _furnitureImg = newValue
        }
    }
    
    var furnitureName: String
    {
        get {
            return _furnitureName
        }
        
        set {
            _furnitureName = newValue
        }
    }
    
    var furnitureBrand: String
    {
        get {
            return _furnitureBrand
        }
        
        set {
            _furnitureBrand = newValue
        }
    }
    
    var furnitureType: String
    {
        get {
            return _furnitureType
        }

        set {
            _furnitureType = newValue
        }
    }
    
    init(furnitureName: String, furnitureBrand: String, furnitureImg: String, furnitureType: String)
    {
        _furnitureName = furnitureName
        _furnitureBrand = furnitureBrand
        _furnitureImg = furnitureImg
        _furnitureType = furnitureType
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let fname = aDecoder.decodeObject(forKey: "furnitureName") as! String
        let fbrand = aDecoder.decodeObject(forKey: "furnitureBrand") as! String
        let fImg = aDecoder.decodeObject(forKey: "furnitureImg") as! String
        let ftype = aDecoder.decodeObject(forKey: "furnitureType") as! String
        
        self.init(furnitureName: fname, furnitureBrand: fbrand, furnitureImg: fImg, furnitureType: ftype)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(furnitureName, forKey: "furnitureName")
        aCoder.encode(furnitureBrand, forKey: "furnitureBrand")
        aCoder.encode(furnitureImg, forKey: "furnitureImg")
        aCoder.encode(furnitureType, forKey: "furnitureType")
    }
    
    class func storeData(forFurniture furniture: Furniture)
    {
        let userDefaults = UserDefaults.standard
        
        if userDefaults.object(forKey: furnitureStoreArrKeyName) != nil
        {
            if let decoded = userDefaults.object(forKey: furnitureStoreArrKeyName) as? Data
            {
                var furnituresArr = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as! [Furniture]
                furnituresArr.append(furniture)
                let archivedData = NSKeyedArchiver.archivedData(withRootObject: furnituresArr)
                userDefaults.set(archivedData, forKey: furnitureStoreArrKeyName)
                userDefaults.synchronize()
            }
        }
        else
        {
            let furnituresArr = [furniture]
            let archivedData = NSKeyedArchiver.archivedData(withRootObject: furnituresArr)
            userDefaults.set(archivedData, forKey: furnitureStoreArrKeyName)
            userDefaults.synchronize()
            
            print("Furniture Data Saved Successfully")
        }
    }
    
    class func getStoredFurnituresData() -> [Furniture]?
    {
        var furnituresArr:[Furniture]? = nil
        let userDefaults = UserDefaults.standard
        
        if userDefaults.object(forKey: furnitureStoreArrKeyName) != nil
        {
            if let decoded = userDefaults.object(forKey: furnitureStoreArrKeyName) as? Data
            {
                furnituresArr = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data) as? [Furniture]
            }
        }
        
        return furnituresArr
    }
}

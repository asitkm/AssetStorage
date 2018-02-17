//
//  Utility.swift
//  AssetStorage
//
//  Created by Asit Kumar Mohanty on 16/02/18.
//  Copyright © 2018 Asit Kumar Mohanty. All rights reserved.
//

import Foundation
import UIKit

class Utility
{
    class func storeAndGetImagePath(forImage image:UIImage, withImageTag imgTag: String) -> String
    {
        // Get shared instance for FileManager
        
        let fileManager = FileManager.default
        
        // Get Home directory URL
        
        let documentsURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        
        let fileNameURL = documentsURL.appendingPathComponent("\(String(imgTag)).png")
        
        if let data = UIImagePNGRepresentation(image) {
            try? data.write(to: fileNameURL, options: .atomic)
        }
        
        return imgTag
    }
    
    class func getImage(forFurnitureImgPath imageName: String) -> UIImage
    {
        let documentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let userDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(documentDirectory, userDomainMask, true)
        if let dirPath = paths.first
        {
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent(imageName)
            if let image    = UIImage(contentsOfFile: imageURL.path)
            {
                return image
            }
        }
        
        return UIImage()
    }
}

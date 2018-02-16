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
        
        let documentPath = documentsURL.path
        
        let fileNameURL = documentsURL.appendingPathComponent("\(String(imgTag)).png")
        
        // Check if the same tag image exists.
        
        do
        {
            let files = try fileManager.contentsOfDirectory(atPath: "\(documentPath)")
            
            for file in files
            {
                if "\(documentPath)/\(file)" == fileNameURL.path
                {
                    try fileManager.removeItem(at: fileNameURL)
                }
            }
        }
        catch
        {
            print("Could not save image data.")
        }
        
        
        if let data = UIImagePNGRepresentation(image) {
            try? data.write(to: fileNameURL)
        }
        
        return fileNameURL.path
    }
}

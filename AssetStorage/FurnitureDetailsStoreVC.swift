//
//  FurnitureDetailsStoreVC.swift
//  AssetStorage
//
//  Created by Asit Kumar Mohanty on 16/02/18.
//  Copyright © 2018 Asit Kumar Mohanty. All rights reserved.
//

import UIKit

class FurnitureDetailsStoreVC: UIViewController, UITextFieldDelegate {

    // Outlets
    
    @IBOutlet weak var containerScrollView: UIScrollView!
    
    @IBOutlet weak var furnitureImgView: UIImageView!
    
    @IBOutlet weak var furnitureNamTF: UITextField!
    
    @IBOutlet weak var furnitureBrandTF: UITextField!
    
    @IBOutlet weak var furnitureTypeTF: UITextField!
    
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var saveBtnTopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var saveBtnBottomConstraint: NSLayoutConstraint!
    
    // Constants and Variables.
    
    var image: UIImage? = nil
    var activeTextField : UITextField?
    var furnitureType: FurnitureType = FurnitureType.others
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViewElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        registerForKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        unRegisterForKeyboardNotification()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func registerForKeyboardNotification() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(FurnitureDetailsStoreVC.keyBoardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(FurnitureDetailsStoreVC.keyBoardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unRegisterForKeyboardNotification() {
        
        NotificationCenter.default.removeObserver(NSNotification.Name.UIKeyboardWillShow)
        NotificationCenter.default.removeObserver(NSNotification.Name.UIKeyboardWillHide)
    }
    
    @IBAction func didTapSaveBtn(_ sender: UIButton)
    {
        if isAllMandatoryFieldsValid().status == true
        {
            let imgfilePath = Utility.storeAndGetImagePath(forImage: image!, withImageTag: (furnitureNamTF.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!)
            
            let fName = (furnitureNamTF.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines))!
            
            let fBrand = (furnitureBrandTF.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)) ?? "Unknown"
            
            let furniture = Furniture(furnitureName: fName, furnitureBrand: fBrand, furnitureImg: imgfilePath, furnitureType: furnitureType.rawValue)
            Furniture.storeData(forFurniture: furniture)
            
            
            navigationController?.popViewController(animated: true)
        }
        else
        {
            // Show error alert for validation failed.
            
            let alert = UIAlertController(title: "OOPS!", message: isAllMandatoryFieldsValid().errorMsg, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { _ in
                
            }))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func didTapCancelBtn(_ sender: UIBarButtonItem)
    {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func keyBoardWillShow(notification:NSNotification)
    {
        if let kbSize = getKeyBoardSizeFromNotification(notification)
        {
            saveBtnTopConstraint.constant = kbSize.height + 2.0
            bringActiveFieldToVisibility()
        }
    }
    
    @objc func keyBoardWillHide(notification:NSNotification)
    {
        saveBtnTopConstraint.constant = 0
    }
    
    // MARK:- TEXTFIELD_DELEGATE
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField == furnitureTypeTF
        {
            textField.resignFirstResponder()
        }
        else
        {
            activeTextField = textField
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        activeTextField = nil
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        if textField == furnitureTypeTF {
            view.endEditing(true)
            showFurnitureTypeActionSheet()
        }
        
        return true
    }
    
    // MARK:- CUSTOM_METHODS
    
    func setupViewElements()
    {
        if image != nil
        {
            furnitureImgView.image = image
        }
        
        furnitureType = FurnitureType.others
        furnitureTypeTF.text = FurnitureType.others.rawValue
    }
    
    func isAllMandatoryFieldsValid() -> (status: Bool, errorMsg: String)
    {
        let furnitureNameStr = furnitureNamTF.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        if furnitureNameStr == ""
        {
            return (false, "Furniture name field cannot be empty.")
        }
        
        let fnameRegex = "[A-Z0-9a-z ]*"
        
        let fnamePredicate = NSPredicate(format: "SELF MATCHES %@", fnameRegex) as NSPredicate
        
        if fnamePredicate.evaluate(with: furnitureNameStr) == false
        {
            return (false, "Invalid data for name field.")
        }
        
        return (true, "")
    }
    
    func getKeyBoardSizeFromNotification(_ notification:NSNotification) -> CGSize? {
        
        var kbSize : CGSize?
        
        if let info:Dictionary<AnyHashable,Any> = notification.userInfo {
            
            if let kbRectValue = info[UIKeyboardFrameEndUserInfoKey] as? NSValue {
                
                let kbRect = kbRectValue.cgRectValue
                kbSize = kbRect.size
            }
        }
        return kbSize
    }
    
    func bringActiveFieldToVisibility()
    {
        var scrollRect : CGRect?
        
        if activeTextField != nil
        {
            scrollRect = activeTextField?.frame
        }
        
        if scrollRect != nil
        {
            var scrollSize = scrollRect?.size
            let tmpHeight = (scrollSize?.height)! + 2.0
            scrollSize?.height = tmpHeight
            scrollRect?.size = scrollSize ?? CGSize(width: 0.0, height: 0.0)
            containerScrollView.scrollRectToVisible(scrollRect!, animated: true)
        }
    }
    
    func showFurnitureTypeActionSheet()
    {
        let actionSheet = UIAlertController(title: "Select current Furniture type.", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Bed", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.furnitureTypeTF.text = FurnitureType.bed.rawValue
            self.furnitureType = FurnitureType.bed
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Sofa", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.furnitureTypeTF.text = FurnitureType.sofa.rawValue
            self.furnitureType = FurnitureType.sofa
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Dining Table", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.furnitureTypeTF.text = FurnitureType.table.rawValue
            self.furnitureType = FurnitureType.table
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Chairs", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.furnitureTypeTF.text = FurnitureType.chairs.rawValue
            self.furnitureType = FurnitureType.chairs
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Others", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.furnitureTypeTF.text = FurnitureType.others.rawValue
            self.furnitureType = FurnitureType.others
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(actionSheet, animated: true, completion: nil)
    }
}

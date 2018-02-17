//
//  ViewController.swift
//  AssetStorage
//
//  Created by Asit Kumar Mohanty on 16/02/18.
//  Copyright © 2018 Asit Kumar Mohanty. All rights reserved.
//

import UIKit

// Constants and Properties.

fileprivate var currentVC: UIViewController!

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource
{

    // Outlets
    
    @IBOutlet weak var furnitureListTableView: UITableView!
    
    // Constants and Variables.
    
    var furnituresArr: [Furniture]? = nil
    var isInitialSetupDone: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupViewElements()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didTapAddFurnitureBtn(_ sender: UIBarButtonItem)
    {
        showActionSheet(vc: self)
    }
    
    func showActionSheet(vc: UIViewController) {
        currentVC = vc
        let actionSheet = UIAlertController(title: "Select how you want to add the Item", message: nil, preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.openCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { (alert:UIAlertAction!) -> Void in
            self.openGallery()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        vc.present(actionSheet, animated: true, completion: nil)
    }
    
    private func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .camera
            currentVC.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    private func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            let myPickerController = UIImagePickerController()
            myPickerController.delegate = self;
            myPickerController.sourceType = .photoLibrary
            currentVC.present(myPickerController, animated: true, completion: nil)
        }
    }
    
    private func setupViewElements()
    {
        // This is to setup table view and other ui initialization if any.
        
        if isInitialSetupDone == false
        {
            isInitialSetupDone = true
            
            furnitureListTableView.register(UINib(nibName: "FurnitureTableViewCell", bundle: nil), forCellReuseIdentifier: "FurnitureTableViewCellIdentifier")
            
            furnitureListTableView.rowHeight = UITableViewAutomaticDimension
            furnitureListTableView.estimatedRowHeight = 150
            furnitureListTableView.tableFooterView = UIView(frame: CGRect.zero)
        }
        
        
        // Fetching data for stored furnitures.
        
        furnituresArr = Furniture.getStoredFurnituresData()
        
        ViewUtility.removeEmptyPage(fromView: view)
        
        if furnituresArr?.count != nil
        {
            furnitureListTableView.isHidden = false
            furnitureListTableView.reloadData()
        }
        else
        {
            furnitureListTableView.isHidden = true
            ViewUtility.addEmptyPage(toView: view, forType: EmptyPageType.NoRecordsFound)
        }
    }
    
    // MARK:- CAMERA_DELEGATES
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        currentVC.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        currentVC.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            if let furnitureDtlsNavController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "furnitureDtlsStoreVC") as? FurnitureDetailsStoreVC
            {
                furnitureDtlsNavController.image = image
            navigationController?.pushViewController(furnitureDtlsNavController, animated: true)
            }
        }
        
    }
    
    // MARK:- TABLEVIEW_DATASOURCE_DELEGATES
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if furnituresArr != nil
        {
            return (furnituresArr?.count)!
        }
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "FurnitureTableViewCellIdentifier", for: indexPath) as? FurnitureTableViewCell
        {
            cell.configureCell(withFurniture: furnituresArr![indexPath.row])
            return cell
        }
        
        return UITableViewCell()
    }
}


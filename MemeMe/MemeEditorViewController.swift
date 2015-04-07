//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Abhijit Mazumdar on 4/1/15.
//  Copyright (c) 2015 Abhijit Mazumdar. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var imagePickerView: UIImageView!
    
    // Click Album button to pick image
    @IBAction func pickAnImage(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    //Did Finish Picking
    func imagePickerController(pickerController: UIImagePickerController,
        didFinishPickingMediaWithInfo info: NSDictionary!){
            
            if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
                self.imagePickerView.image = image
                
            }
            
            self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Did Cancel
    func imagePickerControllerDidCancel(pickerController: UIImagePickerController){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    

}
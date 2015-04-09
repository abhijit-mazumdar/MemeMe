//
//  MemeEditorViewController.swift
//  MemeMe
//
//  Created by Abhijit Mazumdar on 4/1/15.
//  Copyright (c) 2015 Abhijit Mazumdar. All rights reserved.
//

import UIKit
import Foundation

class MemeEditorViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var bottomTextField: UITextField!
    
    // Setting the textfield's stroke and fill
    override func viewDidLoad() {
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.blackColor(),
            NSForegroundColorAttributeName : UIColor.whiteColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : -2.0
        ]
        
        topTextField.text = "TOP"
        topTextField.textAlignment = .Center
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.delegate = self
        
        bottomTextField.text = "BOTTOM"
        bottomTextField.textAlignment = .Center
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
    }
    
    // Click Album button to pick image
    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    // Click Camera button to pick image
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.allowsEditing=true
        pickerController.sourceType = UIImagePickerControllerSourceType.Camera
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
    
    // Clear default text before editing textfield
    func textFieldDidBeginEditing(textField: UITextField) {
        topTextField.clearsOnBeginEditing = true
        bottomTextField.clearsOnBeginEditing = true
    }
    
    // Dismiss keyboard after edit text and return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        topTextField.resignFirstResponder()
        bottomTextField.resignFirstResponder()
        return true
    }
    
    

}
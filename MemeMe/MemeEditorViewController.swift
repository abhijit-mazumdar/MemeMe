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
    
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var topTextField: UITextField!
    
    @IBOutlet weak var bottomTextField: UITextField!
    
    // Setting the textfield's stroke and fill
    override func viewDidLoad() {
        super.viewDidLoad()
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
        super.viewWillAppear(animated)
        // Disable buttons based on source type available
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        if (self.imagePickerView.image == nil){
            shareButton.enabled = false
        }
        self.subscribeToKeyboardNotifications()
        self.navigationController?.setToolbarHidden(true, animated: true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
        self.navigationController?.setToolbarHidden(false, animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
   
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    //Shift view frame up when keyboard appears
    func keyboardWillShow(notification: NSNotification) {
        //self.view.frame.origin.y -= getKeyboardHeight(notification)
        self.view.frame.origin.y = -getKeyboardHeight(notification)
    }
    
    //Shift view frame down when keyboard disappears
    func keyboardWillHide(notification: NSNotification) {
        //self.view.frame.origin.y += getKeyboardHeight(notification)
        self.view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    // Click Album button to pick image
    @IBAction func pickAnImageFromAlbum(sender: AnyObject) {
        shareButton.enabled = true
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(pickerController, animated: true, completion: nil)
    }
    
    // Click Camera button to pick image
    @IBAction func pickAnImageFromCamera(sender: AnyObject) {
        shareButton.enabled = true
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
    
    // Click the share button
    @IBAction func shareMeme(sender: AnyObject) {
        let memedImage = generateMemedImage()
        let activityVC = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        self.presentViewController(activityVC, animated: true, completion: nil)
        
        activityVC.completionWithItemsHandler = {
            (s: String!, ok: Bool, items: [AnyObject]!, err:NSError!) -> Void in
            self.save()
            self.dismissViewControllerAnimated(true, completion: nil)
            
            self.performSegueWithIdentifier("sentMemesSegue", sender: self)
        }
        
    }
    
    
    @IBAction func cancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Initialize the meme model object
    func save(){
        var meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, originalImage: imagePickerView.image!, memedImage: generateMemedImage())
        
        // Add it to the memes array in the Application Delegate
        (UIApplication.sharedApplication().delegate as
            AppDelegate).memes.append(meme)
    }
    
    // Render view to an image
    func generateMemedImage() -> UIImage
    {
        // Hide tool and nav bar
        self.navigationController?.setToolbarHidden(true, animated: true)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // Show tool and nav bar
        self.navigationController?.setToolbarHidden(false, animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        return memedImage
    }
    

}
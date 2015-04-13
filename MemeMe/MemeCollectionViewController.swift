//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Abhijit Mazumdar on 4/12/15.
//  Copyright (c) 2015 Abhijit Mazumdar. All rights reserved.
//

import UIKit

class MemeCollectionViewController : UICollectionViewController{
    var memes: [Meme]!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as AppDelegate
        memes = appDelegate.memes
    }
}

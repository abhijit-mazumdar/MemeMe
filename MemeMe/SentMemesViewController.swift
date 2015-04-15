//
//  SentMemesViewController.swift
//  MemeMe
//
//  Created by Abhijit Mazumdar on 4/13/15.
//  Copyright (c) 2015 Abhijit Mazumdar. All rights reserved.
//

import UIKit

class SentMemesViewController : UITabBarController,UITabBarControllerDelegate {
    var memes: [Meme]!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
}


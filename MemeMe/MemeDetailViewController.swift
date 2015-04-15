//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Abhijit Mazumdar on 4/13/15.
//  Copyright (c) 2015 Abhijit Mazumdar. All rights reserved.
//

import UIKit

class MemeDetailViewController : UIViewController {
    
    @IBOutlet weak var memedImageView: UIImageView!
    
    var meme: Meme!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.memedImageView!.image = meme.memedImage
    }
    
}
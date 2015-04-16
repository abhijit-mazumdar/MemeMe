//
//  Meme.swift
//  MemeMe
//
//  Created by Abhijit Mazumdar on 4/9/15.
//  Copyright (c) 2015 Abhijit Mazumdar. All rights reserved.
//

import Foundation
import UIKit

//Meme model
class Meme: NSObject {
    
    var topText: NSString!
    var bottomText: NSString!
    var originalImage: UIImage!
    var memedImage: UIImage!
    var fullText: NSString{
        get{
            return self.topText + " " + self.bottomText
        }
    }
    
    init(topText: NSString, bottomText: NSString, originalImage: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
    
}
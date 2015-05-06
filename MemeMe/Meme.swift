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
    
    var topText: String
    var bottomText: String
    var originalImage: UIImage!
    var memedImage: UIImage!
    var fullText: String{
        get{
            return self.topText + self.bottomText
        }
    }
    
    init(topText: String, bottomText: String, originalImage: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.originalImage = originalImage
        self.memedImage = memedImage
    }
    
}
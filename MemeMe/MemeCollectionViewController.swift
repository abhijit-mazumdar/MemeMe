//
//  MemeCollectionViewController.swift
//  MemeMe
//
//  Created by Abhijit Mazumdar on 4/12/15.
//  Copyright (c) 2015 Abhijit Mazumdar. All rights reserved.
//

import UIKit

class MemeCollectionViewController : UICollectionViewController,UICollectionViewDataSource {
    var memes: [Meme]!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as AppDelegate
        memes = appDelegate.memes
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CustomMemeCell", forIndexPath: indexPath) as CustomMemeCell
        let meme = memes[indexPath.item]
        cell.CustomCellImageView.image = meme.memedImage
        return cell
        
    }
    
    override func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let memeDetailController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as MemeDetailViewController
        memeDetailController.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(memeDetailController, animated: true)
    }

}

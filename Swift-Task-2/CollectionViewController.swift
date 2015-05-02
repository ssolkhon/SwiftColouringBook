//
//  CollectionViewController.swift
//  Swift-Task-3
//
//  Created by Scott Solkhon on 14/04/2015.
//  Copyright (c) 2015 Scott Solkhon. All rights reserved.
//

import UIKit
import CoreData

let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController, UICollectionViewDataSource , UICollectionViewDelegate {
    
    @IBOutlet var myCollectionView: UICollectionView!
    
    // create images array with default images
    var imgs: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.contentInset = UIEdgeInsets(top: 25, left: 10, bottom: 10, right: 10)
        // load images into the image array
        getCustomImages()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadImages:",name:"imageSaved", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        //#warning Incomplete method implementation -- Return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //#warning Incomplete method implementation -- Return the number of items in the section
        return imgs.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as CollectionViewCell
    
        // Configure the cell
        cell.imageView.image = imgs[indexPath.row]
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // when a user selects an image they will be taken to the image editor
        if segue.identifier == "imageEditor" {
            let viewController = segue.destinationViewController as ViewController
            let index = self.collectionView?.indexPathForCell(sender as CollectionViewCell)
            
            if let i = index?.row {
                viewController.selectedImg = imgs[i]
                //println(imgs[i])
            }
        }
    }
    
    func reloadImages(notification: NSNotification){
        getCustomImages()
        self.myCollectionView.reloadData()
    }
    
    func getCustomImages() {
        // clear any images already stored in the array
        self.imgs = []
        // add the default images
        self.imgs.append(UIImage(named: "flower")!)
        self.imgs.append(UIImage(named: "pony")!)
        self.imgs.append(UIImage(named: "hello-kitty")!)
        // add the custom images from the DB
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        // Make the request to the DB
        var request = NSFetchRequest(entityName: "SavedImages")
        request.returnsObjectsAsFaults = false
        // Process the results
        var results = context.executeFetchRequest(request, error: nil)
        var res = NSMutableArray(array: results!)
        // Print them on the console
        if res.count > 0 {
            for r in res {
                //println(r.valueForKey("image"))
                let decodedimage = UIImage(data: r.valueForKey("image")! as NSData)
                self.imgs.append(decodedimage!)
            }
        } else {
            println("No custom images found: possible error!")
        }
    }

}

//
//  SavedImage.swift
//  Swift-Task-3
//
//  Created by Scott Solkhon on 25/04/2015.
//  Copyright (c) 2015 Scott Solkhon. All rights reserved.
//

import UIKit
import CoreData
import Foundation

@objc(SavedImage)
class SavedImage: NSManagedObject {
    
     @NSManaged var image: NSData
    
    
    class func createInObjectContext(moc : NSManagedObjectContext , image : NSData){
        
        let newItem = NSEntityDescription.insertNewObjectForEntityForName("SavedImages", inManagedObjectContext: moc) as SavedImage
        
        newItem.image = image
    }
   
}

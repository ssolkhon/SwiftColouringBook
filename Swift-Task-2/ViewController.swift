//
//  ViewController.swift
//  Swift-Task-2
//
//  Created by Scott Solkhon on 13/04/2015.
//  Copyright (c) 2015 Scott Solkhon. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    
    @IBOutlet weak var lineWidth: UISlider!
    @IBOutlet var drawClass: DrawClass!
    @IBOutlet weak var lineWidthLabel: UILabel!
    // line colour labels
    @IBOutlet weak var lineRedLabel: UILabel!
    @IBOutlet weak var lineBlueLabel: UILabel!
    @IBOutlet weak var lineGreenLabel: UILabel!
    // line colour sliders
    @IBOutlet weak var lineRedSlider: UISlider!
    @IBOutlet weak var lineBlueSlider: UISlider!
    @IBOutlet weak var lineGreenSlider: UISlider!
    // line colour view
    @IBOutlet weak var lineColour: UIView!
    // image for background
    var selectedImg : UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if let backgroundImage = selectedImg {
            // resize the image
            let sizeOfView = CGSizeMake(360, 390)
            var backgroundImg = imageResize(image: selectedImg!,sizeChange: sizeOfView)
            // place selected image onto the background
            drawClass.backgroundColor = UIColor(patternImage: backgroundImg)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveView(sender: UIBarButtonItem) {
        // create the image to save
        var image = makeImage()
        let data = UIImagePNGRepresentation(image)
        
        // save image to DB
        // Set up the application delegate and context
        var appDel:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        var context:NSManagedObjectContext = appDel.managedObjectContext!
        // add a new user
        var newImage = NSEntityDescription.insertNewObjectForEntityForName("SavedImages", inManagedObjectContext: context) as NSManagedObject
        // set the values
        newImage.setValue(data, forKey: "image")
        // save the record to the DB
        context.save(nil)
        //println(newImage)
        //println("Object saved")
        
        // tell collection view to reload images
        NSNotificationCenter.defaultCenter().postNotificationName("imageSaved", object: nil)
        // return to collection view
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func clearChoice(){
        var myCanvas = drawClass
        myCanvas.lines = []
        myCanvas.setNeedsDisplay()
    }

    @IBAction func lineWidthSlider(sender: UISlider) {
        var curValue = Int(sender.value)
        lineWidthLabel.text = "\(curValue)"
        drawClass.lineWidth = CGFloat(curValue)
    }
    
    
    @IBAction func lineRedSlider(sender: UISlider) {
        var curValue = Int(sender.value)
        lineRedLabel.text = "\(curValue)"
        drawClass.lineRed = CGFloat(curValue)
        lineColour.backgroundColor = UIColor(red: CGFloat(lineRedSlider.value/255), green: CGFloat(lineGreenSlider.value/255), blue: CGFloat(lineBlueSlider.value/255), alpha: 1)
    }
    
    
    @IBAction func lineBlueSlider(sender: UISlider) {
        var curValue = Int(sender.value)
        lineBlueLabel.text = "\(curValue)"
        drawClass.lineBlue = CGFloat(curValue)
        lineColour.backgroundColor = UIColor(red: CGFloat(lineRedSlider.value/255), green: CGFloat(lineGreenSlider.value/255), blue: CGFloat(lineBlueSlider.value/255), alpha: 1)
    }
    
    
    @IBAction func lineGreenSlider(sender: UISlider) {
        var curValue = Int(sender.value)
        lineGreenLabel.text = "\(curValue)"
        drawClass.lineGreen = CGFloat(curValue)
        lineColour.backgroundColor = UIColor(red: CGFloat(lineRedSlider.value/255), green: CGFloat(lineGreenSlider.value/255), blue: CGFloat(lineBlueSlider.value/255), alpha: 1)
    }
    
    
    @IBAction func backPressed(sender: UIBarButtonItem) {
        // return to collection view
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func makeImage()->UIImage {
        UIGraphicsBeginImageContextWithOptions(drawClass.bounds.size, drawClass.opaque, 0)
        drawClass.layer.renderInContext(UIGraphicsGetCurrentContext())
        var img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext()
        return img
    }
    
    func imageResize (#image:UIImage, sizeChange:CGSize)-> UIImage{
        let hasAlpha = true
        let scale: CGFloat = 0.0 // Use scale factor of main screen
        
        UIGraphicsBeginImageContextWithOptions(sizeChange, !hasAlpha, scale)
        image.drawInRect(CGRect(origin: CGPointZero, size: sizeChange))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        return scaledImage
    }


}


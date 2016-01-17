//
//  ViewController.swift
//  Filterer
//
//  Created by Jack on 2015-09-22.
//  Copyright © 2015 UofT. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var filteredImage: UIImage?
    
    @IBOutlet var imageView: UIImageView!
    
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet var bottomMenu: UIView!
    @IBOutlet var sliderView: UIView!
    @IBOutlet var slider: UISlider!
    
    @IBOutlet var filterButton: UIButton!
    @IBOutlet var btnCompare: UIButton!
    @IBOutlet var labelTextoOriginal: UILabel!
    @IBOutlet var editButton: UIButton!
    
    var imageOriginal: UIImage!
    var imageFiltered: UIImage?
    var tapCompare: Bool = false
    var tapFiltered: Bool = false
    let imageFilter : imageFilters! = imageFilters()
    
    enum Filters {
        case None
        case Red
        case Blue
        case Green
    }
    var actualFilter : Filters!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false

        sliderView.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        sliderView.translatesAutoresizingMaskIntoConstraints = false
        
        btnCompare.enabled = false
        editButton.enabled = false
        actualFilter = Filters.None
        imageOriginal = UIImage(named:"scenery")!

        
        //Habilitar touch en UIImageView
        let tapLongGestureRecognizer = UILongPressGestureRecognizer(target: self, action:Selector("imagenPresionada:"))
        imageView.userInteractionEnabled = true
        imageView.addGestureRecognizer(tapLongGestureRecognizer)

        labelTextoOriginal.hidden = true
    }

    // MARK: Share
    @IBAction func onShare(sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: ["Check out our really cool app", imageView.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    // MARK: New Photo
    @IBAction func onNewPhoto(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { action in
            self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: { action in
            self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
    }
    
    func showCamera() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .PhotoLibrary
        
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    // MARK: UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            imageOriginal = imageView.image
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: Filter Menu
    @IBAction func onFilter(sender: UIButton) {
        if (sender.selected) {
            hideSecondaryMenu()
            sender.selected = false
        } else {
            editButton.selected = false
            hideSliderView()
            showSecondaryMenu()
            sender.selected = true
        }
    }
    
    @IBAction func onEdit(sender: UIButton) {
        if (sender.selected) {
            hideSliderView()
            sender.selected = false
        } else {
            filterButton.selected = false
            hideSecondaryMenu()
            showSliderView()
            sender.selected = true
        }
    }
    
    
    
    
    func showSecondaryMenu() {
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.secondaryMenu.alpha = 1.0
        }
    }

    func hideSecondaryMenu() {
        UIView.animateWithDuration(0.4, animations: {
            self.secondaryMenu.alpha = 0
            }) { completed in
                if completed == true {
                    self.secondaryMenu.removeFromSuperview()
                }
        }
    }
    
    
    func showSliderView() {
        view.addSubview(sliderView)
        
        let bottomConstraint = sliderView.bottomAnchor.constraintEqualToAnchor(bottomMenu.topAnchor)
        let leftConstraint = sliderView.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = sliderView.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let heightConstraint = sliderView.heightAnchor.constraintEqualToConstant(74)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.sliderView.alpha = 0
        UIView.animateWithDuration(0.4) {
            self.sliderView.alpha = 1.0
        }
    }
    
    func hideSliderView() {
        UIView.animateWithDuration(0.4, animations: {
            self.sliderView.alpha = 0
            }) { completed in
                if completed == true {
                    self.sliderView.removeFromSuperview()
                }
        }
    }
    
    
    @IBAction func sliderMove(sender: AnyObject) {
        if (actualFilter != Filters.None){
        
        let currentValue = slider.value
        switch actualFilter! {
        case Filters.Blue:
            imageFiltered = imageFilter!.filterBlue(imageOriginal!, blue: currentValue)
            self.imageView.image = self.imageFiltered
        case Filters.Green:
            imageFiltered = imageFilter!.filterGreen(imageOriginal!, green: currentValue)
            self.imageView.image = self.imageFiltered
        case Filters.Red:
            imageFiltered = imageFilter!.filterRed(imageOriginal!, red: currentValue)
            self.imageView.image = self.imageFiltered
        default:
            print("No Filter", terminator: "")
        }
        }
    }
    
    
    
 
    
    @IBAction func onFilterRed(sender: UIButton) {
        imageFiltered =  imageFilter.filterRed(imageOriginal!, red: slider.value)
        btnCompare.enabled = true
        editButton.enabled = true
        UIView.animateWithDuration(1, animations: { self.imageView.alpha=0 })
            { completed in if(completed == true) {
                self.imageView.image = self.imageFiltered
                //self.imageView.alpha=1
                UIView.animateWithDuration(1, animations: {self.imageView.alpha=1})
                }}
         actualFilter = Filters.Red
    }
    
    @IBAction func onFilterGreen(sender: UIButton) {
        imageFiltered = imageFilter.filterGreen(imageOriginal!, green: slider.value)
        btnCompare.enabled = true
        editButton.enabled = true
        UIView.animateWithDuration(1, animations: { self.imageView.alpha=0 })
            { completed in if(completed == true) {
                self.imageView.image = self.imageFiltered
                UIView.animateWithDuration(1, animations: {self.imageView.alpha=1})
                }}
         actualFilter = Filters.Green
    }
    
    @IBAction func onFilterBlue(sender: UIButton) {
        imageFiltered = imageFilter.filterBlue(imageOriginal!, blue: slider.value)
        btnCompare.enabled = true
        editButton.enabled = true
        UIView.animateWithDuration(1, animations: { self.imageView.alpha=0})
            { completed in if(completed == true) {
                self.imageView.image = self.imageFiltered
                UIView.animateWithDuration(1, animations: {self.imageView.alpha=1})
                }}
        actualFilter = Filters.Blue
    }
    
    
    @IBAction func btnCompare(sender: UIButton) {
            if tapCompare{
                imageView.image = imageFiltered
                tapCompare = false
                labelTextoOriginal.hidden = true
            }else{
                imageView.image = imageOriginal
                tapCompare = true
                labelTextoOriginal.hidden = false
            }
    }
    

    func imagenPresionada(sender: UILongPressGestureRecognizer){
        if (imageFiltered != nil){
            if(sender.state == UIGestureRecognizerState.Began){
                imageView.animationDuration=1
                imageView.animationImages=[imageOriginal!,imageFiltered!]
                imageView.startAnimating()
            }
            if(sender.state == UIGestureRecognizerState.Ended){
                if(imageView.isAnimating()){
                    imageView.stopAnimating()
                }
                imageView.image = imageFiltered
            }
        }
    }

}


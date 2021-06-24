//
//  UploadViewController.swift
//  uploadReportsMenu
//
//  Created by Vishal on 20/08/18.
//  Copyright © 2018 emproto. All rights reserved.
//

import Foundation
import UIKit

class FoodSelectionViewController: UIViewController {
    
    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var chickenButton: UIButton!
    @IBOutlet weak var bannanaButton: UIButton!
    @IBOutlet weak var wineButton: UIButton!
    
    var chickenButtonCenter: CGPoint!
    var bannanaButtonCenter: CGPoint!
    var wineButtonCenter: CGPoint!
    private var offset :CGFloat = 80
    var isSelected = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let image = #imageLiteral(resourceName: "tap").withRenderingMode(.alwaysTemplate)
        uploadButton.setImage(image, for: .normal)
        uploadButton.tintColor = .white
        bannanaButton.center = CGPoint(x: uploadButton.center.x - offset, y: uploadButton.center.y)
        wineButton.center = CGPoint(x: uploadButton.center.x + offset, y: uploadButton.center.y)
        chickenButton.center = CGPoint(x: uploadButton.center.x, y: uploadButton.center.y + offset)
        
        chickenButtonCenter = chickenButton.center
        bannanaButtonCenter = bannanaButton.center
        wineButtonCenter = wineButton.center
        chickenButton.center = uploadButton.center
        bannanaButton.center = uploadButton.center
        wineButton.center = uploadButton.center
        
        self.chickenButton.isHidden = true
        self.bannanaButton.isHidden = true
        self.wineButton.isHidden = true
    }
    
    @IBAction func uploadButtonTapped(_ sender: Any) {
        if(isSelected){
            let image = #imageLiteral(resourceName: "add-button").withRenderingMode(.alwaysTemplate)
            uploadButton.setImage(image, for: .normal)
            uploadButton.tintColor = .white
            self.transform(buttons: [self.chickenButton, self.bannanaButton, self.wineButton], x: 0.1, y: 0.1, alpha: nil)
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
                self.chickenButton.isHidden = false
                self.self.bannanaButton.isHidden = false
                self.wineButton.isHidden = false
                self.uploadButton.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/4))
                self.chickenButton.center = self.chickenButtonCenter
                self.wineButton.center = self.wineButtonCenter
                self.bannanaButton.center = self.bannanaButtonCenter
                self.transform(buttons: [self.chickenButton, self.bannanaButton, self.wineButton], x: 1, y: 1, alpha:1.0)
                self.rotateAnimation(buttons: [self.chickenButton, self.bannanaButton, self.wineButton], isCounter: false)
            }, completion: { finished in
                self.isSelected = false
            })
        }else {
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
                self.chickenButton.center = self.uploadButton.center
                self.bannanaButton.center = self.uploadButton.center
                self.wineButton.center = self.uploadButton.center
                self.rotateAnimation(buttons: [self.chickenButton, self.bannanaButton, self.wineButton], isCounter: true)
                self.transform(buttons: [self.chickenButton, self.bannanaButton, self.wineButton], x: 0.1, y: 0.1,alpha:0.0)
                self.uploadButton.setImage(#imageLiteral(resourceName: "tap"), for: .normal)
                self.uploadButton.transform = CGAffineTransform.identity
            }) {[weak self] (completed) in
                self?.isSelected = true
            }
        }
    }
    
    func transform(buttons: [UIButton], x: CGFloat, y: CGFloat, alpha:CGFloat?){
        for button in buttons {
            button.transform = CGAffineTransform(scaleX: x, y: y)
            if let alpha = alpha {
                button.alpha = alpha
            }
        }
    }
    
    func rotateAnimation(buttons: [UIButton], duration: CFTimeInterval = 0.25, isCounter:Bool) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        if isCounter {
            rotateAnimation.toValue = CGFloat(-.pi * 2.0)
        }else{
            rotateAnimation.toValue = CGFloat(.pi * 2.0)
        }
        rotateAnimation.duration = duration
        rotateAnimation.repeatCount = 2;
        for button in buttons {
            button.layer.add(rotateAnimation, forKey: nil)
        }
    }
    @IBAction func didTapBannanaButton() {
        print("Selected Bannana !!")
    }
    @IBAction func didTapChikkenButton() {
        print("Selected Chikken !!")

    }
    @IBAction func didTapWineButton() {
        print("Selected Wine !!")
    }
    func open(){ // not used but if required can be used
        isSelected = true
        uploadButtonTapped(uploadButton)
    }
    
    func close(){  // not used but if required can be used
        isSelected = false
        uploadButtonTapped(uploadButton)
    }

}



//
//  CanvasViewController.swift
//  Canvas
//
//  Created by Kyle Sit on 8/15/17.
//  Copyright © 2017 Kyle Sit. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    
    //outlets
    @IBOutlet weak var trayView: UIView!

    //instance vars for tray panning
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    //instance vars for face panning
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    
    //viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        //setting initial tray positions
        trayDownOffset = 200
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x ,y: trayView.center.y + trayDownOffset)
    }

    
    //Memory warning
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //action outlet for gesture recognizer on the tray view
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        //translation and velocity parameter
        let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        
        //conditional for states of the view
        if sender.state == .began {
            //if it is first touched, set original center to its current state
            trayOriginalCenter = trayView.center
        }
        else if sender.state == .changed {
            //if the tray is being moved, constantly set its center
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        }
        else if sender.state == .ended {
            //positive velocity indicates moving down
            if velocity.y > 0 {
                //spring animation for tray
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.trayView.center = self.trayDown
                }, completion: nil)
            }
            //else it is moving up
            else {
                //spring animation for tray
                UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                               animations: { () -> Void in
                                self.trayView.center = self.trayUp
                }, completion: nil)
            }
        }
    }
    
    
    //action outlet for any of the gesture recognizers on the faces
    @IBAction func didPanFace(_ sender: UIPanGestureRecognizer) {
        //translation parameter
        let translation = sender.translation(in: view)
        
        //conditional for states of sender
        if sender.state == .began {
            //store senders image and place it on the main view (have to offset coordinates)
            let imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            
            //set original center
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            //spring and scale the face
            UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                           animations: { () -> Void in
                            self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }, completion: nil)
        }
        else if sender.state == .changed {
            //continually set new center as it is being moved
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        }
        else if sender.state == .ended {
            //manually create pan gesture recognizer for the new face
            let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(didPanFaceOnCanvas(_:)))
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
            newlyCreatedFace.isUserInteractionEnabled = true
            
            //spring and scale back to normal the face for drop effect
            UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                           animations: { () -> Void in
                            self.newlyCreatedFace.transform = self.newlyCreatedFace.transform.scaledBy(x: 0.5, y: 0.5)
            }, completion: nil)
        }
    }
    
    
    //action function for the new faces on the canvas
    @IBAction func didPanFaceOnCanvas(_ sender: UIPanGestureRecognizer) {
        //translation parameter
        let translation = sender.translation(in: view)
        
        //conditional for states of the view
        if sender.state == .began {
            //reset instance var to be used on current face
            newlyCreatedFace = sender.view as! UIImageView
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            //spring and scale the face
            UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                           animations: { () -> Void in
                            self.newlyCreatedFace.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
            }, completion: nil)
        }
        else if sender.state == .changed {
            //continually set new center as it is being moved
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        }
        else if sender.state == .ended {
            //spring and scale back to normal the face for drop effect
            UIView.animate(withDuration:0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options:[] ,
                           animations: { () -> Void in
                            self.newlyCreatedFace.transform = self.newlyCreatedFace.transform.scaledBy(x: 0.5, y: 0.5)
            }, completion: nil)
        }
    }
    
    
    //action function for scaling the new faces on the canvas
    @IBAction func didPinch(_ sender: UIPinchGestureRecognizer) {
    }
    
    
    //action function for rotating the new faces on the canvas
    @IBAction func didRotate(_ sender: UIRotationGestureRecognizer) {
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

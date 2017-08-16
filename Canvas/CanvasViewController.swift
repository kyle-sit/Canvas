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

    //instance vars
    var trayOriginalCenter: CGPoint!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    
    
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
        
        if sender.state == .began {
            trayOriginalCenter = trayView.center
        } else if sender.state == .changed {
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        } else if sender.state == .ended {
            if velocity.y > 0 {
                trayView.center = trayDown
            }
            else {
                trayView.center = trayUp
            }
        }
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

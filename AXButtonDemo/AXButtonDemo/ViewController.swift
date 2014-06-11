//
//  ViewController.swift
//  AXButtonDemo
//
//  Created by Alexander Kolov on 09/06/14.
//  Copyright (c) 2014 Alexander Kolov. All rights reserved.
//

import UIKit
import AXKButton

class ViewController: UIViewController {

  @IBOutlet var button1: UIButton!
  @IBOutlet var button2: AXKButton!
  @IBOutlet var button3: AXKButton!
  @IBOutlet var button4: AXKTranslucentButton!
                            
  override func viewDidLoad() {
    super.viewDidLoad()

    button1.setTitle("Button 1", forState: UIControlState.Normal)

    button2.layer.cornerRadius = 5
    button2.iconView.path = self.heartPath()
    button2.iconView.shapeLayer.fillRule = "even-odd"
    button2.setTitle("Button 2", forState: UIControlState.Normal)
    button2.setTitleColor(self.view.tintColor, forState: UIControlState.Normal)
    button2.setIconFillColor(self.view.tintColor, forState: UIControlState.Normal)
    button2.setTitleColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
    button2.setIconFillColor(UIColor.lightGrayColor(), forState: UIControlState.Highlighted)
    button2.setBackgroundColor(self.view.tintColor, forState: UIControlState.Selected)
    button2.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
    button2.setIconFillColor(UIColor.clearColor(), forState: UIControlState.Selected)
    button2.setIconStrokeColor(UIColor.whiteColor(), forState: UIControlState.Selected)
    button2.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected | UIControlState.Highlighted)
    button2.setIconStrokeColor(UIColor.whiteColor(), forState: UIControlState.Selected | UIControlState.Highlighted)
    button2.setIconFillColor(UIColor.clearColor(), forState: UIControlState.Selected | UIControlState.Highlighted)
    button2.setBackgroundColor(UIColor.lightGrayColor(), forState: UIControlState.Selected | UIControlState.Highlighted)

    let normalAttributedString = NSAttributedString(string: "Button 3",
      attributes: [NSFontAttributeName: UIFont.italicSystemFontOfSize(12),
        NSForegroundColorAttributeName: UIColor.redColor()])

    let highlightedAttributedString = NSAttributedString(string: "Button 3",
      attributes: [NSFontAttributeName: UIFont.italicSystemFontOfSize(12),
        NSForegroundColorAttributeName: UIColor.lightGrayColor()])

    let selectedAttributedString = NSAttributedString(string: "Button 3",
      attributes: [NSFontAttributeName: UIFont.italicSystemFontOfSize(12),
        NSForegroundColorAttributeName: UIColor.whiteColor()])

    button3.layer.cornerRadius = 5
    button3.setAttributedTitle(normalAttributedString, forState: UIControlState.Normal)
    button3.setAttributedTitle(highlightedAttributedString, forState: UIControlState.Highlighted)
    button3.setAttributedTitle(selectedAttributedString, forState: UIControlState.Selected)
    button3.setBackgroundColor(self.view.tintColor, forState: UIControlState.Selected)

    button4.layer.cornerRadius = 5
    button4.layer.masksToBounds = true
    button4.setTitle("Button 4", forState: UIControlState.Normal)
    button4.setBackgroundColor(UIColor(white: 0.5, alpha: 0.8), forState: UIControlState.Normal)
    button4.setBackgroundColor(UIColor(white: 0.5, alpha: 0.3), forState: UIControlState.Highlighted)
    button4.setBackgroundColor(UIColor(red: 1, green: 0, blue: 0, alpha: 0.8), forState: UIControlState.Selected)
    button4.setBackgroundColor(UIColor(red: 1, green: 0, blue: 0, alpha: 0.3), forState: UIControlState.Selected | UIControlState.Highlighted)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  @IBAction func didTapButton(sender: AXKButton!) {
    sender.selected = !sender.selected
  }

  func heartPath() -> UIBezierPath {
    let heart = UIBezierPath()
    heart.moveToPoint(CGPoint(x: 9.5, y: 2.42));
    heart.addCurveToPoint(CGPoint(x:  0,    y:  5.58), controlPoint1: CGPoint(x:  6.33, y: -2.28), controlPoint2: CGPoint(x:  0,    y:  0.47))
    heart.addCurveToPoint(CGPoint(x:  5.54, y: 13.37), controlPoint1: CGPoint(x:  0,    y:  9.04), controlPoint2: CGPoint(x:  3.16, y: 11.51))
    heart.addCurveToPoint(CGPoint(x:  9.5,  y: 16.5),  controlPoint1: CGPoint(x:  8.02, y: 15.3),  controlPoint2: CGPoint(x:  8.71, y: 15.72))
    heart.addCurveToPoint(CGPoint(x: 13.46, y: 13.37), controlPoint1: CGPoint(x: 10.29, y: 15.72), controlPoint2: CGPoint(x: 10.95, y: 15.26))
    heart.addCurveToPoint(CGPoint(x: 19.0,  y:  5.55), controlPoint1: CGPoint(x: 15.87, y: 11.55), controlPoint2: CGPoint(x: 19,    y:  9))
    heart.addCurveToPoint(CGPoint(x:  9.5,  y:  2.42), controlPoint1: CGPoint(x: 19,    y:  0.47), controlPoint2: CGPoint(x: 12.67, y: -2.28))
    heart.closePath()
    return heart
  }
}


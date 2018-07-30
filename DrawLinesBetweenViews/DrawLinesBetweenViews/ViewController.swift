//
//  ViewController.swift
//  DrawLinesBetweenViews
//
//  Created by Rashwan Lazkani on 2018-07-30.
//  Copyright © 2018 Rashwan Lazkani. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var isClusterActive = false
    var frameX = 0
    var frameY = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonClicked(_ sender: UIButton) {
        sender.layer.zPosition = 2
        isClusterActive = !isClusterActive
        if isClusterActive {
            sender.setTitle("None", for: .normal)
            removeViewsAndLayers()
        } else {
            let random = Int(arc4random_uniform(6) + 1)
            sender.setTitle("\(random)", for: .normal)
            addViewsAndLayers(sender, count: random)
        }
        
    }
    
    func addViewsAndLayers(_ sender: UIButton, count: Int) {
        let centerClick = CGPoint(x: sender.frame.midX, y: sender.frame.midY)
        
        let x: CGFloat = self.view.frame.maxX / CGFloat(count)
        var y: CGFloat = 0
        
        if isWihtinBoundsOfView(frame: CGRect(x: 0, y: sender.frame.origin.y + 100, width: 50, height: 50)) {
            y = sender.frame.origin.y + 100
        } else {
            y = sender.frame.origin.y - 100
        }
        
        for i in 0..<count {
            let customView = UIView()
            customView.frame = CGRect(x: x * CGFloat(i) + 5, y: y, width: 50, height: 50)
            customView.accessibilityIdentifier = "CustomView\(i)"
            customView.backgroundColor = .green
            customView.layer.zPosition = 2
            self.view.addSubview(customView)
            
            drawLine(fromPoint: centerClick, toPoint: CGPoint(x: customView.frame.midX, y: customView.frame.midY), index: i)
        }
    }
    
    func removeViewsAndLayers() {
        for subview in self.view.subviews {
            if !subview.isKind(of: UIButton.self)  {
                subview.removeFromSuperview()
            }
        }
        
        for i in 0..<10 {
            for layer in self.view.layer.sublayers! {
                if layer.name == "Layer\(i)" {
                    layer.removeFromSuperlayer()
                }
            }
        }
        return
    }
    
    func drawLine(fromPoint start: CGPoint, toPoint end: CGPoint, index: Int) {
        let line = CAShapeLayer()
        let linePath = UIBezierPath()
        linePath.move(to: start)
        linePath.addLine(to: end)
        line.path = linePath.cgPath
        line.name = "Layer\(index)"
        line.fillColor = nil
        line.opacity = 1.0
        line.strokeColor = UIColor.red.cgColor
        line.zPosition = 1
        self.view.layer.addSublayer(line)
    }
    
    func isWihtinBoundsOfView(frame: CGRect) -> Bool {
        return self.view.superview!.bounds.contains(frame)
    }
    
}

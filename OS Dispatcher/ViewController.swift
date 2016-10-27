//
//  ViewController.swift
//  OS Dispatcher
//
//  Created by Lalo on 10/20/16.
//  Copyright © 2016 Eduardo Valencia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func loadView() {
        super.loadView()
        
        self.view.backgroundColor = Tools.colorPicker(3, alpha: 1)
        
        // Create imageView
        let imageView = UIImageView(image: UIImage(named: "Landing Background"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        
        // Add imageView Constraints
        let imageViewCenterX = NSLayoutConstraint(item: self.view, attribute: .centerX, relatedBy: .equal, toItem: imageView, attribute: .centerX, multiplier: 1, constant: 0)
        let imageViewVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-100-[imageView(540)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["imageView" : imageView])
        self.view.addConstraint(imageViewCenterX)
        self.view.addConstraints(imageViewVerticalConstraints)
        
        // Create gradientView
        
        let gradientView = UIView()
        gradientView.backgroundColor = .clear
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(gradientView)
        
        // Add gradientView Constraints
        let horizontalGradientConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[gradientView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["gradientView" : gradientView])
        let verticalGradientConstrains = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[gradientView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["gradientView" : gradientView])
        self.view.addConstraints(horizontalGradientConstraints)
        self.view.addConstraints(verticalGradientConstrains)
        
        // Create gradientOverlay
        let gradientOverlay = Tools.createGradient(self.view.bounds, colors: [Tools.colorPicker(2, alpha: 0.1).cgColor, Tools.colorPicker(2, alpha: 0.6).cgColor], locations: [0, 1], startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1))
        gradientView.layer.addSublayer(gradientOverlay)
        
        // Create osLabel
        let osLabel = UILabel()
        osLabel.text = "OS"
        osLabel.textAlignment = .center
        osLabel.textColor = Tools.colorPicker(1, alpha: 1)
        osLabel.font = UIFont.systemFont(ofSize: 100, weight: UIFontWeightLight)
        osLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(osLabel)
        
        // Add osLabel Constraints
        let osLabelCenterX = NSLayoutConstraint(item: self.view, attribute: .centerX, relatedBy: .equal, toItem: osLabel, attribute: .centerX, multiplier: 1, constant: 0)
        let osLabelVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-70-[osLabel(80)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["osLabel" : osLabel])
        self.view.addConstraint(osLabelCenterX)
        self.view.addConstraints(osLabelVerticalConstraints)
        
        // Create dispatcherLabel
        let dispatcherLabel = UILabel()
        dispatcherLabel.text = "Dispatcher"
        dispatcherLabel.textAlignment = .center
        dispatcherLabel.textColor = Tools.colorPicker(1, alpha: 1)
        dispatcherLabel.font = UIFont.systemFont(ofSize: 30, weight: UIFontWeightLight)
        dispatcherLabel.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(dispatcherLabel)
        
        // Add dispatcherLabel Constraints
        let dispatcherLabelCenterX = NSLayoutConstraint(item: self.view, attribute: .centerX, relatedBy: .equal, toItem: dispatcherLabel, attribute: .centerX, multiplier: 1, constant: 0)
        let dispatcherLabelVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[osLabel]-1-[dispatcherLabel]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["osLabel" : osLabel, "dispatcherLabel" : dispatcherLabel])
        self.view.addConstraint(dispatcherLabelCenterX)
        self.view.addConstraints(dispatcherLabelVerticalConstraints)
        
        // Create startButton
        let startButton = Tools.createButton("Start", textColor: Tools.colorPicker(1, alpha: 1), highlightedTextColor: Tools.colorPicker(1, alpha: 0.6), disabledTextColor: Tools.colorPicker(1, alpha: 0.8), fontSize: 20, weight: UIFontWeightMedium, vc: self, selector: #selector(self.start(_:)), backgroundColor: Tools.colorPicker(4, alpha: 0.5), highlightedColor: Tools.colorPicker(4, alpha: 1))
        self.view.addSubview(startButton)
        
        // Add startButton Constraints
        
        let startCenterX = NSLayoutConstraint(item: self.view, attribute: .centerX, relatedBy: .equal, toItem: startButton, attribute: .centerX, multiplier: 1, constant: 0)
        let startWidth = NSLayoutConstraint(item: startButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
        let startVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[startButton(50)]-40-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["startButton" : startButton])
        self.view.addConstraint(startCenterX)
        self.view.addConstraint(startWidth)
        self.view.addConstraints(startVerticalConstraints)
        
        startButton.isEnabled = true
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    func start(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MainData")as! SessionOptionsViewController
        self.present(vc, animated: true, completion: nil)
    }

}


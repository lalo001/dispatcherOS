//
//  QuantumViewController.swift
//  OS Dispatcher
//
//  Created by Lalo on 10/26/16.
//  Copyright © 2016 Eduardo Valencia. All rights reserved.
//

import UIKit

class QuantumViewController: UIViewController, UITextFieldDelegate {

    var imageView: UIImageView!
    var gradientView: UIView!
    var textField: UITextField!
    var scrollView: AutoKeyboardScrollView!
    var label: UILabel!
    var continueButton: UIButton!
    var session: Session!
    
    override func loadView() {
        super.loadView()
        
        // Create imageView
        imageView = UIImageView(image: UIImage(named: "Quantum"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        
        // Add imageView Constraints
        let imageViewHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[imageView]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["imageView" : imageView])
        let imageViewVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[imageView(\(self.view.frame.size.height))]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["imageView" : imageView])
        self.view.addConstraints(imageViewHorizontalConstraints)
        self.view.addConstraints(imageViewVerticalConstraints)
        
        // Create gradientView
        
        gradientView = UIView()
        gradientView.backgroundColor = .clear
        gradientView.alpha = 0
        gradientView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(gradientView)
        
        // Add gradientView Constraints
        let horizontalGradientConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[gradientView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["gradientView" : gradientView])
        let verticalGradientConstrains = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[gradientView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["gradientView" : gradientView])
        self.view.addConstraints(horizontalGradientConstraints)
        self.view.addConstraints(verticalGradientConstrains)
        
        // Create gradientOverlay
        let gradientOverlay = Tools.createGradient(self.view.bounds, colors: [Tools.colorPicker(2, alpha: 0.5).cgColor, Tools.colorPicker(2, alpha: 0.95).cgColor], locations: [0, 1], startPoint: CGPoint(x: 0.5, y: 0), endPoint: CGPoint(x: 0.5, y: 1))
        gradientView.layer.addSublayer(gradientOverlay)
        
        // Create scrollView
        scrollView = AutoKeyboardScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        gradientView.addSubview(scrollView)
        
        // Add scrollView Constraints
        let scrollViewHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[scrollView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["scrollView" : scrollView])
        let scrollViewVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[scrollView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["scrollView" : scrollView])
        gradientView.addConstraints(scrollViewHorizontalConstraints)
        gradientView.addConstraints(scrollViewVerticalConstraints)
        
        // Create textField
        textField = UITextField()
        let attributedPlaceholder = NSAttributedString(string: "0", attributes: [NSForegroundColorAttributeName : Tools.colorPicker(1, alpha: 1)])
        textField.attributedPlaceholder = attributedPlaceholder
        textField.delegate = self
        textField.addTarget(self, action: #selector(self.textDidChange(_:)), for: .editingChanged)
        textField.font = UIFont.systemFont(ofSize: 100, weight: UIFontWeightLight)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.keyboardType = .numberPad
        textField.keyboardAppearance = .dark
        textField.textAlignment = .center
        textField.adjustsFontSizeToFitWidth = true
        textField.minimumFontSize = 17
        textField.tintColor = .clear
        textField.textColor = Tools.colorPicker(1, alpha: 1)
        textField.alpha = 0
        scrollView.contentView.addSubview(textField)
        
        // Add textField Constraints
        let textFieldCenterX = NSLayoutConstraint(item: scrollView.contentView, attribute: .centerX, relatedBy: .equal, toItem: textField, attribute: .centerX, multiplier: 1, constant: 0)
        let textFieldCenterY = NSLayoutConstraint(item: scrollView.contentView, attribute: .centerY, relatedBy: .equal, toItem: textField, attribute: .centerY, multiplier: 1, constant: 20)
        let textFieldWidth = NSLayoutConstraint(item: textField, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.view.frame.size.width - 200)
        scrollView.contentView.addConstraint(textFieldCenterX)
        scrollView.contentView.addConstraint(textFieldCenterY)
        scrollView.contentView.addConstraint(textFieldWidth)
        
        // Create label
        label = UILabel()
        label.textAlignment = .center
        label.textColor = Tools.colorPicker(1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFontWeightMedium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Quantum Size"
        label.alpha = 0
        scrollView.contentView.addSubview(label)
        
        // Add label Constraints
        let labelHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[label(200)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["label" : label])
        let labelVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[textField]-0-[label]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["textField" : textField, "label" : label])
        let labelCenterX = NSLayoutConstraint(item: scrollView.contentView, attribute: .centerX, relatedBy: .equal, toItem: label, attribute: .centerX, multiplier: 1, constant: 0)
        scrollView.contentView.addConstraints(labelHorizontalConstraints)
        scrollView.contentView.addConstraints(labelVerticalConstraints)
        scrollView.contentView.addConstraint(labelCenterX)
        
        // Create continueButton
        continueButton = Tools.createButton("Continue", textColor: Tools.colorPicker(1, alpha: 1), highlightedTextColor: Tools.colorPicker(1, alpha: 0.6), disabledTextColor: Tools.colorPicker(1, alpha: 0.8), fontSize: 20, weight: UIFontWeightMedium, vc: self, selector: #selector(self.continuePressed(_:)), backgroundColor: Tools.colorPicker(4, alpha: 0.5), highlightedColor: Tools.colorPicker(4, alpha: 1))
        continueButton.alpha = 0
        self.view.addSubview(continueButton)
        
        // Add continueButton Constraints
        let continueCenterX = NSLayoutConstraint(item: self.view, attribute: .centerX, relatedBy: .equal, toItem: continueButton, attribute: .centerX, multiplier: 1, constant: 0)
        let continueWidth = NSLayoutConstraint(item: continueButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
        let continueVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[continueButton(50)]-40-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["continueButton" : continueButton])
        self.view.addConstraint(continueCenterX)
        self.view.addConstraint(continueWidth)
        self.view.addConstraints(continueVerticalConstraints)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.= 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIView.animate(withDuration: 1, animations: {
            self.gradientView.alpha = 1
            self.textField.alpha = 0.6
            self.label.alpha = 1
            self.continueButton.alpha = 1
            }, completion: {(completed) -> Void in
                self.scrollView.activeTextField = self.textField
                self.textField.becomeFirstResponder()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 1, animations: {
            self.textField.alpha = 1
        })
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" {
            UIView.animate(withDuration: 1, animations: {
                self.textField.alpha = 0.6
            })
        }
    }
    
    func textDidChange(_ sender: UITextField) {
        guard sender.text != nil else {
            return
        }
        if sender.text != "" && sender.text != "0" {
            continueButton.isEnabled = true
        } else {
            continueButton.isEnabled = false
        }
    }
    
    func continuePressed(_ sender: UIButton) {
        if textField.text == "" || textField.text == "0" {
            let alert = UIAlertController(title: "OS Dispatcher", message: "You have to choose at least 1 processor.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: {()-> Void in
                self.textField.text = ""
            })
        } else {
            session.quantumSize = Int(textField.text!)!
            textField.resignFirstResponder()
            self.performSegue(withIdentifier: "change", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ChangeTimeViewController
        vc.session = session
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
}

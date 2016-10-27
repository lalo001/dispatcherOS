//
//  DataViewController.swift
//  OS Dispatcher
//
//  Created by Lalo on 10/26/16.
//  Copyright © 2016 Eduardo Valencia. All rights reserved.
//

import UIKit

extension Array {
    func toFinalTimesDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Int] {
        var dict = [Key:Int]()
        for element in self {
            dict[selectKey(element)] = (element as! Processor).finalTime
        }
        return dict
    }
    
    func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element] {
        var dict = [Key:Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
}

class DataViewController: UIViewController, UITextViewDelegate {

    var imageView: UIImageView!
    var gradientView: UIView!
    var scrollView: AutoKeyboardScrollView!
    var label: UILabel!
    var textView: UITextView!
    var calculateButton: UIButton!
    var session: Session!
    var processesOrder: [[String : Any]]!
    var processes: [String: [String: Any]]!
    var existingProcessors: [Processor] = []
    var existingProcesses: [Process] = []
    var blockTime = 0
    var changeTime = 0
    var quantumSize = 0
    var numberOfProcessors = 0
    var sections: [String]! = []
    var processorKeys: [String]! = []
    var mainDictionary = [String: [[String: Any]]]()
    var numberOfProcesses = 0
    
    override func loadView() {
        super.loadView()
        
        // Create imageView
        imageView = UIImageView(image: UIImage(named: "Data"))
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(imageView)
        
        // Add imageView Constraints
        let imageViewHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[imageView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["imageView" : imageView])
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
        
        // Create label
        label = UILabel()
        label.textAlignment = .center
        label.textColor = Tools.colorPicker(1, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 25, weight: UIFontWeightMedium)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Processes\n(Name, Execution Time, Blocked Times, Time of Arrival"
        label.alpha = 0
        scrollView.contentView.addSubview(label)
        
        // Add label Constraints
        let labelHorizontalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[label(200)]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["label" : label])
        let labelVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:|-50-[label]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["label" : label])
        let labelCenterX = NSLayoutConstraint(item: scrollView.contentView, attribute: .centerX, relatedBy: .equal, toItem: label, attribute: .centerX, multiplier: 1, constant: 0)
        scrollView.contentView.addConstraints(labelHorizontalConstraints)
        scrollView.contentView.addConstraints(labelVerticalConstraints)
        scrollView.contentView.addConstraint(labelCenterX)
        
        // Create textView
        textView = UITextView()
        textView.delegate = self
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.tintColor = Tools.colorPicker(1, alpha: 1)
        textView.textColor = Tools.colorPicker(1, alpha: 1)
        textView.backgroundColor = .clear
        textView.font = UIFont.systemFont(ofSize: 17, weight: UIFontWeightRegular)
        textView.showsHorizontalScrollIndicator = false
        textView.showsVerticalScrollIndicator = false
        textView.text = "B 300 2 0\nD 100 2 0\nF 500 3 0\nH 700 4 0\nJ 300 2 1500\nL 3000 5 1500\nN 50 2 1500\nO 600 3 1500\nA 400 2 3000\nC 50 2 3000\nE 1000 5 3000\nG 10 2 3000\nI 450 3 3000\nK 100 2 4000\nM 80 2 4000\nP 800 4 4000\nÑ 500 3 8000"
        scrollView.contentView.addSubview(textView)
        
        // Add textView Constraints
        let textViewCenterX = NSLayoutConstraint(item: scrollView.contentView, attribute: .centerX, relatedBy: .equal, toItem: textView, attribute: .centerX, multiplier: 1, constant: 0)
        let textViewTop = NSLayoutConstraint(item: scrollView.contentView, attribute: .top, relatedBy: .equal, toItem: textView, attribute: .top, multiplier: 1, constant: -100)
        let textViewWidth = NSLayoutConstraint(item: textView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.view.frame.size.width - 50)
        let textViewHeight = NSLayoutConstraint(item: textView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: self.view.frame.size.height - 220)
        scrollView.contentView.addConstraint(textViewCenterX)
        scrollView.contentView.addConstraint(textViewTop)
        scrollView.contentView.addConstraint(textViewWidth)
        scrollView.contentView.addConstraint(textViewHeight)
        
        // Create calculateButton
        calculateButton = Tools.createButton("Calculate", textColor: Tools.colorPicker(1, alpha: 1), highlightedTextColor: Tools.colorPicker(1, alpha: 0.6), disabledTextColor: Tools.colorPicker(1, alpha: 0.8), fontSize: 20, weight: UIFontWeightMedium, vc: self, selector: #selector(self.calculate), backgroundColor: Tools.colorPicker(4, alpha: 0.5), highlightedColor: Tools.colorPicker(4, alpha: 1))
        calculateButton.alpha = 0
        self.view.addSubview(calculateButton)
        
        // Add calculateButton Constraints
        let calculateCenterX = NSLayoutConstraint(item: self.view, attribute: .centerX, relatedBy: .equal, toItem: calculateButton, attribute: .centerX, multiplier: 1, constant: 0)
        let calculateWidth = NSLayoutConstraint(item: calculateButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 200)
        let calculateVerticalConstraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[calculateButton(50)]-40-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: ["calculateButton" : calculateButton])
        self.view.addConstraint(calculateCenterX)
        self.view.addConstraint(calculateWidth)
        self.view.addConstraints(calculateVerticalConstraints)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        blockTime = session.blockedTime
        changeTime = session.changeTime
        quantumSize = session.quantumSize
        numberOfProcessors = session.processors
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        calculateButton.isEnabled = true
        UIView.animate(withDuration: 1, animations: {
            self.gradientView.alpha = 1
            self.textView.alpha = 1
            self.label.alpha = 1
            self.calculateButton.alpha = 1
            }, completion: {(completed) -> Void in
                self.textView.becomeFirstResponder()
        })
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if textView.text != nil || textView.text != "" {
            calculateButton.isEnabled = true
        } else {
            calculateButton.isEnabled = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func calculate() {
        let textArray = textView.text.components(separatedBy: .newlines)
        numberOfProcesses = textArray.count
        for i in 0 ..< textArray.count {
            let currentArray = textArray[i].components(separatedBy: .whitespaces)
            if currentArray.count == 4 {
                let newProcess = Process(id: currentArray[0] , executionTime: Int(currentArray[1])!, minTime: Int(currentArray[3])!, timesBlocked: Int(currentArray[2])!, rulesArray: [])
                existingProcesses.append(newProcess)
            } else {
                let alert = UIAlertController(title: "Error", message: "The format of the processes is incorrect.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
        }
        existingProcesses = existingProcesses.sorted{
            if $0.minTime != $1.minTime  {
                return $0.minTime < $1.minTime
            } else {
                return false
            }
        }
        solve()
    }
    
    func getBestProcessor(processorsArray: [Processor]) -> Processor? {
        let processorsDict = processorsArray.toDictionary {$0.id}
        let finalDict = processorsArray.toFinalTimesDictionary {$0.id}
        let minFinalTime = finalDict.values.min()
        let bestIDs = allKeysForValue(dict: finalDict, val: minFinalTime!)
        if bestIDs.count > 1 {
            return processorsDict[bestIDs.min()!]
        } else if bestIDs.count == 1 {
            return processorsDict[bestIDs[0]]
        } else {
            return nil
        }
    }
    
    /**Calculates all the required data for each process.
     
     - Parameter processor: The Processor object in which the process will be executed.
     - Parameter process: The Process object to be executed.
     - Returns: A dictionary with all the calculated values for the process.
     - Warning: The processor can change as required by the minimum time of the process.
     */
    
    func calculateProcessData(processor: Processor, process: Process) -> Dictionary<String, Any>{
        var processor = processor
        
        if process.minTime > processor.finalTime {
            let candidateProcessors = existingProcessors.filter({$0.finalTime == process.minTime})
            let processorsToBeUpdated = existingProcessors.filter({$0.finalTime < process.minTime})
            for current in processorsToBeUpdated {
                print("Processor number \(current.id!) will wait until \(process.minTime!)ms")
                let dictionary = ["process" : "Hole", "processor" : current.id, "waitUntil" : process.minTime!] as [String : Any]
                mainDictionary["\(current.id!)"]?.append(dictionary)
                current.initialTime = process.minTime
                current.finalTime = process.minTime
                current.isFirstProcess = true
            }
            if candidateProcessors.count > 0 {
                processor = getBestProcessor(processorsArray: candidateProcessors)!
            } else {
                processor = getBestProcessor(processorsArray: processorsToBeUpdated)!
            }
        }
        
        
        let executionTime = process.executionTime!
        let blocks = process.timesBlocked!
        let tcc = processor.isFirstProcess ? 0 : changeTime
        processor.isFirstProcess = false
        let tvc = executionTime % quantumSize == 0 ? ((executionTime/quantumSize) - 1) * changeTime : Int(executionTime/quantumSize) * changeTime
        let blockedTime = blockTime * blocks
        let totalTime = tcc + executionTime + tvc + blockedTime
        processor.finalTime += totalTime
        let dictionary = ["process" : process.id, "processor" : processor.id, "tcc" : tcc, "executionTime" : executionTime, "tvc" : tvc, "blockedTime" : blockedTime, "totalTime" : totalTime, "initialTime" : processor.initialTime, "finalTime" : processor.finalTime] as [String : Any]
        mainDictionary["\(processor.id!)"]?.append(dictionary)
        processor.initialTime = processor.finalTime
        return dictionary
    }
    
    /**Solves the sequence as defined by the processesOrder array.
     */
    
    func solve() {
        let pastDate = Date()
        for _ in 0..<numberOfProcessors {
            createNewProcessor()
        }
        for i in 0..<existingProcesses.count {
            guard let bestProcessor = getBestProcessor(processorsArray: existingProcessors) else { return }
            print(calculateProcessData(processor: bestProcessor, process: existingProcesses[i]))
        }
        let nowDate = Date().timeIntervalSince(pastDate)
        print("Spent time: \(nowDate/3600)")
        self.performSegue(withIdentifier: "results", sender: self)
        
    }

    /**Returns all the keys of type K from a dictionary that match a given value of type V.
     - Parameter dict: A dictionary with a key of type K and value of type V.
     - Parameter val: A value of type V.
     - Returns: An array of keys of type K.
     */
    
    func allKeysForValue<K, V : Equatable>(dict: [K : V], val: V) -> [K] {
        return dict.filter{ $0.1 == val }.map{ $0.0 }
    }
    
    /**Creates a new Processor object and adds it to the existingProcessors array.
     - Returns: A Processor Object
     */
    
    func createNewProcessor() {
        let newProcessor = Processor()
        existingProcessors.append(newProcessor)
        let id = newProcessor.id
        sections.append("Processor \(id!)")
        processorKeys.append("\(id!)")
        mainDictionary["\(id!)"] = []
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let vc = segue.destination as! ResultsViewController
        vc.sections = sections
        vc.processorKeys = processorKeys
        vc.mainDictionary = mainDictionary
        vc.processesCount = "\(numberOfProcesses)"
    }
 

}

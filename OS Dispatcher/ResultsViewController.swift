//
//  ResultsViewController.swift
//  OS Dispatcher
//
//  Created by Lalo on 10/26/16.
//  Copyright © 2016 Eduardo Valencia. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    @IBOutlet var numberOfProcesses: UILabel!
    @IBOutlet var closeButton: UIButton!
    var processesCount = ""
    var sections: [String]!
    var processorKeys: [String]!
    var mainDictionary: [String: [[String:Any]]]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        numberOfProcesses.text = processesCount
        closeButton.addTarget(self, action: #selector(self.close(_:)), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDictionary["\(section + 1)"]?.count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier") as! ResultsTableViewCell
        let current = mainDictionary["\(indexPath.section + 1)"]?[indexPath.row]
        if current?["process"] as! String == "Hole" {
            cell.textLabel?.text = "Processor will wait until \(current!["waitUntil"]!)ms"
            cell.idLabel.text = ""
            cell.tccLabel.text = ""
            cell.teLabel.text = ""
            cell.tvcLabel.text = ""
            cell.tbLabel.text = ""
            cell.ttLabel.text = ""
            cell.tiLabel.text = ""
            cell.tfLabel.text = ""
        } else {
            cell.textLabel?.text = ""
            cell.idLabel.text = "\(current!["process"]!)"
            cell.tccLabel.text = "\(current!["tcc"]!)"
            cell.teLabel.text = "\(current!["executionTime"]!)"
            cell.tvcLabel.text = "\(current!["tvc"]!)"
            cell.tbLabel.text = "\(current!["blockedTime"]!)"
            cell.ttLabel.text = "\(current!["totalTime"]!)"
            cell.tiLabel.text = "\(current!["initialTime"]!)"
            cell.tfLabel.text = "\(current!["finalTime"]!)"
        }
        return cell
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    func close(_ sender: UIButton) {
        (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController?.dismiss(animated: true, completion: nil)
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

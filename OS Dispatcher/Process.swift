//
//  Process.swift
//  OS Dispatcher
//
//  Created by Lalo on 10/26/16.
//  Copyright © 2016 Eduardo Valencia. All rights reserved.
//

import UIKit

class Process {
    let id: String!
    let executionTime: Int!
    let timesBlocked: Int!
    let minTime: Int!
    
    init(id: String, executionTime: Int, minTime: Int, timesBlocked: Int, rulesArray: [Dictionary<String, Int>]) {
        self.id = id
        self.executionTime = executionTime
        self.minTime = minTime
        if rulesArray.count == 0 {
            self.timesBlocked = timesBlocked
            return
        }
        for i in 0..<rulesArray.count {
            let min = rulesArray[i]["min"]
            let max = rulesArray[i]["max"]
            if executionTime >= min! && executionTime <= max! {
                self.timesBlocked = rulesArray[i]["times"]!
                return
            }
        }
        self.timesBlocked = 0
    }
}

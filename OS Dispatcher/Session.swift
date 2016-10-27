//
//  Session.swift
//  OS Dispatcher
//
//  Created by Lalo on 10/26/16.
//  Copyright © 2016 Eduardo Valencia. All rights reserved.
//

import UIKit

class Session {

    var processors: Int
    var quantumSize: Int
    var changeTime: Int
    var blockedTime: Int
    var status: Status
 
    enum Status: Int {
        case processor = 0, quantum, change, blocked
    }

    
    init(processors: Int, quantumSize: Int, changeTime: Int, blockedTime: Int) {
        self.processors = processors
        self.quantumSize = quantumSize
        self.changeTime = changeTime
        self.blockedTime = blockedTime
        self.status = .processor
    }
}

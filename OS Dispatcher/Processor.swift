//
//  Processor.swift
//  OS Dispatcher
//
//  Created by Lalo on 10/26/16.
//  Copyright © 2016 Eduardo Valencia. All rights reserved.
//

import UIKit

var lastID = 0

class Processor {
    let id: Int!
    var initialTime = 0
    var finalTime = 0
    var isFirstProcess = true
    
    init() {
        self.id = lastID + 1
        lastID += 1
    }
}

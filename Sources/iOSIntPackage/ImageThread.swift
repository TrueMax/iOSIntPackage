//
// ImageThread.swift
// 
// 
// Created by Maxim Abakumov on 2021. 06. 17.
//
// Copyright © 2020, Maxim Abakumov. MIT License.
//

import Foundation

class ImageThread: Thread {
    
    private var workItem: () -> Void
    
    init(
        qos: QualityOfService,
        workItem: @escaping () -> Void
    ) {
        self.workItem = workItem
        super.init()
        super.qualityOfService = qos
    }
    
    override func main() {
        workItem()
    }
}

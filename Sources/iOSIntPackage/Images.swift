//
// File.swift
// 
// 
// Created by Maxim Abakumov on 2021. 01. 04.
//
// Copyright © 2020, Maxim Abakumov. MIT License.
//

import UIKit

public enum Images: String, CaseIterable {
    
    case checkmark
    case sunset
    case mountain
    case annecy
    case annecy2
    case skyscraper
    case avatar
    case cafe
    
    public func image(name: Images) -> UIImage {
        return getPdfImage(by: name.rawValue)
    }
    
    private func getPdfImage(by name: String) -> UIImage {
        
        guard let image = UIImage(
                named: name,
                in: Bundle.module,
                compatibleWith: nil
        ) else {
            fatalError("Error retrieving image from path")
        }
        return image
    }
}

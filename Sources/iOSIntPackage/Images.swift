//
// File.swift
// 
// 
// Created by Maxim Abakumov on 2021. 01. 04.
//
// Copyright © 2020, Maxim Abakumov. MIT License.
//

import UIKit

public struct Images {
    
    public static var checkmark: UIImage {
        return getPdfImage(by: "checkmark")
    }
    
    public static var sunset: UIImage {
        return getPdfImage(by: "sunset")
    }
    
    public static var mountain: UIImage {
        return getPdfImage(by: "mountain")
    }
    
    private static func getPdfImage(by name: String) -> UIImage {
        
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

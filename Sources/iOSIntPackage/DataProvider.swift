//
//  File.swift
//  
//
//  Created by Maxim on 2020. 10. 12..
//

import UIKit

// MARK: - DataProvider

public final class DataProvider {
    
    // MARK: - Private properties
    
    private let student: String
    
    public init(student name: String) {
        self.student = name
    }
    
    public func fetchPersonData() -> String {
        
        return "Здравствуйте, \(student)! Вот ваш бутерброд!" + iOSIntPackage().text
    }
    
    public func fetchImage() -> UIImage {
        return UIImage(
            named: "checkmark",
            in: Bundle.module,
            compatibleWith: nil
        )!
    }
}

// MARK: - Extension

extension UIViewController {
    
}

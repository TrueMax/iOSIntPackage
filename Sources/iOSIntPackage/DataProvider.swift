//
//  File.swift
//  
//
//  Created by Maxim on 2020. 10. 12..
//

import Foundation

public final class DataProvider {
    
    private let student: String
    
    public init(student name: String) {
        self.student = name
    }
    
    public func fetchPersonData() -> String {
        
        return "Здравствуйте, \(student)! Вот ваш бутерброд!" + iOSIntPackage().text
    }
}

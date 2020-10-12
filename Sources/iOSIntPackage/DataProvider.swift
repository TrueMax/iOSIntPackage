//
//  File.swift
//  
//
//  Created by Maxim on 2020. 10. 12..
//

import Foundation

public final class DataProvider {
    
    public func fetchPersonData(student: String) -> String {
    
        return "Здравствуйте, \(student)! Вот ваш бутерброд!"
    }
}

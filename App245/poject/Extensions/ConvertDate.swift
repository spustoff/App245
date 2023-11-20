//
//  ConvertDate.swift
//  App245
//
//  Created by IGOR on 13/11/2023.
//

import SwiftUI

extension Date {
    
    func convertDate(format: String) -> String {
        
        let date = self
        let formatter = DateFormatter()
        
        formatter.dateFormat = format
        
        return formatter.string(from: date)
    }
}

extension UIApplication {
    
    func endEditing() {
        
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

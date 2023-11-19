//
//  FinanceViewModel.swift
//  App245
//
//  Created by IGOR on 17/11/2023.
//

import SwiftUI

final class FinanceViewModel: ObservableObject {

    @Published var months: [String] = ["Sep", "Oct", "Nov", "Dec"]
    @Published var current_month = "Nov"
    @Published var isNewEarning: Bool = false
    @Published var earningSum: String = ""
    @Published var earningDate: Date = Date()
    
    @AppStorage("earnings") var earnings: [String] = []

}


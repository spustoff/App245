//
//  WorkersViewModel.swift
//  App245
//
//  Created by IGOR on 13/11/2023.
//

import SwiftUI

final class WorkersViewModel: ObservableObject {

    @AppStorage("workers") var workers: [String] = []
    @Published var isAddWorker: Bool = false
    @Published var workersName = ""
}

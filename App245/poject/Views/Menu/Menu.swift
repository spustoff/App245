//
//  Menu.swift
//  App245
//
//  Created by IGOR on 13/11/2023.
//

import SwiftUI
import StoreKit

struct MenuView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    @State var tabs: [String] = ["Main", "Workers", "Finance", "Tasks", "Policy Usage", "Rate Us"]
    @State var isDelete: Bool = false
    
    @Binding var show: Bool
    @Binding var currentTab: String
    
    var body: some View {
        
        ZStack {
            
            Color.black.opacity(show ? 0.5 : 0)
                .ignoresSafeArea()
                .onTapGesture {
                    
                    withAnimation(.spring()) {
                        
                        show = false
                    }
                }
            
            VStack {
                
                HStack {
                    
                    Text("Menu")
                        .foregroundColor(.white)
                        .font(.system(size: 32, weight: .semibold))
                    
                    Spacer()
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            show = false
                        }
                        
                    }, label: {
                        
                        Image(systemName: "xmark")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .regular))
                    })
                }
                .padding()
                
                VStack {
                    
                    ForEach(tabs, id: \.self) { index in
                        
                        HStack {
                            
                            Image(index)
                            
                            Text(index)
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .medium))
                            
                            Spacer()
                            
                            Image(systemName: "chevron.right")
                                .foregroundColor(.gray)
                                .font(.system(size: 14, weight: .regular))
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg3")))
                        .onTapGesture {
                            
                            if index == "Rate Us" {
                                
                                SKStoreReviewController.requestReview()
                                
                            } else if index == "Policy Usage" {
                                
                                guard let url = URL(string: "https://docs.google.com/document/d/1xA0HWgQ8sfBMkluCho9ZyJyIPyl5WFCkG4ETHiudtFc/edit?usp=sharing") else { return }
                                
                                UIApplication.shared.open(url)
                            } else {
                                
                                withAnimation(.spring()) {
                                    
                                    currentTab = index
                                }
                            }
                            
                            withAnimation(.spring()) {
                                
                                show = false
                            }
                        }
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
            }
            .padding(.vertical, 50)
            .frame(width: UIScreen.main.bounds.width / 1.2)
            .frame(maxHeight: .infinity)
            .background(Color("bg"))
            .frame(maxWidth: .infinity, alignment: .leading)
            .offset(x: show ? 0 : -UIScreen.main.bounds.width)
        }
        .ignoresSafeArea()
        .overlay (
            
            DeleteAccount(delete: $isDelete)
        )
    }
}

struct DeleteAccount: View {
    @AppStorage("status") var status: Bool = false
    
    @Binding var delete: Bool
    
    var body: some View {
        
        ZStack {
            
            Color.black
                .ignoresSafeArea()
                .opacity(delete ? 0.8 : 0)
                .onTapGesture {
                    
                    withAnimation(.spring()) {
                        
                        delete = false
                    }
                }
            
            VStack {
                
                Text("Reset progress")
                    .foregroundColor(.white)
                    .font(.system(size: 18, weight: .semibold))
                
                Text("Your entire progress will be permanently deleted")
                    .foregroundColor(.gray)
                    .font(.system(size: 13, weight: .regular))
                    .multilineTextAlignment(.center)
                    .padding(.bottom)
                
                Button(action: {
                    
                    withAnimation(.spring()) {
                        
                        delete = false
                    }


                    status = false
                    
                }, label: {
                    
                    Text("Reset")
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .medium))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(.red))
                })
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg")))
            .padding()
            .offset(y: delete ? 0 : UIScreen.main.bounds.height)
        }
    }
}

#Preview {
    MenuView(show: .constant(true), currentTab: .constant(""))
}

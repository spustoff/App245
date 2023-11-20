//
//  MainAdd.swift
//  App245
//
//  Created by IGOR on 18/11/2023.
//

import SwiftUI

struct MainAdd: View {
    
    @Environment(\.presentationMode) var router
    
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Text("New Object")
                        .foregroundColor(Color("primary"))
                        .font(.system(size: 18, weight: .semibold))
                    
                    Spacer()
                    
                    Button(action: {
                    
                        UIApplication.shared.endEditing()
                        
                        router.wrappedValue.dismiss()
                        
                    }, label: {
                        
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                            .font(.system(size: 15, weight: .bold))
                    })
                }
                .padding()
                .padding(.top)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVStack {
                        
                        Image("img")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .padding(.bottom, 20)
                        
                        VStack(alignment: .leading, spacing: 10, content: {
                            
                            Text("Adress")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .regular))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("Enter")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                    .opacity(viewModel.address.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.address)
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .regular))
                            })
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
                        })
                        .padding(.bottom, 15)
                        
                        VStack(alignment: .leading, spacing: 10, content: {
                            
                            Text("Construction cost")
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .regular))
                            
                            ZStack(alignment: .leading, content: {
                                
                                Text("$1000.00")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 14, weight: .regular))
                                    .opacity(viewModel.cost.isEmpty ? 1 : 0)
                                
                                TextField("", text: $viewModel.cost)
                                    .foregroundColor(.white)
                                    .font(.system(size: 14, weight: .regular))
                                    .keyboardType(.decimalPad)
                            })
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.gray.opacity(0.1)))
                        })
                    }
                    .padding()
                }
                
                Spacer()
                
                Button(action: {
                    
                    UIApplication.shared.endEditing()
                    
                    viewModel.addObject {
                        
                        viewModel.fetchObjects()
                        
                        router.wrappedValue.dismiss()
                        
                        viewModel.address = ""
                        viewModel.cost = ""
                    }
                    
                }, label: {
                    
                    Text("Add Object")
                        .foregroundColor(.black)
                        .font(.system(size: 15, weight: .regular))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                        .padding()
                })
                .opacity(viewModel.cost.isEmpty || viewModel.address.isEmpty ? 0.5 : 1)
                .disabled(viewModel.cost.isEmpty || viewModel.address.isEmpty ? true : false)
            }
        }
    }
}

#Preview {
    MainAdd(viewModel: MainViewModel())
}

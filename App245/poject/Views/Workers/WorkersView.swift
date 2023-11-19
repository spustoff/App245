//
//  WorkersView.swift
//  App245
//
//  Created by IGOR on 13/11/2023.
//

import SwiftUI

struct WorkersView: View {
    
    @Binding var show: Bool
    
    @StateObject var viewModel = WorkersViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            show = true
                        }
                        
                    }, label: {
                        
                        VStack(spacing: 3) {
                            
                            RoundedRectangle(cornerRadius: 3)
                                .fill(.white)
                                .frame(width: 20, height: 2)
                            
                            RoundedRectangle(cornerRadius: 3)
                                .fill(.white)
                                .frame(width: 20, height: 2)
                            
                            RoundedRectangle(cornerRadius: 3)
                                .fill(.white)
                                .frame(width: 20, height: 2)
                            
                        }
                        .padding(.trailing, 6)
                    })
                    
                    Text("Workers")
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .bold))
                    
                    Spacer()
                    
                    Button(action: {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddWorker = true
                        }
                        
                    }, label: {
                        
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .semibold))
                            .padding(8)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                    })
                }
                .padding(.bottom)
                
                if viewModel.workers.isEmpty {
                    
                    VStack(spacing: 12) {
                        
                        VStack(alignment: .center, spacing: 10, content: {
                            
                            Text("Empty")
                                .foregroundColor(Color("primary"))
                                .font(.system(size: 21, weight: .semibold))
                            
                            Text("You don't have any workers added to the page yet")
                                .foregroundColor(.gray)
                                .font(.system(size: 13, weight: .regular))
                        })
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddWorker = true
                            }
                            
                        }, label: {
                            
                            Text("Add a worker")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .regular))
                                .frame(maxWidth: .infinity)
                                .frame(height: 50)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                            
                        })
                        .padding(.top, 25)
                        
                    }
                    .frame(maxHeight: .infinity, alignment: .center)
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                            
                            ForEach(viewModel.workers, id: \.self) { index in
                                
                                VStack(spacing: 10) {
                                    
                                    Image(systemName: "photo")
                                        .foregroundColor(.white)
                                        .font(.system(size: 20, weight: .regular))
                                        .background(Circle().fill(.white.opacity(0.2)).frame(width: 50, height: 50))
                                        .padding()
                                    
                                    Text(index)
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .bold))
                                        .padding(.bottom)
                                    
                                    Text("Salary")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 14, weight: .regular))
                                    
                                    Text("$\(String(format: "%.f", Double(.random(in: 1300...4000))))")
                                        .foregroundColor(Color("primary"))
                                        .font(.system(size: 22, weight: .semibold))
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg3")))
                            }
                        })
                    }
                }
                
            }
            .padding()
        }
        .overlay (
            
            ZStack {
                
                Color.black.opacity(viewModel.isAddWorker ? 0.7 : 0)
                    .ignoresSafeArea()
                    .onTapGesture{
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddWorker = false
                        }
                    }
                
                VStack {
                    
                    HStack {
                        
                        Text("New worker")
                            .foregroundColor(Color("primary"))
                            .font(.system(size: 16, weight: .semibold))
                        
                        Spacer()
                        
                        Button(action: {
                            
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAddWorker = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.white.opacity(0.1))
                                .font(.system(size: 20, weight: .medium))
                            
                        })
                        
                    }
                    
                    HStack {
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Name")
                                .foregroundColor(viewModel.workersName.isEmpty ? .gray : .white)
                                .font(.system(size: 13, weight: .medium))
                                .opacity(viewModel.workersName.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.workersName)
                                .foregroundColor(.white)
                                .font(.system(size: 13, weight: .medium))
                                .keyboardType(.decimalPad)
                        })
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.white))
                    .padding(.bottom)
                    .padding(.top, 50)
                    
                    Button(action: {
                        
                        viewModel.workers.append(viewModel.workersName)
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isAddWorker = false
                        }
                        
                    }, label: {
                        
                        Text("Add")
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .semibold))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                        
                    })
                    .padding(.top, 25)
                    .opacity(viewModel.workersName.isEmpty ? 0.5 : 1)
                    .disabled(viewModel.workersName.isEmpty ? true : false)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg3")).ignoresSafeArea())
                .offset(y: viewModel.isAddWorker ? 0 : UIScreen.main.bounds.height)
                .frame(maxHeight: .infinity, alignment: .bottom)
                
            }
        )
    }
}

#Preview {
    WorkersView(show: .constant(true))
}

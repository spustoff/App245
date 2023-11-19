//
//  MainView.swift
//  App245
//
//  Created by IGOR on 13/11/2023.
//

import SwiftUI

struct MainView: View {
    
    @Binding var show: Bool
    
    @StateObject var viewModel = MainViewModel()

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
                    
                    Text("Menu")
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .bold))
                    
                    Spacer()
                }
                .padding(.bottom)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    LazyHStack {
                        
                        ForEach(viewModel.types, id: \.self) { index in
                            
                            Button(action: {
                                
                                viewModel.current_type = index
                                
                            }, label: {
                                
                                VStack {
                                    
                                    Text(index)
                                        .foregroundColor(viewModel.current_type == index ? .black : .white)
                                        .font(.system(size: 14, weight: .bold))
                                }
                                .padding(9)
                                .padding(.horizontal)
                                .background(RoundedRectangle(cornerRadius: 14).fill(viewModel.current_type == index ? Color("primary") : .white.opacity(0.1)))
                            })
                        }
                    }
                }
                .frame(height: 40)
                
                if viewModel.objects.isEmpty {
                    
                    VStack(alignment: .center, spacing: 10, content: {
                        
                        Text("Empty")
                            .foregroundColor(Color("primary"))
                            .font(.system(size: 21, weight: .semibold))
                        
                        Text("At this stage you do not have any objects yet")
                            .foregroundColor(.gray)
                            .font(.system(size: 13, weight: .regular))
                    })
                    .frame(maxHeight: .infinity, alignment: .center)
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], content: {
                            
                            ForEach(viewModel.objects, id: \.self) { index in
                            
                                Button(action: {
                                    
                                    viewModel.isDetail = true
                                    viewModel.selectedObject = index
                                    
                                }, label: {
                                    
                                    VStack {
                                        
                                        Image("img")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                        
                                        VStack(alignment: .leading, spacing: 10, content: {
                                            
                                            Text("All")
                                                .foregroundColor(.black)
                                                .font(.system(size: 13, weight: .medium))
                                                .padding(7)
                                                .background(RoundedRectangle(cornerRadius: 5).fill(Color("primary")))
                                            
                                            Text(index.address ?? "")
                                                .foregroundColor(.gray)
                                                .font(.system(size: 13, weight: .regular))
                                                .multilineTextAlignment(.leading)
                                        })
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    }
                                })
                            }
                        })
                    }
                }
                
                Button(action: {
                    
                    viewModel.isAdd = true
                    
                }, label: {
                    
                    Text("Add Object")
                        .foregroundColor(.black)
                        .font(.system(size: 15, weight: .regular))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                })
            }
            .padding()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            MainAdd(viewModel: viewModel)
        })
        .sheet(isPresented: $viewModel.isDetail, content: {
            
            MainDetail(viewModel: viewModel)
        })
        .onAppear {
            
            viewModel.fetchObjects()
        }
    }
}

#Preview {
    MainView(show: .constant(true))
}

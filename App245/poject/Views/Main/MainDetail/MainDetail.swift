//
//  MainDetail.swift
//  App245
//
//  Created by IGOR on 18/11/2023.
//

import SwiftUI

struct MainDetail: View {
    
    @State var isChart: Bool = false
    
    @Environment(\.presentationMode) var router
    
    @StateObject var viewModel: MainViewModel
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Button(action: {
                        
                        router.wrappedValue.dismiss()
                        
                    }, label: {
                        
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .medium))
                            .padding(14)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                    })
                    
                    Spacer()
                }
                .padding()
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    LazyVStack {
                        
                        Image("img")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                        VStack(alignment: .leading, spacing: 10, content: {
                            
                            Text("All")
                                .foregroundColor(.black)
                                .font(.system(size: 13, weight: .medium))
                                .padding(7)
                                .background(RoundedRectangle(cornerRadius: 5).fill(Color("primary")))
                            
                            Text(viewModel.selectedObject?.address ?? "")
                                .foregroundColor(.gray)
                                .font(.system(size: 13, weight: .regular))
                                .multilineTextAlignment(.leading)
                            
                            Text("$\(viewModel.selectedObject?.cost ?? 0)")
                                .foregroundColor(.white)
                                .font(.system(size: 25, weight: .bold))
                            
                            HStack {
                                
                                Text("EUR/USD")
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .medium))
                                
                                Spacer()
                                
                                Button(action: {
                                    
                                    isChart = true
                                    
                                }, label: {
                                    
                                    Text("Edit")
                                        .foregroundColor(.white)
                                        .font(.system(size: 13, weight: .medium))
                                        .padding(8)
                                        .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                                })
                            }
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(.gray.opacity(0.1)))
                            
                            VStack(alignment: .center, spacing: 10, content: {
                                
                                Text("Empty")
                                    .foregroundColor(Color("primary"))
                                    .font(.system(size: 21, weight: .semibold))
                                
                                Text("At this stage you do not have any expenses yet")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 13, weight: .regular))
                            })
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(.vertical, 80)
                        })
                        .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .padding()
                }
            }
        }
        .sheet(isPresented: $isChart, content: {
            
            MainChart()
        })
    }
}

#Preview {
    MainDetail(viewModel: MainViewModel())
}

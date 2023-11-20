//
//  MainChart.swift
//  App245
//
//  Created by IGOR on 18/11/2023.
//

import SwiftUI

struct MainChart: View {
    
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Text("EUR/USD")
                        .foregroundColor(Color("primary"))
                        .font(.system(size: 19, weight: .semibold))
                    
                    Spacer()
                    
                    Button(action: {
                        
                        UIApplication.shared.endEditing()
                        
                        router.wrappedValue.dismiss()
                        
                    }, label: {
                        
                        Image(systemName: "xmark")
                            .foregroundColor(.gray)
                            .font(.system(size: 16, weight: .bold))
                    })
                }
                .padding()
                .padding(.top)
                
                HStack(alignment: .bottom) {
                    
                    Text("\(Int.random(in: 1...25555))")
                        .foregroundColor(.white)
                        .font(.system(size: 23, weight: .bold))
                    
                    Text("+\(Int.random(in: 1...10))%")
                        .foregroundColor(.green)
                        .font(.system(size: 13, weight: .regular))
                
                    Spacer()
                }
                .padding()
                
                TradeChart(pair: "EURUSD")
                    .disabled(true)
                
                HStack {
                    
                    Button(action: {
                        
                        UIApplication.shared.endEditing()
                        
                        router.wrappedValue.dismiss()
                        
                    }, label: {
                        
                        Text("Apply")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.green))
                    })
                    
                    Button(action: {
                        
                        UIApplication.shared.endEditing()
                        
                        router.wrappedValue.dismiss()
                        
                    }, label: {
                        
                        Text("Back")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 10).fill(.red))
                    })
                }
                .padding()
            }
        }
    }
}

#Preview {
    MainChart()
}


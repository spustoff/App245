//
//  Re_1.swift
//  App245
//
//  Created by IGOR on 13/11/2023.
//

import SwiftUI

struct Re_1: View {
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            Image("re_1")
                .resizable()
                .frame(maxHeight: .infinity, alignment: .top)
                .ignoresSafeArea()
            
            VStack {
                
                VStack(alignment: .center, spacing: 7, content: {
                    
                    Text("All your objects")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .semibold))
                        .multilineTextAlignment(.center)
                    
                    Text("Convenient filtering of projects for control")
                        .foregroundColor(.gray)
                        .font(.system(size: 15, weight: .regular))
                        .multilineTextAlignment(.center)
                })
                .padding()
                .padding(.bottom, 50)
                
                NavigationLink(destination: {
                    
                    Re_2()
                        .navigationBarBackButtonHidden()
                    
                }, label: {
                    
                    Text("Continue")
                        .foregroundColor(.black)
                        .font(.system(size: 16, weight: .regular))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                })
            }
            .padding()
            .background(Color("bg").ignoresSafeArea())
            .frame(maxHeight: .infinity, alignment: .bottom)
        }
    }
}

#Preview {
    Re_1()
}

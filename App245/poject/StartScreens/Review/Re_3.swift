//
//  Re_3.swift
//  App245
//
//  Created by IGOR on 13/11/2023.
//

import SwiftUI

struct Re_3: View {
    
    @AppStorage("status") var status: Bool = false
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            Image("re_3")
                .resizable()
                .frame(maxHeight: .infinity, alignment: .top)
                .ignoresSafeArea()
            
            VStack {
                
                VStack(alignment: .center, spacing: 7, content: {
                    
                    Text("Your profitability")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .semibold))
                        .multilineTextAlignment(.center)
                    
                    Text("Control your finances")
                        .foregroundColor(.gray)
                        .font(.system(size: 15, weight: .regular))
                        .multilineTextAlignment(.center)
                })
                .padding()
                .padding(.bottom, 50)
                
                Button(action: {
                    
                    status = true
                    
                }, label: {
                    
                    Text("Finish")
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
    Re_3()
}

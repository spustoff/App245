//
//  FinanceView.swift
//  App245
//
//  Created by IGOR on 13/11/2023.
//

import SwiftUI

struct FinanceView: View {
    
    @Binding var show: Bool
    
    @StateObject var viewModel = FinanceViewModel()
    @Environment(\.presentationMode) var router
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Button(action: {
                        
                        UIApplication.shared.endEditing()
                        
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
                    
                    Text("Finance")
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .bold))
                    
                    Spacer()
                    
                    Button(action: {
                        
                        UIApplication.shared.endEditing()
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isNewEarning = true
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
                
                ScrollView(.horizontal, showsIndicators: false) {
                    
                    LazyHStack {
                        
                        ForEach(viewModel.months, id: \.self) { index in
                            
                            Button(action: {
                                
                                UIApplication.shared.endEditing()
                                
                                viewModel.current_month = index
                                
                            }, label: {
                                
                                VStack {
                                    
                                    Text("2023")
                                        .foregroundColor(.white)
                                        .font(.system(size: 13, weight: .regular))
                                    
                                    Text(index)
                                        .foregroundColor(viewModel.current_month == index ? Color("primary") : .gray)
                                        .font(.system(size: 18, weight: .semibold))
                                }
                            })
                            .frame(width: 100, height: 50)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg3")))
                            .background(RoundedRectangle(cornerRadius: 10).stroke(Color("primary").opacity(viewModel.current_month == index ? 1 : 0), lineWidth: 3))
                        }
                    }
                }
                .frame(height: 55)
                .padding(.bottom)
                
                if viewModel.earnings.isEmpty {
                    
                    VStack(alignment: .center, spacing: 10, content: {
                        
                        Text("Empty")
                            .foregroundColor(Color("primary"))
                            .font(.system(size: 21, weight: .semibold))
                        
                        Text("You don't have any earnings added to the page yet")
                            .foregroundColor(.gray)
                            .font(.system(size: 13, weight: .regular))
                    })
                    .frame(maxHeight: .infinity, alignment: .center)
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.earnings,  id: \.self) { index in
                                
                                HStack {
                                    
                                    Text(index)
                                        .foregroundColor(.white)
                                        .font(.system(size: 16, weight: .regular))
                                }
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg3")))
                                
                            }
                        }
                    }
                }
            }
            .padding()
        }
        .overlay (
            
            ZStack {
                
                Color.black.opacity(viewModel.isNewEarning ? 0.7 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        viewModel.isNewEarning = false
                    }
                
                VStack {
                    
                    HStack {
                        
                        Text("New earning")
                            .foregroundColor(Color("primary"))
                            .font(.system(size: 22, weight: .semibold))
                        
                        Spacer()
                        
                        Button(action: {
                            
                            UIApplication.shared.endEditing()
                            
                            router.wrappedValue.dismiss()
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.gray)
                                .font(.system(size: 20, weight: .medium))
                        })
                    }
                    .padding(.bottom)
                    
                    Text("Sum")
                        .foregroundColor(.white)
                        .font(.system(size: 16, weight: .regular))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    HStack {
                        
                        ZStack(alignment: .leading, content: {
                            
                            Text("Enter")
                                .foregroundColor(viewModel.earningSum.isEmpty ? .gray : .white)
                                .font(.system(size: 13, weight: .medium))
                                .opacity(viewModel.earningSum.isEmpty ? 1 : 0)
                            
                            TextField("", text: $viewModel.earningSum)
                                .foregroundColor(.white)
                                .font(.system(size: 13, weight: .medium))
                                .keyboardType(.decimalPad)
                        })
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                    
                    HStack {
                        
                        Text("Date of earning")
                            .foregroundColor(.white)
                            .font(.system(size: 16, weight: .regular))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Spacer()
                        
                        DatePicker("Date of earning", selection: $viewModel.earningDate, in: Date()..., displayedComponents: .date)
                            .labelsHidden()
                        
                    }
                    .padding(.vertical)
                    
                    Button(action: {
                        
                        UIApplication.shared.endEditing()
                        
                        viewModel.earnings.append("$\(viewModel.earningDate)             \(viewModel.earningSum)")
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isNewEarning = false
                        }
                        
                        viewModel.earningSum = ""
                        
                    }, label: {
                        
                        Text("Add")
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .medium))
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                            .padding(.top, 25)
                        
                    })
                    .opacity(viewModel.earningSum.isEmpty ? 0.5 : 1)
                    .disabled(viewModel.earningSum.isEmpty ? true : false)
                    //                    .opacity(viewModel.cur_curr.isEmpty || viewModel.selectedPortfolioForAdd.isEmpty ? 0.5 : 1)
                    //                    .disabled(viewModel.cur_curr.isEmpty || viewModel.selectedPortfolioForAdd.isEmpty ? true : false)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg3")).ignoresSafeArea())
                .offset(y: viewModel.isNewEarning ? 0 : UIScreen.main.bounds.height)
                .frame(maxHeight: .infinity, alignment: .bottom)
                
            }
        )
    }
}

#Preview {
    FinanceView(show: .constant(true))
}

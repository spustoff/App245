//
//  AddTaskView.swift
//  App245
//
//  Created by IGOR on 14/11/2023.
//

import SwiftUI

struct AddTaskView: View {
    
    @StateObject var viewModel: TasksViewModel
    @Environment(\.presentationMode) var router
    
    var body: some View {

        ZStack {
            
            Color("bg")
                .ignoresSafeArea()
            
            VStack {
                
                HStack {
                    
                    Text("New task")
                        .foregroundColor(Color("primary"))
                        .font(.system(size: 18, weight: .bold))
                    
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
                
                Text("Worker")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Menu {
                    
                    ForEach(viewModel.workers, id: \.self) { index in
                        
                        Button(action: {
                            
                            UIApplication.shared.endEditing()
                            
                            viewModel.selectedWorker = index
                            
                        }, label: {
                            
                            HStack {
                                
                                Text(index)
                                
                                Spacer()
                                
                                if viewModel.selectedWorker == index {
                                    
                                    Image(systemName: "xmark")
                                }
                            }
                        })
                    }
                    
                } label: {
                    
                    HStack {
                        
                        if viewModel.selectedWorker.isEmpty{
                            
                            Text("Choose")
                                .foregroundColor(.gray)
                                .font(.system(size: 15, weight: .regular))
                        } else {
                            
                            Text(viewModel.selectedWorker)
                                .foregroundColor(.gray)
                                .font(.system(size: 15, weight: .regular))
                        }
                        
                        Spacer()

                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 15).stroke(.gray))
                }
                .padding(.bottom)
                
                Text("Description")
                    .foregroundColor(.white)
                    .font(.system(size: 16, weight: .regular))
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    
                    ZStack(alignment: .leading, content: {
                        
                        Text("Enter")
                            .foregroundColor(viewModel.taskDescription.isEmpty ? .gray : .white)
                            .font(.system(size: 13, weight: .medium))
                            .opacity(viewModel.taskDescription.isEmpty ? 1 : 0)
                        
                        TextField("", text: $viewModel.taskDescription)
                            .foregroundColor(.white)
                            .font(.system(size: 13, weight: .medium))
                            .keyboardType(.decimalPad)
                    })
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 10).stroke(Color.gray))
                
                Button(action: {
                    
                    UIApplication.shared.endEditing()
                    
                    viewModel.addTasks {
                        
                        viewModel.selectedWorker = ""
                        viewModel.taskDescription = ""
                        viewModel.fetchTasks()
                        
                        router.wrappedValue.dismiss()
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
                .opacity(viewModel.taskDescription.isEmpty || viewModel.selectedWorker.isEmpty ? 0.5 : 1)
                .disabled(viewModel.taskDescription.isEmpty || viewModel.selectedWorker.isEmpty ? true : false)
                
                Spacer()
            }
            .padding()
        }
    }
}

#Preview {
    AddTaskView(viewModel: TasksViewModel())
}

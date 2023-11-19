//
//  TasksView.swift
//  App245
//
//  Created by IGOR on 13/11/2023.
//

import SwiftUI

struct TasksView: View {
    
    @Binding var show: Bool

    @StateObject var viewModel = TasksViewModel()
    
    @Environment(\.presentationMode) var router
    
    let taskWorker: String
    
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
                    
                    Text("Tasks")
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .bold))
                    
                    Spacer()
                    
                    NavigationLink(destination: {
                        
                        AddTaskView(viewModel: viewModel)
                            .navigationBarBackButtonHidden()
                        
                    }, label: {
                        
                        Image(systemName: "plus")
                            .foregroundColor(.black)
                            .font(.system(size: 16, weight: .semibold))
                            .padding(8)
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color("primary")))
                    })
                }
                .padding(.bottom)
                
                if viewModel.tasks.isEmpty {
                    
                    VStack(spacing: 9) {
                        
                        Text("Empty")
                            .foregroundColor(Color("primary"))
                            .font(.system(size: 20, weight: .semibold))
                        
                        Text("You don't have any tasks created yet")
                            .foregroundColor(.gray)
                            .font(.system(size: 16, weight: .regular))
                    }
                    .frame(maxHeight: .infinity, alignment: .center)
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.tasks, id: \.self) {index in
                                
                                VStack(alignment: .leading, spacing: 5, content: {
                                    
                                    Text(index.taskWorker ?? "")
                                        .foregroundColor(.white)
                                        .font(.system(size: 18, weight: .medium))
                                    
                                    Text(index.taskDescription ?? "")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 16, weight: .regular))
                                    
                                })
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(RoundedRectangle(cornerRadius: 10).fill(Color("bg3")))
                                .padding(.bottom, 5)
                            }
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .onAppear{
            
            viewModel.fetchTasks()
        }
    }
}

#Preview {
    TasksView(show: .constant(true), taskWorker: "vefrd")
}

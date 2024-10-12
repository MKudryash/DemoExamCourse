//
//  NewPasswordView.swift
//  DemoExamCourse
//
//  Created by user on 12.10.2024.
//

import SwiftUI

struct NewPasswordView: View {
    
    @State var password = ""
    @State var passwordConfirm = ""
    @StateObject var viewModel = NewPasswordViewModel()
    @State var isShowAlert = false
    @State var isSecure = true
    @State var isSecureConfirm = true
    var body: some View {
        NavigationView{
            ZStack{
                Color.white.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                    VStack(alignment: .leading, content: {
                        Text("New Password")
                            .font(.custom("Roboto-Medium", size:24))
                        Text("Enter new password")
                            .font(.custom("Roboto-Medium", size: 14))
                            .padding(.bottom,50)
                            .padding(.top,2)
                            .foregroundColor(.gray)
                        
                        
                        Text("Password")
                            .font(.custom("Roboto-Medium", size:14))
                            .foregroundStyle(Color.gray)
                        CustomSecuredField(password: $password)
                        
                        
                        Text("Confirm Password")
                            .font(.custom("Roboto-Medium", size:14))
                            .foregroundStyle(Color.gray)
                        CustomSecuredField(password: $passwordConfirm)
                    })
                    
                    
                    NavigationLink(destination: HomeView(),  isActive: $viewModel.isNavigate){
                        EmptyView()
                    }
                    
                    Button(action: {
                        if (password == passwordConfirm){
                            viewModel.sendEmailOtp(password: password)
                        }
                        else {
                            isShowAlert.toggle()
                        }
                    })
                    {
                        Text("Log in")
                            .font(.custom("Roboto-Bold", size:16))
                    }
                    .frame(width: 350,height: 50)
                    .background(password.count>0 && passwordConfirm.count>0 ? .blue : .gray)
                    .foregroundColor(Color.white)
                    .cornerRadius(5)
                    .padding(.top,40)
                    .alert(isPresented: $isShowAlert) {
                        Alert(title: Text("Ошибка"),
                              message: Text("Пароли не совпадают"),
                              dismissButton: .default(Text("OK")))
                    }
                    .font(.custom("Roboto-Regular", size:14))
                    .padding(.top,10)
                }
                .padding(.horizontal,10)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onReceive(CheckConnectNetwork.instance.$isConnected) { value in
            if !value {
                isConnectNetwork = true
            }
        }
    }
}

#Preview {
    NewPasswordView()
}

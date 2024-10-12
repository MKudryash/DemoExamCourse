//
//  ForgotPasswordView.swift
//  DemoExamCourse
//
//  Created by user on 12.10.2024.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @State private var isShowingDetailView = false
    @State var isShowAlert = false
    @State var email: String = ""
    @StateObject var viewModel = ForgotPasswordViewModel()
    @State var isNavigate: Bool = false
    @State var isConnectNetwork = false
    var body: some View {
        NavigationView{
            ZStack{
                Color.white.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                    VStack(alignment: .leading, content: {
                        Text("Forgot Password")
                            .font(.custom("Roboto-Medium", size:24))
                        Text("Enter your email address")
                            .font(.custom("Roboto-Medium", size: 14))
                            .padding(.bottom,15)
                            .padding(.top,2)
                            .foregroundColor(.gray)
                        
                        Text("Email Address")
                            .font(.custom("Roboto-Medium", size:14))
                            .foregroundStyle(Color.gray)
                        CustomTextField(placeholder: "*****@mail.ru", text: $email)
                    })
                    
                    
                    NavigationLink(destination: OTPVerificationView(email:email),  isActive: $viewModel.isNavigate){
                        EmptyView()
                    }
                    NavigationLink(destination: SignInView(),  isActive: $isNavigate){
                        EmptyView()
                    }
                    
                    
                    Button(action: {
                        if ( isValidEmail(email) ){
                            viewModel.sendEmailOtp(email: email)
                            isShowingDetailView.toggle()
                        }
                        else {
                            isShowAlert.toggle()
                        }
                    })
                    {
                        Text("Send OTP")
                            .font(.custom("Roboto-Bold", size:16))
                    }
                    .frame(width: 350,height: 50)
                    .background(isValidEmail(email) ? .blue : .gray)
                    .foregroundColor(Color.white)
                    .cornerRadius(5)
                    .padding(.top,40)
                    .alert(isPresented: $isShowAlert) {
                        Alert(title: Text("Ошибка"),
                              message: Text("Не все поля заполнены"),
                              dismissButton: .default(Text("OK")))
                    }
                    
                    
                    Group{
                        Text("Remember password? Back to")
                            .foregroundStyle(.gray)
                        + Text(" Sign In")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(.blue)
                        
                    }
                    .onTapGesture {
                        isNavigate.toggle()
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
    ForgotPasswordView()
}

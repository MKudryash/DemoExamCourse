//
//  SignUpView.swift
//  DemoExamCourse
//  Экран регистрации пользователя в системе (имя пользователя, телефон, почта, пароль, соглашение с политикой безопасности)
//  Created by Mamsheva on 12.10.2024.
//

import SwiftUI

struct SignUpView: View {

    @State var check:Bool = false
    @State var flag:Bool = false
    @State private var isShowingDetailView = false
    @State private var isNavigate = false
    @State private var isSecure = false
    @State private var isSecureConfirm = false
    @State var isShowAlert = false
    @State var isConnectNetwork = false
    @State var changeButtonColor = Color.gray
    
    @StateObject var viewModel = SignUpViewModel()
    var body: some View {

        NavigationView{
            ZStack{
                Color.white.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                    VStack(alignment: .leading, content: {
                        
                        Text("Create an account")
                            .font(.custom("Roboto-Medium", size:24))
                        Text("Complete the sign up process to get started")
                            .font(.custom("Roboto-Medium", size: 14))
                            .padding(.bottom,15)
                            .padding(.top,2)
                            .foregroundColor(.gray)
                        
                        
                        Text("Full name")
                            .font(.custom("Roboto-Medium", size:14))
                            .foregroundStyle(Color.gray)
                        CustomTextField(placeholder: "Ivan Ivanov", text: $viewModel.username)
                        
                        
                        Text("Phone nubmer")
                            .font(.custom("Roboto-Medium", size:14))
                            .foregroundStyle(Color.gray)
                        CustomTextField(placeholder: "+7(999)999-99-99", text: $viewModel.phone)
                        
                        
                        Text("Email Address")
                            .font(.custom("Roboto-Medium", size:14))
                            .foregroundStyle(Color.gray)
                        CustomTextField(placeholder: "*****@mail.ru", text: $viewModel.email)
                        
                        
                        Text("Password")
                            .font(.custom("Roboto-Medium", size:14))
                            .foregroundStyle(Color.gray)
                        CustomSecuredField(password: $viewModel.password)
                        
                        
                        Text("Confirm Password")
                            .font(.custom("Roboto-Medium", size:14))
                            .foregroundStyle(Color.gray)
                        CustomSecuredField(password: $viewModel.confirmPassword)
                        
                        
                        HStack(alignment: .center){
                            CustomCheckBox(value: $check)
                            Group()
                            {
                                Text("By ticking this box, you agree to our ")
                                    .foregroundStyle(.gray)
                                + Text("Terms and conditions and private policy")
                                    .foregroundStyle(.yellow)
                                
                            }
                            .font(.custom("Roboto-Regular", size:14))
                            .multilineTextAlignment(.center)
                        }
                        .padding(.horizontal,20)
                    })
                    .alert(isPresented: $viewModel.error) {
                        Alert(title: Text("Ошибка"),
                              message: Text("Неверно введены данные"),
                              dismissButton: .default(Text("OK")))
                    }
                    
                    
                    NavigationLink(destination: SignInView(),  isActive: $viewModel.isNavigate){
                    }
                    
                    NavigationLink(destination: SignInView(),  isActive: $isNavigate){
                    }
                    
                    
                        Button(action: {
                            if(viewModel.username != "" && viewModel.phone != "" && isValidEmail(viewModel.email) && viewModel.password==viewModel.confirmPassword &&
                                check==true){
                                viewModel.signUp()
                            }
                            else {
                                isShowAlert.toggle()
                            }
                        })
                    {
                        Text("Sign Up")
                            .font(.custom("Roboto-Bold", size:16))
                    }
                        .frame(width: 350,height: 50)
                        .background(viewModel.username != "" && viewModel.phone != "" && isValidEmail(viewModel.email) && viewModel.password==viewModel.confirmPassword &&
                                    check==true ? .blue : .gray)
                        .foregroundColor(Color.white)
                        .cornerRadius(5)
                        .padding(.top,40)
                        .alert(isPresented: $isShowAlert) {
                            Alert(title: Text("Ошибка"),
                                  message: Text("Не все поля верно заполнены"),
                                  dismissButton: .default(Text("OK")))
                        }
                            
                    Group{
                        Text("Already have an account?")
                            .foregroundStyle(.gray)
                        + Text(" Sign in")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(.blue)
                    }
                    .font(.custom("Roboto-Regular", size:14))
                    .padding(.top,10)
                    .onTapGesture {
                        isNavigate.toggle()
                    }
                    Text("or sign in using")
                        .multilineTextAlignment(.center)
                        .padding(.top,5)
                        .foregroundColor(.gray)
                        .font(.custom("Roboto-Regular", size:14))
                    
                    Image(.iconGoogle)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
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
    SignUpView()
}



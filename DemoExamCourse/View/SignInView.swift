//
//  SigInView.swift
//  DemoExamCourse
//
//  Created by user on 12.10.2024.
//

import SwiftUI

struct SignInView: View {
    @AppStorage("email") var email: String = ""
    @AppStorage("password") var password: String = ""
    @State var isShowAlert = false
    @State var isNavigate: Bool = false
    @State var isNavigateSignUp: Bool = false
    @State var isSecure: Bool = false
    @State var check = false
    @StateObject var viewModel = SignInViewModel()
    @State private var buttonColor: Color = .gray
    var body: some View {
        
        NavigationView{
            ZStack{
                Color.white.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                    VStack(alignment: .leading, content: {
                        Text("Welcome Back")
                            .font(.custom("Roboto-Medium", size:24))
                        Text("Fill in your email and password to continue")
                            .font(.custom("Roboto-Medium", size: 14))
                            .padding(.bottom,15)
                            .padding(.top,2)
                            .foregroundColor(.gray)
                        
                        Text("Email Address")
                            .font(.custom("Roboto-Medium", size:14))
                            .foregroundStyle(Color.gray)
                        CustomTextField(placeholder: "*****@email.ru", text: $email)
                        
                        Text("Password")
                            .font(.custom("Roboto-Medium", size:14))
                            .foregroundStyle(Color.gray)
                        CustomSecuredField(password: $password)
                        
                        
                        HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/,spacing: 110){
                            HStack{
                                CustomCheckBox(value: $check)
                                Text("Remember password")
                                    .font(.custom("Roboto-Regular", size:12))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.gray)
                            }
                            Group()
                            {
                                
                                Text("Forgot Password?")
                                    .foregroundStyle(.blue)
                                    .multilineTextAlignment(.leading)
                                    .font(.custom("Roboto-Regular", size:12))
                                    .fontWeight(.bold)
                                    .onTapGesture (count:1){
                                        isNavigate.toggle()
                                    }
                            }
                            .padding(.leading)
                        }
                        .frame(width: .infinity)
                        
                    })
                    .alert(isPresented: $viewModel.error) {
                        Alert(title: Text("Ошибка"),
                              message: Text("Не верно введены данные или отсутствует интернет!"),
                              dismissButton: .default(Text("OK")))
                    }
                    
                    
                    NavigationLink(destination: HomeView(),  isActive: $viewModel.isNavigate){
                        EmptyView()
                    }
                    NavigationLink(destination: ForgotPasswordView(),  isActive: $isNavigate){
                        EmptyView()
                    }
                    NavigationLink(destination: SignUpView(),  isActive: $isNavigateSignUp){
                        EmptyView()
                    }
                    
                    Button(action: {
                        if ( isValidEmail(email) && password != ""
                             && check == true){
                            viewModel.signIn(email:email,password:password)
                        }
                        else {
                            isShowAlert.toggle()
                        }
                    })
                    {
                        Text("Sign In")
                            .font(.custom("Roboto-Bold", size:16))
                    }
                    .frame(width: 350,height: 50)
                    .background(isValidEmail(email) && password != "" && check == true ? .blue : .gray)
                    .foregroundColor(Color.white)
                    .cornerRadius(5)
                    .padding(.top,40)
                    .alert(isPresented: $isShowAlert) {
                        Alert(title: Text("Ошибка"),
                              message: Text("Не все поля заполнены"),
                              dismissButton: .default(Text("OK")))
                    }
                    
                    Group{
                        Text("Already have an account?")
                            .foregroundStyle(.gray)
                        + Text(" Sign Up")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundStyle(.blue)
                    }
                    .font(.custom("Roboto-Regular", size:14))
                    .padding(.top,10)
                    .onTapGesture {
                        isNavigateSignUp.toggle()
                    }
                    
                    Text("or log in using")
                        .multilineTextAlignment(.center)
                        .padding(.top,10)
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
    }
}

#Preview {
    SignInView()
}


//
//  OTPVerificationView.swift
//  DemoExamCourse
//
//  Created by user on 12.10.2024.
//

import SwiftUI

struct OTPVerificationView: View {
    var email:String
    
    @FocusState var isFocusedSecond: Bool
    @FocusState var isFocusedThird: Bool
    @FocusState var isFocusedFourth: Bool
    @FocusState var isFocusedFifth: Bool
    @FocusState var isFocusedSixth: Bool
    
    @State private var token: [String] = Array(repeating: "", count: 6)
    
    @State var isShowAlert = false
    @StateObject var viewModel = OTPVerificationViewModel()
    @State private var isButtonDisabled: Bool = true
    
    @State var timeRemaining = 59
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @FocusState var test:Bool
    var body: some View {
        NavigationView{
            ZStack{
                Color.white.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
                    VStack(alignment: .leading, content: {
                        
                        Text("OTP Verification")
                            .font(.custom("Roboto-Medium", size:24))
                        Text("Enter the 6 digit numbers sent to your email")
                            .font(.custom("Roboto-Medium", size: 14))
                            .padding(.bottom,15)
                            .padding(.top,2)
                            .foregroundColor(.gray)
                        HStack (alignment: .center,spacing: 20, content: {
                            
                            CustomBoxNumber(text: $token[0], error: $viewModel.error)
                                .onChange(of:token[0]){
                                    if(token[0].count==1)
                                    {
                                        isFocusedSecond.toggle()
                                    }
                                }
                            CustomBoxNumber(text: $token[1], error: $viewModel.error)
                                .onChange(of:token[1]){
                                    if(token[1].count==1)
                                    {
                                        isFocusedThird.toggle()
                                    }
                                }
                                .focused($isFocusedSecond)
                            CustomBoxNumber(text: $token[2], error: $viewModel.error)
                                .onChange(of:token[2]){
                                    if(token[2].count==1)
                                    {
                                        isFocusedFourth.toggle()
                                    }
                                }
                                .focused($isFocusedThird)
                            CustomBoxNumber(text: $token[3], error: $viewModel.error)
                                .onChange(of:token[3]){
                                    if(token[3].count==1)
                                    {
                                        isFocusedFifth.toggle()
                                    }
                                }
                                .focused($isFocusedFourth)
                            CustomBoxNumber(text: $token[4], error: $viewModel.error)
                                .onChange(of:token[4]){
                                    if(token[4].count==1)
                                    {
                                        isFocusedSixth.toggle()
                                    }
                                }
                                .focused($isFocusedFifth)
                            CustomBoxNumber(text: $token[5], error: $viewModel.error)
                                .focused($isFocusedSixth)
                        })
                    })
                    
                    NavigationLink(destination: NewPasswordView(),  isActive: $viewModel.isNavigate){
                        EmptyView()
                    }
                    HStack{
                        Text("If you didn't receive code, resent after")
                            .font(.custom("Roboto-Regular", size: 14))
                            .padding(.bottom,15)
                            .padding(.top,10)
                            .foregroundColor(.gray)
                        if(timeRemaining>0)
                        {Text("0:\(timeRemaining)")
                                .onReceive(timer) { _ in
                                    if timeRemaining > 0 {
                                        timeRemaining -= 1
                                    }
                                }
                                .font(.custom("Roboto-Regular", size: 14))
                                .padding(.bottom,15)
                                .padding(.top,10)
                                .foregroundColor(.gray)
                        }else
                        {
                            Text("resend")
                                .font(.custom("Roboto-Regular", size: 14))
                                .padding(.bottom,15)
                                .padding(.top,10)
                                .foregroundColor(.blue)
                                .onTapGesture {
                                    timeRemaining = 59
                                    viewModel.sendEmailOtp(email: email)
                                }
                        }
                    }
                    
                    Button(action: {
                        viewModel.sentOtp(email:email,code: token.joined())
                        token = Array(repeating: "", count: 6)
                    })
                    {
                        Text("Send New Password")
                            .font(.custom("Roboto-Bold", size:16))
                    }
                    .frame(width: 350,height: 50)
                    .background(isButtonDisabled ? .gray : .blue)
                    .foregroundColor(Color.white)
                    .cornerRadius(5)
                    .padding(.top,40)
                    .alert(isPresented: $isShowAlert) {
                        Alert(title: Text("Ошибка"),
                              message: Text("Не все поля заполнены"),
                              dismissButton: .default(Text("OK")))
                    }
                }
                .padding(.horizontal,10)
                .onChange(of: token) { value in
                    let disabled = value.reduce(false) { partialResult, item in
                        return partialResult ? true : item.isEmpty
                    }
                    
                    self.isButtonDisabled = disabled
                    isShowAlert = !disabled
                }
                .alert(isPresented: $viewModel.error) {
                    Alert(title: Text("Ошибка"),
                          message: Text("Неверный код"),
                          dismissButton: .default(Text("OK")))
                    
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    OTPVerificationView(email:"")
}

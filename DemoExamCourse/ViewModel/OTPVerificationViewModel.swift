//
//  OTPVerificationViewModel.swift
//  DemoExamCourse
//
//  Created by user on 12.10.2024.
//

import Foundation
import Supabase

class OTPVerificationViewModel: ObservableObject {
   
    // Глобальные переменные для отображение ошибки и навигации по приложению
    @Published var isNavigate: Bool = false
    @Published  var error: Bool = false
    func sentOtp(email:String, code:String)  {
        Task{
            do{
                //Проверка верификации токена и почты
                try await supabase.auth.verifyOTP(email: email, token: code, type: .recovery)

                await MainActor.run {
                    self.isNavigate = true
                }
            }
            catch{
                print("ERROR: " + error.localizedDescription)
                await MainActor.run {
                    self.error = true
                }
            }
        }
    }
    
    //Повторная отправка кода на почту
    func sendEmailOtp(email: String)  {
        Task{
            do{
                try await supabase.auth.resetPasswordForEmail(email)
            }
            catch{
                print("ERROR: " + error.localizedDescription)
                await MainActor.run {
                    self.error = true
                }
            }
        }
    }
}

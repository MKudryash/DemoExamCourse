//
//  OTPVerificationViewModel.swift
//  DemoExamCourse
//
//  Created by user on 12.10.2024.
//

import Foundation
import Supabase

class OTPVerificationViewModel: ObservableObject {
   

    @Published var isNavigate: Bool = false
    @Published  var error: Bool = false
    func sentOtp(email:String, code:String)  {
        Task{
            do{
                print(email)
                print(code)
                print(code.count)
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

//
//  ForgotPasswortViewModel.swift
//  DemoExamCourse
//
//  Created by user on 12.10.2024.
//

import Foundation

class ForgotPasswordViewModel: ObservableObject {
   

    @Published var isNavigate: Bool = false
    @Published  var error: Bool = false
    func sendEmailOtp(email: String)  {
        Task{
            do{
                try await supabase.auth.resetPasswordForEmail(email)

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
}

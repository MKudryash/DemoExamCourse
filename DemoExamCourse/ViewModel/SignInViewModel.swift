//
//  SignInViewModel.swift
//  DemoExamCourse
//
//  Created by user on 12.10.2024.
//

import Foundation

class SignInViewModel: ObservableObject {
   

    @Published var isNavigate: Bool = false
    @Published  var error: Bool = false
    func signIn(email: String, password: String)  {
        Task{
            do{
                try await supabase.auth.signIn(email: email, password: password)

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

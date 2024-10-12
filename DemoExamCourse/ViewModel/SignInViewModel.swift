//
//  SignInViewModel.swift
//  DemoExamCourse
//  View model для авторзации пользователя в системе
//  Created by Mamsheva on 12.10.2024.
//

import Foundation

class SignInViewModel: ObservableObject {
   
    // Глобальные переменные для отображение ошибки и навигации по приложению
    @Published var isNavigate: Bool = false
    @Published  var error: Bool = false
    
    /*
     * Авторизация пользователя в системе
     */
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

//
//  SignUpViewModel.swift
//  DemoExamCourse
//  View model для регистрации пользователя в системе
//  Created by Mamsheva on 12.10.2024.
//

import Foundation


class SignUpViewModel: ObservableObject {
    
    //Привязка данных на View SignUpView
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var phone: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    // Глобальные переменные для отображение ошибки и навигации по приложению
    @Published var isNavigate: Bool = false
    @Published  var error: Bool = false
    
    //Регистрация пользователя в системе
    func signUp()  {
        Task{
            do{
                try await supabase.auth.signUp(email: email, password: password)
                await MainActor.run {
                    self.isNavigate = true
                }
                //Добавление данных в таблицу User
                let user = try await supabase.auth.session.user
                let newUser = User(id: user.id, name: username, phone: phone,profile_image: "",birthday: "",email: email)
                try await supabase.from("profiles")
                .insert(newUser)
                .execute()
                //ВЫход пользователя из системы
                try await supabase.auth.signOut()
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

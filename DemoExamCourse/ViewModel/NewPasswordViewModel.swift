//
//  NewPasswordViewModel.swift
//  DemoExamCourse
//
//  Created by user on 12.10.2024.
//

import Foundation
import Supabase


class NewPasswordViewModel: ObservableObject {
   

    @Published var isNavigate: Bool = false
    @Published  var error: Bool = false
    func sendEmailOtp(password: String)  {
        Task{
            do{

                try await supabase.auth.update(user: .init(password: password))

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

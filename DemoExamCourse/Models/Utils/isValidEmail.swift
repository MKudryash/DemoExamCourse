//
//  isValidEmail.swift
//  DemoExamCourse
//  Проверка на валидность email (name@domenname.ru)
//  Created by Mamsheva on 12.10.2024.
//

import Foundation

func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: email)
}

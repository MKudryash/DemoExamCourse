//
//  CustomTextField.swift
//  DemoExamCourse
//  Создание пользовательского контейнера для ввода текста
//  Created by Mamsheva on 12.10.2024.

import SwiftUI

struct CustomTextField: View {
    let placeholder : String
    @Binding var text:String
    var body: some View {
        TextField(placeholder, text: $text)
            .font(.custom("Roboto-Medium", size:14))
            .frame(height: 40)
            .padding(.leading,7)
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
    }
}

#Preview {
    CustomTextField(placeholder: "String", text: .constant(""))
}

//
//  CustomBoxNumber.swift
//  DemoExamCourse
//  Пользовательский ввод токена
//  Created by Mamsheva on 12.10.2024.
//

import SwiftUI

struct CustomBoxNumber: View {
    @Binding var text:String
    @Binding var error:Bool
    var body: some View {
        TextField(
            "",text:$text
        )
        .frame(width:40, height: 40)
        .border(error ?  .red : text.count>0 ? .blue : .gray, width: 0.5)
        .keyboardType(.decimalPad)
        .multilineTextAlignment(.center)
        
    }
}

#Preview {
    CustomBoxNumber(text: .constant(""), error: .constant(false))
}


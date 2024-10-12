//
//  CustomSecuredField.swift
//  DemoExamCourse
//  Создание польвательского вводо пароля с возможностью скрытия или отображение пароля
//  Created by Mamsheva on 12.10.2024.
//

import SwiftUI

struct CustomSecuredField: View {
    @Binding var password:String
    @State var isSecure = true
    var body: some View {
        ZStack(alignment: .trailing) {
            if !isSecure{
                TextField("******", text: $password)
                    .font(.custom("Roboto-Medium", size:14))
                    .frame(height: 40)
                    .padding(.leading)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    
            }
            else
            {
                SecureField("******", text: $password)
                    
                    .font(.custom("Roboto-Medium", size:14))
                    .padding(.leading)
                    .frame(height: 40)
                    .background(
                        RoundedRectangle(cornerRadius: 5)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                
            }
                Button(action: {
                    isSecure.toggle()
                }, label: {
                    Image(isSecure ? .eyeSlash : .eye)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25, height: 25)
                        .padding(.trailing)
                })
            
        }
        .padding(.bottom,15)
        .frame(height: 60)
    }
}

#Preview {
    CustomSecuredField(password:.constant(""))
}

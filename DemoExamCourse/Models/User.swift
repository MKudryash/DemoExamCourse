//
//  USer.swift
//  DemoExamCourse
//  Модель User соответсвующая модели из Supabase
//  Created by Mamsheva on 12.10.2024.
//

import Foundation

struct User:Codable{
    var id:UUID
    var name: String
    var phone: String
    var profile_image:String
    var birthday:String
    var email:String
}

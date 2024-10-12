//
//  USer.swift
//  DemoExamCourse
//
//  Created by user on 12.10.2024.
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

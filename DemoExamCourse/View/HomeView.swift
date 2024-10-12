//
//  HomeView.swift
//  DemoExamCourse
//  Домашний экран
//  Created by user on 12.10.2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView{
            Text("Home")
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView()
}

//
//  Supabase.swift
//  DemoExamCourse
//
//  Created by user on 12.10.2024.
//

import Foundation
import Supabase

let supabase = SupabaseClient(supabaseURL: URL( string: "https://settlovuuvlcbrhcydxf.supabase.co")!,
                              supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InNldHRsb3Z1dXZsY2JyaGN5ZHhmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDYxOTEwNDUsImV4cCI6MjAyMTc2NzA0NX0.72gGEF3pi943jCSxcIJk7Urbv6BFl1iNAm61uEQ5aVU", options: .init())

//
//  JSONExamples.swift
//  APISimple
//
//  Created by Sena Uctuk on 12/18/24.
//

//What a basic JSON response might be:

//{
//    "id": 123,
//    "title": "My Post",
//    "likes": 42
//}

//Matching the struct:

struct Post: Codable {
    let id: Int
    let title: String
    let likes: Int
}

//Maybe there is a missing field we didn't see?

struct Post2: Codable {
    let id: Int
    let title: String
    let likes: Int?  // Optional if field might be missing
    let description: String?
}

//nested JSON response could look like:

//{
//    "user": {
//        "id": 1,
//        "profile": {
//            "name": "John",
//            "age": 25
//        }
//    }
//}

//Our nested struct is as such:

struct Response: Codable {
    let user: User
}

struct User: Codable {
    let id: Int
    let profile: Profile
}

struct Profile: Codable {
    let name: String
    let age: Int
}

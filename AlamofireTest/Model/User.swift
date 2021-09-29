//
//  User.swift
//  AlamofireTest
//
//  Created by Gonzalo Alfonso on 29/09/2021.
//

import Foundation

struct UserResponse: Codable {
  var meta: Meta?
  var data: User?
}

struct Meta: Codable {
}

struct User: Codable {
  var id: Int?
  var name: String?
  var email: String?
  var gender: String?
  var status: String = "Active"
}

//
//  NetworkingProvider.swift
//  AlamofireTest
//
//  Created by Gonzalo Alfonso on 29/09/2021.
//
//  TODO: Avoid code duplication

import Foundation
import Alamofire

final class NetworkingProvider {
  
  static let shared = NetworkingProvider()
  
  private let kBaseUrl = "https://gorest.co.in/public/v1/"
  private let kStatusOk = 200...299
  private let kToken = "a4de6853ddbb34d5aeb7aa8c22510b3e7a78a529e136adf8bef02085bea471d9"
  
  func getUser(id: Int, succes: @escaping (_ user: User) -> (), failure: @escaping (_ error: Error?) -> ()) {
    
    let url = "\(kBaseUrl)users/\(id)"
    
    AF.request(url, method: .get).validate(statusCode: kStatusOk).responseDecodable(of: UserResponse.self) { response in
      
      if let user = response.value?.data {
        succes(user)
      } else {
        failure(response.error)
      }
    }
  }
  
  func addUser(user: User, succes: @escaping (_ user: User) -> (), failure: @escaping (_ error: Error?) -> ()) {
    
    let url = "\(kBaseUrl)users"
    let header: HTTPHeaders = [.authorization(bearerToken: kToken)]
    
    AF.request(url, method: .post, parameters: user, encoder: JSONParameterEncoder.default, headers: header).validate(statusCode: kStatusOk).responseDecodable(of: UserResponse.self) { response in
      
      if let user = response.value?.data, user.id != nil {
        succes(user)
      } else {
        failure(response.error)
      }
    }
  }
  
  func updateUser(id: Int, user: User, succes: @escaping (_ user: User) -> (), failure: @escaping (_ error: Error?) -> ()) {
    
    let url = "\(kBaseUrl)users/\(id)"
    let header: HTTPHeaders = [.authorization(bearerToken: kToken)]
    
    AF.request(url, method: .put, parameters: user, encoder: JSONParameterEncoder.default, headers: header).validate(statusCode: kStatusOk).responseDecodable(of: UserResponse.self) { response in
      
      if let user = response.value?.data, user.id != nil {
        succes(user)
      } else {
        failure(response.error)
      }
    }
  }
  
  func deleteUser(id: Int, succes: @escaping () -> (), failure: @escaping (_ error: Error?) -> ()) {
    
    let url = "\(kBaseUrl)users/\(id)"
    let header: HTTPHeaders = [.authorization(bearerToken: kToken)]
    
    AF.request(url, method: .delete, headers: header).validate(statusCode: kStatusOk).response { response in
      
      if let error = response.error {
        failure(error)
      } else {
        succes()
      }
    }
  }
}

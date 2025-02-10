//
//  KeyChainHekper.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 6/02/25.
//


import Foundation
import Security
class KeyChainHekper{
    static let shared = KeyChainHekper()
    private init(){}
    func save(_ data:Data,service:String,account:String){
        let q = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
        ] as [String:Any]
        SecItemDelete(q as CFDictionary)
        SecItemAdd(q as CFDictionary,nil)
    }
    func read(service: String, account: String) -> Data? {
           let query = [
               kSecClass as String: kSecClassGenericPassword,
               kSecAttrService as String: service,
               kSecAttrAccount as String: account,
               kSecReturnData as String: kCFBooleanTrue!,
               kSecMatchLimit as String: kSecMatchLimitOne
           ] as [String: Any]
           
           var dataTypeRef: AnyObject? = nil
           let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
           
           if status == errSecSuccess {
               return dataTypeRef as! Data?
           } else {
               return nil
           }
       }
        func delete(service: String, account: String) {
          let query = [
              kSecClass as String: kSecClassGenericPassword,
              kSecAttrService as String: service,
              kSecAttrAccount as String: account
          ] as [String: Any]
          
          SecItemDelete(query as CFDictionary)
      }
      
      func save(_ string: String, service: String, account: String) {
          if let data = string.data(using: .utf8) {
              save(data, service: service, account: account)
          }
      }
      
      func read(service: String, account: String) -> String? {
          if let data = read(service: service, account: account) as Data?{
              return String(data: data, encoding: .utf8)
          } else {
              return nil
          }
      }
}

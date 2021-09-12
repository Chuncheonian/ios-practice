//
//  User.swift
//  SignUp
//
//  Created by dykoon on 2021/09/02.
//

import UIKit

class UserInfomation {
    static let shared: UserInfomation = UserInfomation()  // // SingleTon Pattern

    var id: String?
    var password: String?
    var profilePhoto: UIImage?
    var introduce: String?
    var phoneNumber: String?
    var dateOfBirth: Date?
}

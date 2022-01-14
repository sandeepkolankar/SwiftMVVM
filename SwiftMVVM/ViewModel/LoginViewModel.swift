//
//  LoginViewModel.swift
//  SwiftMVVM
//
//  Created by Sandeep Kolankar on 13/01/22.
//

import UIKit

struct LoginViewModel {
    
    let passwordLengthRange = (8, 15) // (minimum length, maximum length)
    
    func validateInput(_ username: String?, password: String?, completion: (Bool, String?) -> Void) {
        if let username = username {
            if username.isEmpty {
                completion(false, Constants.Login.usernameEmptyMessage)
                return
            } else if !username.isValidEmail() {
                completion(false, Constants.Login.usernameErrorMessage)
                return
            }
        } else {
            completion(false, Constants.Login.usernameEmptyMessage)
            return
        }
        if let password = password {
            if password.isEmpty {
                completion(false, Constants.Login.passwordEmptyMessage)
                return
            } else if !validateTextLength(password, range: passwordLengthRange) {
                completion(false, Constants.Login.passwordErrorMessage)
                return
            }
        } else {
            completion(false, Constants.Login.passwordEmptyMessage)
            return
        }
        // Validated successfully.
        completion(true, nil)
    }

    private func validateTextLength(_ text: String, range: (Int, Int)) -> Bool {
        return (text.count >= range.0) && (text.count <= range.1)
    }

    func login(_ requestModel: LoginRequestModel, completion: @escaping (LoginResponseModel) -> Void) {
        let params = requestModel.getParams()
        var responseModel = LoginResponseModel()
        responseModel.success = true
        responseModel.successMessage = Constants.Login.userLoggedInMessage
        completion(responseModel)
        //Save login credentials here
    }
}

struct LoginRequestModel {
    var username: String
    var password: String

    init(username: String, password: String) {
        self.username = username
        self.password = password
    }

    func getParams() -> [String: Any] {
        return ["username": username, "password": password]
    }
}

struct LoginResponseModel {
    var success = false
    var errorMessage: String?
    var successMessage: String?
    var data: Any?
}

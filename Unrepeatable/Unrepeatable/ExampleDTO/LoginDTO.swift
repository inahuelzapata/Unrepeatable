//
//  LoginDTO.swift
//  Unrepeatable
//
//  Created by Nahuel Zapata on 5/29/19.
//  Copyright © 2019 @iNahuelZapata. All rights reserved.
//

import Foundation

struct LoginRequest {
    let email: String
    let password: String
}

extension LoginRequest: Encodable { }

struct LoginResponse { }

extension LoginResponse: Decodable { }


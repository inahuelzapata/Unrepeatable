//
//  LoginEndpoint.swift
//  Unrepeatable
//
//  Created by Nahuel Zapata on 5/29/19.
//  Copyright © 2019 @iNahuelZapata. All rights reserved.
//

import Foundation

enum LoginEndpoint: Endpoint {
    case logIn

    var httpMethod: HTTPSMethod {
        return .get
    }

    var path: String {
        return "/login"
    }
}

extension LoginEndpoint {
    var responseType: ResponseType {
        return .stub(LoginMock.logIn)
    }
}

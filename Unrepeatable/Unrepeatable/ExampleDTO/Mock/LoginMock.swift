//
//  LoginMock.swift
//  Unrepeatable
//
//  Created by Nahuel Zapata on 5/29/19.
//  Copyright © 2019 @iNahuelZapata. All rights reserved.
//

import Foundation

enum LoginMock: Mockable {
    case logIn
    var mockData: Data {
        do {
            return try stubJSONData(file: LoginMockBundle.logIn, bundle: .main)
        } catch {
            return Data()
        }
    }

    var shouldSucceed: Bool {
        switch self {
        case .logIn:
            return true
        }
    }
}

enum LoginMockBundle: FileBundle {
    case logIn

    var filename: String {
        switch self {
        case .logIn:
            return "Login"
        }
    }
}

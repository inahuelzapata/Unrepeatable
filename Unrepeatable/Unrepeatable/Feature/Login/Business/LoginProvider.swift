//
//  LoginProvider.swift
//  Unrepeatable
//
//  Created by Nahuel Zapata on 5/29/19.
//  Copyright © 2019 @iNahuelZapata. All rights reserved.
//

import Foundation
import ReactiveSwift

protocol AsyncProvider {
    init(requestBuilder: HTTPRequestBuildeable, requestProvider: RequestProvider)
}

protocol LoginProvidable: AsyncProvider {
    func execute(loginRequest: LoginRequest) throws -> SignalProducer<LoginResponse, Error>

    func build(basedOn loginRequest: LoginRequest) -> HTTPRequestable
}

class LoginProvider: LoginProvidable {
    let requestBuilder: HTTPRequestBuildeable
    let requestProvider: RequestProvider

    required init(requestBuilder: HTTPRequestBuildeable, requestProvider: RequestProvider) {
        self.requestBuilder = requestBuilder
        self.requestProvider = requestProvider
    }

    func execute(loginRequest: LoginRequest) throws -> SignalProducer<LoginResponse, Error> {
        return try requestProvider.execute(request: build(basedOn: loginRequest),
                                           expectedModel: LoginResponse.self)
    }

    func build(basedOn loginRequest: LoginRequest) -> HTTPRequestable {
        return requestBuilder
            .consume(endpoint: LoginEndpoint.logIn)
            .build()
    }
}

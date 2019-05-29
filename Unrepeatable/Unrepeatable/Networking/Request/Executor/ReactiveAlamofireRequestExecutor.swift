//
//  ReactiveAlamofireRequestExecutor.swift
//  Unrepeatable
//
//  Created by Nahuel Zapata on 5/29/19.
//  Copyright © 2019 @iNahuelZapata. All rights reserved.
//

import Alamofire
import Foundation
import ReactiveSwift

class ReactiveAlamofireRequestExecutor: RequestExecutor, HeaderComposer {
    let responseParser: ResponseParser
    let sessionManager: Alamofire.SessionManager

    required init(responseParser: ResponseParser) {
        self.responseParser = responseParser
        self.sessionManager = .default
    }

    init(responseParser: ResponseParser, sessionManager: Alamofire.SessionManager = .default) {
        self.responseParser = responseParser
        self.sessionManager = sessionManager
    }

    func execute<T: Decodable>(request: HTTPRequestable, with expectedType: T.Type) -> HTTPResponse {
        switch request.endpoint.responseType {
        case .stub(let stubType):
            return SignalProducer<T, Error> { observer, _ in
                do {
                    observer.send(value: try self.responseParser.parse(response: stubType.dataResponse,
                                                                       expectedType: T.self,
                                                                       decodingStrategy: request.keyDecodingStrategy))
                } catch {
                    observer.send(error: NetworkingError.invalidJSON)
                }
            }

        case .real:
            return SignalProducer<T, Error> { observer, _ in
                self.sessionManager.request(request.endpoint.builtURL,
                                            method: request.endpoint.httpMethod.method,
                                            parameters: request.params,
                                            encoding: request.encoding,
                                            headers: self.compose(headers: request.headers))
                    .responseJSON { response in
                        do {
                            observer.send(value: try self.responseParser.parse(response: response,
                                                                               expectedType: T.self,
                                                                               decodingStrategy: request.keyDecodingStrategy))
                        } catch {
                            observer.send(error: NetworkingError.statusCode(777))
                        }
                }
            }
        }
    }
}

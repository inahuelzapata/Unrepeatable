//
//  HTTPResponse.swift
//  Unrepeatable
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Foundation
import PromiseKit
import ReactiveSwift

protocol HTTPResponse { }

extension Promise: HTTPResponse { }

extension SignalProducer: HTTPResponse { }

extension Signal: HTTPResponse { }

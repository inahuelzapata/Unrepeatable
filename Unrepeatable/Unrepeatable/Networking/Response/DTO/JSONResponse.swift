//
//  JSONResponse.swift
//  Unrepeatable
//
//  Created by Nahuel Zapata on 5/12/19.
//  Copyright © 2019 iNahuelZapata. All rights reserved.
//

import Alamofire
import Foundation

public protocol JSONResponse { }

extension DataResponse: JSONResponse { }

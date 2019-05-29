//
//  LoginViewController.swift
//  Unrepeatable
//
//  Created by Nahuel Zapata on 5/29/19.
//  Copyright © 2019 @iNahuelZapata. All rights reserved.
//

import Foundation
import ReactiveCocoa
import ReactiveSwift
import UIKit

class LoginViewController: UIViewController {
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!

    let provider: LoginProvidable = LoginProvider(requestBuilder: currentReactive.requestBuilder,
                                                  requestProvider: currentReactive.requestProvider)

    override func viewDidLoad() {
        super.viewDidLoad()

        logIn()
    }

    func logIn() {
        do {
            try provider.execute(loginRequest: LoginRequest(email: "Inahuelzapata@gmail.com",
                                                            password: "skere"))
                .on(starting: { [weak self] in
                    self?.view.backgroundColor = .blue
                }, failed: { [weak self] error in
                    print(error)
                    self?.view.backgroundColor = .red
                }, value: { [weak self] response in
                    self?.view.backgroundColor = .green
                    print(response)
                }).start()
        } catch {
            // error handling
            print(error)
            self.view.backgroundColor = .red
        }
    }
}

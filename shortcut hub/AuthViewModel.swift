//
//  AuthViewModel.swift
//  shortcut hub
//

import Foundation

@Observable
class AuthViewModel {
    var isLoggedIn = false
    var email = ""
    var password = ""
    var username = ""
    var isSignUp = false
    var errorMessage: String?

    func login() {
        guard !email.isEmpty, !password.isEmpty else {
            errorMessage = "Please fill in all fields"
            return
        }
        // TODO: Replace with real Firebase auth
        errorMessage = nil
        isLoggedIn = true
    }

    func signUp() {
        guard !email.isEmpty, !password.isEmpty, !username.isEmpty else {
            errorMessage = "Please fill in all fields"
            return
        }
        // TODO: Replace with real Firebase auth
        errorMessage = nil
        isLoggedIn = true
    }

    func logout() {
        isLoggedIn = false
        email = ""
        password = ""
        username = ""
        errorMessage = nil
    }
}

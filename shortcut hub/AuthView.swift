//
//  AuthView.swift
//  shortcut hub
//

import SwiftUI

struct AuthView: View {
    @Environment(AuthViewModel.self) private var authViewModel

    var body: some View {
        @Bindable var auth = authViewModel

        NavigationStack {
            ScrollView {
                VStack(spacing: 32) {
                    // App Branding
                    VStack(spacing: 12) {
                        ZStack {
                            RoundedRectangle(cornerRadius: 20)
                                .fill(
                                    LinearGradient(
                                        colors: [.blue, .indigo],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .frame(width: 80, height: 80)

                            Image(systemName: "arrow.up.doc.fill")
                                .font(.system(size: 36, weight: .semibold))
                                .foregroundColor(.white)
                        }

                        Text("Scuttle")
                            .font(.largeTitle)
                            .fontWeight(.bold)

                        Text("Discover and share iOS shortcuts")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .padding(.top, 60)

                    // Form Fields
                    VStack(spacing: 16) {
                        if auth.isSignUp {
                            HStack(spacing: 12) {
                                Image(systemName: "person.fill")
                                    .foregroundColor(.secondary)
                                    .frame(width: 20)
                                TextField("Username", text: $auth.username)
                                    .textInputAutocapitalization(.never)
                                    .autocorrectionDisabled()
                            }
                            .padding(14)
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(12)
                        }

                        HStack(spacing: 12) {
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.secondary)
                                .frame(width: 20)
                            TextField("Email", text: $auth.email)
                                .keyboardType(.emailAddress)
                                .textInputAutocapitalization(.never)
                                .autocorrectionDisabled()
                        }
                        .padding(14)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)

                        HStack(spacing: 12) {
                            Image(systemName: "lock.fill")
                                .foregroundColor(.secondary)
                                .frame(width: 20)
                            SecureField("Password", text: $auth.password)
                        }
                        .padding(14)
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(12)

                        // Error Message
                        if let error = auth.errorMessage {
                            Text(error)
                                .font(.caption)
                                .foregroundColor(.red)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }

                    // Action Button
                    Button(action: {
                        if auth.isSignUp {
                            authViewModel.signUp()
                        } else {
                            authViewModel.login()
                        }
                    }) {
                        Text(auth.isSignUp ? "Sign Up" : "Log In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding(16)
                            .background(
                                LinearGradient(
                                    colors: [.blue, .indigo],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .cornerRadius(14)
                            .shadow(color: .indigo.opacity(0.3), radius: 8, x: 0, y: 4)
                    }

                    // Toggle Auth Mode
                    Button(action: {
                        withAnimation(.easeInOut(duration: 0.2)) {
                            auth.isSignUp.toggle()
                            auth.errorMessage = nil
                        }
                    }) {
                        HStack(spacing: 4) {
                            Text(auth.isSignUp ? "Already have an account?" : "Don't have an account?")
                                .foregroundColor(.secondary)
                            Text(auth.isSignUp ? "Log In" : "Sign Up")
                                .fontWeight(.semibold)
                                .foregroundColor(.blue)
                        }
                        .font(.subheadline)
                    }
                }
                .padding(24)
            }
            .background(
                LinearGradient(
                    colors: [.blue.opacity(0.06), .purple.opacity(0.04), .clear],
                    startPoint: .top,
                    endPoint: .center
                )
                .ignoresSafeArea()
            )
        }
    }
}

#Preview {
    AuthView()
        .environment(AuthViewModel())
}

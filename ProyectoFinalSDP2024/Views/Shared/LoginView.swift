//
//  LoginView.swift
//  ProyectoFinalSDP2024
//
//  Created by Angel Zuñiga on 8/02/25.
//
import SwiftUI
struct RegisterView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(AppState.self) var appState
    @State var email:String = ""
    @State var password:String = ""
    var body: some View {
        VStack(spacing: 20) {
            Text("Registro")
                .font(.largeTitle)
                .padding(.bottom, 50)
            TextField("Correo electrónico", text: $email)
                .textFieldStyle(.roundedBorder)
            SecureField("Contraseña", text:$password)
                .textFieldStyle(.roundedBorder)
            Button("Registrar") {
                appState.register(email:email, password: password)
                dismiss()
            }
            .buttonStyle(.borderedProminent)
            .tint(.blue)
        }
        .padding()
    }
}

struct LoginView:View{
    @Environment(AppState.self) var appState
    @State var email:String = ""
    @State var password:String = ""
    @State private var showRegisterView: Bool = false
    var body: some View{
        VStack(spacing:20){
            Text("AnimeSB").font(.title).padding(.bottom,50)
            TextField("email", text: $email).textFieldStyle(.roundedBorder).tint(.primarySB)
            SecureField("password", text: $password).textFieldStyle(.roundedBorder).tint(.primarySB)
            Text(appState.errorMsg).foregroundStyle(.error)
            VStack(spacing:30){
                Button{
                    appState.login(email: email, password: password)
                }label: {
                    Text("Ingresar").padding(.horizontal)
                }.tint(.primarySB).buttonStyle(.borderedProminent)
                Button("registrate aqui") {
                    showRegisterView = true
                }.tint(.primarySB).buttonStyle(.automatic)
            }.padding()
        }.padding().sheet(isPresented: $showRegisterView) {
            RegisterView()
        }
    }
}

#Preview {
    LoginView().environment(AppState())
}

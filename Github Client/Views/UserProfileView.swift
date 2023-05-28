//
//  UserProfileView.swift
//  Github Client
//
//  Created by Arman Sarvardin on 29.05.2023.
//

import SwiftUI
import Domain

struct UserProfileView: View {
    @ObservedObject private var viewModel = UserProfileViewModel()
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            VStack(spacing: 72) {
                VStack {
                    AsyncImage(url: viewModel.userInfo?.avatarUrl) { image in
                        image
                            .resizable()
                    } placeholder: {
                        Image(systemName: "person")
                            .resizable()
                    }
                    .frame(width: 240, height: 240)
                    .clipShape(Circle())
                    List {
                        Section("User Info") {
                            Text("Name: \(viewModel.userInfo?.name ?? "Full Name")")
                            Text("Email: \(viewModel.userInfo?.email ?? "email address")")
                            
                        }
                        Section("Actions") {
                            Button {
                                viewModel.signOut()
                            } label: {
                                Text("Sign Out")
                                    .foregroundColor(.red)
                            }.onReceive(viewModel.$dismissAction) { output in
                                if output {
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }
                    }.listStyle(.grouped)
                }
            }
            .navigationTitle("Profile")
        }
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}

//
//  ContactUsView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/27/23.
//

import SwiftUI

struct ContactUsView: View {
    @State private var name = ""
    @State private var email = ""
    @State private var message = "Message.."
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationView{
            VStack {
                Text("Contact Us")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 50)

                Form {
                    Section(header: Text("Your Information")) {
                        TextField("Name", text: $name)
                        TextField("Email", text: $email)
                        TextEditor(text: $message)
                            .onTapGesture {
                                if message == "Message" {
                                    self.message = ""
                                }
                            }
                    }
                }
                .frame(maxWidth: 500)
                .padding(.horizontal)

                Button("Send") {
                    // Send button action
                }
                .frame(width: 150, height: 50)
                .font(.title3)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(25)
                .padding(.bottom, 50)
            }
        }
        .navigationBarHidden(true)
        .toolbar{
            ToolbarItem(placement: .navigationBarLeading){
                Button {
                    dismiss()
                } label: {
                    Text("Back")
                }
            }
        }
    }
}

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}

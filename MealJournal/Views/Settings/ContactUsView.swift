//
//  ContactUsView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/27/23.
//

import SwiftUI
import MessageUI

struct ContactUsView: View {
    @State private var name = ""
    @State private var message = ""
    @State var isShowingMailView = false
    @Environment(\.dismiss) var dismiss
    @State private var showMailUnavailableAlert = false
    @FocusState var isMessageFieldActive: Bool
    @State var mailSendSuccess = false
    
    //picker variables
    let contactReasons = ["General Inquiry", "Report Bug/Technical Issue", "Reporting user"]
    @State private var selectedReasonIndex = 0
    
    @State private var mailData = MailData(name: "",
            recipients: ["macromateapp@gmail.com"],
            message: ""
           )
   
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Get in touch")
                    .font(.custom("Montserrat-Regular", size: 32))
                    .fontWeight(.bold)
                    .padding(.bottom, 25)
                    .padding(.top, -50)

               
                    Section() {
                        VStack(alignment: .leading) {
                            Text("Name")
                                .font(.custom("Montserrat-Regular", size: 18))
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .focused($isMessageFieldActive)
                             
                            TextField("", text: $name)
                                .font(.custom("Montserrat-Regular", size: 18))
                                .focused($isMessageFieldActive)
                                .frame(width: 350, height: 40)
                                .foregroundColor(.black)
                                .overlay(
                                   RoundedRectangle(cornerRadius: 8)
                                       .stroke(Color("graySettingsPillbox"), lineWidth: 1)
                               )
                            
                        }
                        
                            ZStack {
                                VStack(alignment: .leading){
                               // Custom picker label
                                Text("Reason for contacting us")
                                        .font(.custom("Montserrat-Regular", size: 18))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.top, 15)
                               // Invisible picker
                                Picker(selection: $selectedReasonIndex, label: Text("")) {
                                    ForEach(0..<contactReasons.count) { index in
                                        Text(contactReasons[index])
                                        
                                    }
                                    
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .accentColor(.gray)
                             //   .pickerStyle(.menu)
                                .frame(width: 305, height: 30)
                             
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color("graySettingsPillbox"), lineWidth: 1)
                                )
                                    
                            }
                               
                        }
                        
                        VStack (alignment: .leading){
                            Text("Message")
                                .font(.custom("Montserrat-Regular", size: 18))
                                .padding(.top, 25)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            TextEditor(text: $message)
                                .font(.title3)
                                .frame(height: 100)
                                .frame(width: 350)
                                .foregroundColor(.black)
                                .overlay(
                                   RoundedRectangle(cornerRadius: 8)
                                       .stroke(Color("graySettingsPillbox"), lineWidth: 1)
                               )
                                .focused($isMessageFieldActive)
                                .toolbar{
                                    ToolbarItemGroup(placement: .keyboard){
                                        Spacer()
                                        
                                        Button("Done"){
                                            isMessageFieldActive = false
                                        }
                                    }
                                }
                        }
                    }
             
                .frame(maxWidth: 500)
                .padding(.horizontal)
              
                Button("Send") {
                    if MFMailComposeViewController.canSendMail() {
                           mailData.message = self.message
                           isShowingMailView.toggle()
                       } else {
                           showMailUnavailableAlert.toggle()
                       }
                }
                .frame(width: 200, height: 50)
                .font(.title3)
                .foregroundColor(.black)
                .background(Color("PieChart1"))
                .cornerRadius(25)
                .padding(.bottom, 50)
                .padding(.top, 15)
            
            }
            .padding(.top, -45)
            
            .alert(isPresented: $showMailUnavailableAlert, content: {
                Alert(title: Text("You do not have an email account set up on this device."),
                       message: Text("Add your email account in the Settings page, or email us directly at macromateapp@gmail.com"), dismissButton:
                            .default(Text("Ok")))
            })
            // show mail view
            .sheet(isPresented: $isShowingMailView, content: {
                if let mailViewController = MailView(toRecipient: "jimmyciaston@gmail.com", subject: "\(contactReasons[selectedReasonIndex]) ", messageBody: message, mailSendSuccess: $mailSendSuccess) {
                         mailViewController
                     } else {
                         Text("Unable to send email")
                     }
                 })
            //mail send successful
            .sheet(isPresented: $mailSendSuccess, onDismiss: {
                dismiss()
            },
                   
                   content: {
                VStack{
                    Text("Thank you for reaching out!")
                        .font(.title3)
                    Text("Our team will review your email and get back to you shortly.")
                        .font(.body)
                        .padding(.top, 25)
                }
             })
            
            //  .navigationBarHidden(true)
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
}

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}

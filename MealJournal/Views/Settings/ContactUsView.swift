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
    @State private var email = ""
    @State private var message = "Message"
    @State var isShowingMailView = false
    @Environment(\.dismiss) var dismiss
 
    
    
    
    @State private var mailData = MailData(name: "",
            recipients: ["jimmyciaston@gmail.com"],
            message: ""
           )
   
    
    var body: some View {
        NavigationView{
            VStack {
                Text("Get in touch")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.top, 50)

               
                    Section() {
                        TextField(" Name", text: $name)
                            .font(.title3)
                            .padding(.top, 15)
                        
                        TextField(" Email", text: $email)
                            .font(.title3)
                            .padding([.top, .bottom], 15)
                        TextEditor(text: $message)
                            .font(.title3)
                            .frame(height: 200)
                            .foregroundColor(Color("graySettingsPillbox"))
                            .overlay(
                               RoundedRectangle(cornerRadius: 8)
                                   .stroke(Color("graySettingsPillbox"), lineWidth: 1)
                           )
                            .opacity(0.6)
                            .onTapGesture {
                                if message == "Message" {
                                    self.message = ""
                                }
                                
                            }
                        }
                
                .frame(maxWidth: 500)
                .padding(.horizontal)
              
                Button("Send") {
                    print("toggle")
                    mailData.message = self.message
                    isShowingMailView.toggle()
                }
                .frame(width: 200, height: 50)
                .font(.title3)
                .foregroundColor(.black)
                .background(Color("PieChart1"))
                .cornerRadius(25)
                .padding(.bottom, 50)
                .padding(.top, 15)
            
            }
           
            .onTapGesture {
                if self.message == "" {
                    self.message = "Message"
                }
            }
            
            .sheet(isPresented: $isShowingMailView) {
                MailView(content: mailData.message, to: mailData.recipients[0], subject: "Contact Us Inquiry")
            }
        }
     
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

struct ContactUsView_Previews: PreviewProvider {
    static var previews: some View {
        ContactUsView()
    }
}

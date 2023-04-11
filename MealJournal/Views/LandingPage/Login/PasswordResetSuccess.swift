//
//  PasswordResetSuccess.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/10/23.
//

import SwiftUI

struct PasswordResetSuccess: View {
    
    @Binding var showSuccessMsg:  Bool
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "mail.stack")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(Color("PieChart1"))
            
            Text("A password reset link has been sent to your email.")
                .font(.title2)
                .padding([.leading, .trailing], 20)
                .foregroundColor(Color.black)
                .frame(maxWidth: 300)
                .multilineTextAlignment(.center)
        }
        .padding(20)
        .background(Color("GetStartedPopUpBackground"))
        .cornerRadius(20)
        .shadow(radius: 10, y: 10)
        .frame(width:350, height:300)
    }
}

struct PasswordResetSuccess_Previews: PreviewProvider {
    static var previews: some View {
        PasswordResetSuccess(showSuccessMsg: .constant(true))
    }
}

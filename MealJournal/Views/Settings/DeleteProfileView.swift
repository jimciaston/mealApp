//
//  DeleteProfileView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 11/11/22.
//

import SwiftUI

struct DeleteProfileView: View {
    @StateObject var deleteProfileLogic = DeleteAccountLogic()
    
    @Binding var deleteSuccess: Bool
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.secondary)
                .frame(width: 60,height: 5)
                .padding(.top, -25)
                .onTapGesture {
                    self.deleteSuccess.toggle()
                }
            Text("Are you sure?")
                .bold()
                .font(.title2)
            Text("Deleting your account erases all data")
                .padding(.top, 10)
            Button(action: {
                deleteProfileLogic.deleteAccount(deleteSuccess: deleteSuccess)
                deleteSuccess = false
                UserDefaults.standard.set(false, forKey: "signedIn")
            }){
                Text("Delete Profile").fontWeight(.bold)
                    .frame(minWidth: 0, maxWidth: 200)
                    .padding(10)
                    .foregroundColor(.black)
                    
                //draw rectange around buttons
                    .overlay( RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.red, lineWidth: 3)
                )}
            .padding(.top, 25)
        }
        .padding([.top, .bottom ], 65)
        Spacer()
        .frame(height: 400)

    }
}

struct DeleteProfileView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteProfileView(deleteSuccess: .constant(true))
    }
}

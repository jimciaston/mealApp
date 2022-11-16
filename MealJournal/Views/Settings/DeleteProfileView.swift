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
            Text("Are you sure?")
                .bold()
                .font(.title2)
            Text("Once you delete your account, all data will be erased. There is **no** going back")
                .padding(.top, 10)
            Button(action: {
                deleteProfileLogic.deleteAccount(deleteSuccess: deleteSuccess)
                deleteSuccess = false
                
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
    }
}

struct DeleteProfileView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteProfileView(deleteSuccess: .constant(false))
    }
}

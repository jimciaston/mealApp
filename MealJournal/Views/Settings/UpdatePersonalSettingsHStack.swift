//
//  updatePersonalSettingsHStack.swift
//  MealJournal
//
//  Created by Jim Ciaston on 10/7/22.
//

import SwiftUI




struct UpdatePersonalSettingsHStack: View {
    @ObservedObject var vm: DashboardLogic
    @Binding var name: String
    @Binding var bio: String
    @State var showSuccessAlertForName = false
    @State var names = ""
    @State var userBio = ""
    var body: some View {
        
            HStack{
                Image(systemName: "person.crop.rectangle")
                    .foregroundColor(Color("ButtonTwo"))
                TextField(name ?? "Name unavailable", text: $names).submitLabel(.done)
                    .onSubmit{
                        if (vm.userModel?.name != names){
                            FirebaseManager.shared.firestore.collection("users").document(FirebaseManager.shared.auth.currentUser!.uid).updateData(["name": names])
                            vm.userModel?.name = names
                            showSuccessAlertForName.toggle()
                        }
                    }
                    .alert(isPresented: $showSuccessAlertForName, content: {
                        Alert(title: Text("Name Updated"),
                               message: Text(""), dismissButton:
                                    .default(Text("Close")))
                    })
                    .padding(.trailing, 20)
            }
        HStack{
            Image(systemName: "person.crop.rectangle")
                .foregroundColor(Color("ButtonTwo"))
            TextField(bio ?? "Name unavailable", text: $userBio).submitLabel(.done)
                .onSubmit{
                    if (vm.userModel?.userBio != userBio){
                        FirebaseManager.shared.firestore.collection("users").document(FirebaseManager.shared.auth.currentUser!.uid).updateData(["userBio": bio])
                        vm.userModel?.userBio = userBio
                        showSuccessAlertForName.toggle()
                    }
                }
                .alert(isPresented: $showSuccessAlertForName, content: {
                    Alert(title: Text("Bio Updated"),
                           message: Text(""), dismissButton:
                                .default(Text("Close")))
                })
                .padding(.trailing, 20)
        }
    }
}
//
//struct UpdatePersonalSettingsHStack_Previews: PreviewProvider {
//    static var previews: some View {
//        updatePersonalSettingsHStack()
//    }
//}

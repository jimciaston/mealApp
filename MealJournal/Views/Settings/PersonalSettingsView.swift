//
//  PersonalSettingsView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 6/2/22.
//

import SwiftUI
import UIKit



struct PersonalSettingsView: View {
    
    @ObservedObject var vm: DashboardLogic  //call to viewModel
    @State  var currentUserEmail = FirebaseManager.shared.auth.currentUser?.email
    @State  var email: String = ""
    @State  var password: String = ""
    @State var name: String = ""
    @State  var userBio: String = ""
    @State  var showSuccessAlertForEmail = false
    @State  var showSuccessAlertForName = false
    @State  var gender = ""
    @State  var weight = ""
    //@State private var height: String = ""
    @State  var agenda: String = ""
    @State  var userInstagramHandle = "" // << instagram
   // **** Picker Options ****
     var weightOptions = getWeight() //calls function that calculates weight up to 700ibs
     var fitnessAgenda = ["Bulking", "Cutting", "Maintain"]
     var genderOptions = ["Male", "Female", "Other"]
     var heightOptions = ["4'0", "4'1","4'2","4'3", "4'4", "4'5","4'6","4'7","4'8","4'9","4'10","4'11","5'0","5'1", "5'2", "5'3", "5'4", "5'5","5'6","5'7","5'8","5'9","5'10","5'11","6'0","6'1","6'2","6'3","6'4","6'5","6'6","6'7","6'8","6'9","6'10","6'11","7'0","7'1","7'2"]
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        
        NavigationView{
            Form{
                Section(header: Text("Personal Settings").foregroundColor(.blue).font(.title3)
                            .foregroundColor(.black)
                            .font(.body)
                            .textCase(nil))
                {
                        HStack{
                            Image(systemName: "person.fill")
                                .foregroundColor(Color("ButtonTwo"))
                                .frame(width: 20, height: 20)
                            TextField(currentUserEmail ?? "User Email", text: $email)
                                .submitLabel(.done)
                            //update firestore with new email
                                .onSubmit {
                                    if(email != currentUserEmail) {
                                        //UPDATE USER IN AUTH
                                        FirebaseManager.shared.auth.currentUser?.updateEmail(to: email){ err in
                                            if let err = err {
                                                print(err)
                                            }
                                            //IF GOOD, WE UPDATE THE COLLECTION VALUE OF EMAIL AS WELL
                                            FirebaseManager.shared.firestore
                                                .collection("users")
                                                .document(FirebaseManager.shared.auth.currentUser!.uid)
                                                .collection("privateUserInfo")
                                                .document("private")
                                                .updateData(["email": email])
                                            
                                            showSuccessAlertForEmail.toggle()
                                            print("user email updated")
                                        }
                                    }
                                }
                        }
                        .alert(isPresented: $showSuccessAlertForEmail, content: {
                            Alert(title: Text("Email Updated"),
                                   message: Text(""), dismissButton:
                                        .default(Text("Got it")))
                        })
                
                    
                    
                    UpdatePersonalSettingsHStack(vm: vm, name: .constant(vm.userModel?.name ?? "Name not found"), bio: .constant(vm.userModel?.userBio ?? "Bio not found"))
                    
                    
                    HStack{
                        Image("Instagram-Logo-2")
                            .renderingMode(.template)
                            .resizable()
                            .frame(width:20, height:20)
                            .foregroundColor(Color("ButtonTwo"))
                        TextField("Enter your instagram Link", text: $userInstagramHandle)
                    }
             }
                
                Section(header: Text("Health Stats").foregroundColor(.blue).font(.title3)
                            .foregroundColor(.black)
                            .font(.body)
                            .textCase(nil)){
            
                    HStack{
                        if (vm.userModel != nil){
                            Picker(selection: Binding<String> (
                                get: {vm.userModel!.height },
                                set: {vm.userModel!.height = $0
                                    FirebaseManager.shared.firestore.collection("users").document(FirebaseManager.shared.auth.currentUser!.uid).updateData(["height": $0])
                                }),
                                   label: Text("Height")) {
                                ForEach(heightOptions, id: \.self ){ height in
                                        Text(height)
                                }
                            }
                        }
                    }
                    
                        HStack{
                            if (vm.userModel != nil){
                                Picker(selection: Binding<String> (
                                    get: {vm.userModel!.weight },
                                    set: {vm.userModel!.weight = $0
                                        FirebaseManager.shared.firestore.collection("users").document(FirebaseManager.shared.auth.currentUser!.uid).updateData(["weight": $0])
                                    }),
                                       label: Text("Weight")) {
                                    ForEach(weightOptions.weightArray(), id: \.self ){ weight in
                                            Text(weight + " Ibs")
                                    }
                                }
                            }
                        }
                    HStack{
                        if (vm.userModel != nil){
                            Picker(selection: Binding<String> (
                                get: {vm.userModel!.agenda },
                                set: {vm.userModel!.agenda = $0
                                    FirebaseManager.shared.firestore.collection("users").document(FirebaseManager.shared.auth.currentUser!.uid).updateData(["agenda": $0])
                                }),
                                   label: Text("Fitness Agenda")) {
                                ForEach(fitnessAgenda, id: \.self ){ reason in
                                        Text(reason)
                                }
                            }
                        }
                           
                    }
                }
                
               
            }
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

//
//struct PersonalSettingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonalSettingsView()
//    }
//}

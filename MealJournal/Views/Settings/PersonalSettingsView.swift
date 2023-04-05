//
//  PersonalSettingsView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 6/2/22.
//

import SwiftUI
import UIKit
import SwiftUIX


struct PersonalSettingsView: View {
    
    @ObservedObject var vm: DashboardLogic  //call to viewModel
    @State  var currentUserEmail = FirebaseManager.shared.auth.currentUser?.email
    var exercisePreferenceForUser = ExercisePreferenceForUser()
    @State  var email: String = ""
    @State  var password: String = ""
    @State var name: String = ""
    @State  var userBio: String = ""
    @State  var showSuccessAlertForSettings = false
    @State  var gender = ""
    @State  var weight = ""
    //@State private var height: String = ""
    @State  var agenda: String = ""
    @State  var userInstagramHandle = "" // << instagram
    @Binding var deleteAccountSheet: Bool
   // **** Picker Options ****
     var weightOptions = getWeight() //calls function that calculates weight up to 700ibs
     var fitnessAgenda = ["Bulking", "Cutting", "Maintain"]
     var genderOptions = ["Male", "Female", "Other"]
     var heightOptions = ["4'0", "4'1","4'2","4'3", "4'4", "4'5","4'6","4'7","4'8","4'9","4'10","4'11","5'0","5'1", "5'2", "5'3", "5'4", "5'5","5'6","5'7","5'8","5'9","5'10","5'11","6'0","6'1","6'2","6'3","6'4","6'5","6'6","6'7","6'8","6'9","6'10","6'11","7'0","7'1","7'2"]
    
    //  resets when view appears, keeps track of user changes without saving to model
    @State var tempName = ""
    @State var tempHeight = ""
    @State var tempWeight = ""
    @State var tempAgenda = ""
    @State var tempBio = ""
    
    @Environment(\.dismiss) var dismiss
    @State var originalName = ""
    @State var originalBio = ""
    
    @State var selectedExercises = [""]
    @State var originalHeightValue = ""
    @State var originalWeightValue = ""
    @State var originalSocialLink = ""
    @State var originalAgenda = ""
    @State var originalExercisePreferences = [""]
    @State var pickerID = 0
    
    @State var isFocused = false
    
    func isValidInstagramLink(_ link: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: #"^https?://(www\.)?instagram\.com/[a-zA-Z0-9_]+/?$"#, options: [])
        return regex.firstMatch(in: link, options: [], range: NSRange(location: 0, length: link.utf16.count)) != nil
    }
    
    
    var body: some View {
        
        NavigationView{
            Form{
                Section(header: Text("Personal Settings").foregroundColor(.blue).font(.title3)
                            .foregroundColor(.black)
                            .font(.body)
                            .textCase(nil))
                {
//                        HStack{
//                            //email Update
//                            Image(systemName: "person.fill")
//                                .foregroundColor(Color("ButtonTwo"))
//                                .frame(width: 20, height: 20)
//                            TextField(currentUserEmail ?? "User Email", text: $email)
//                                .submitLabel(.done)
//                            //update firestore with new email
//                                .onSubmit {
//                                    if(email != currentUserEmail) {
//                                        //UPDATE USER IN AUTH
//                                        FirebaseManager.shared.auth.currentUser?.updateEmail(to: email){ err in
//                                            if let err = err {
//                                                print(err)
//                                            }
//                                            //IF GOOD, WE UPDATE THE COLLECTION VALUE OF EMAIL AS WELL
//                                            FirebaseManager.shared.firestore
//                                                .collection("users")
//                                                .document(FirebaseManager.shared.auth.currentUser!.uid)
//                                                .collection("privateUserInfo")
//                                                .document("private")
//                                                .updateData(["email": email])
//
//                                            showSuccessAlertForSettings.toggle()
//                                            print("user email updated")
//                                        }
//                                    }
//                                }
//                        }
                        
                    UpdatePersonalSettingsHStack(vm: vm, name: $name, bio: $userBio, tempBio: tempBio, newName: tempName, isFocused: $isFocused )
                       
                    //social media link, preferred instagram
                    HStack{
                        Image(systemName: "camera")
                            .foregroundColor(Color("ButtonTwo"))
                            .padding(.trailing, 5)
                            
                        TextField(vm.userModel?.userSocialLink ?? "Link unavailable", text: $userInstagramHandle)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    //standard alert for settings update
                    .alert(isPresented: $showSuccessAlertForSettings, content: {
                        Alert(title: Text("Settings Updated"),
                               message: Text(""), dismissButton:
                                    .default(Text("Got it")))
                    })
             }
                
                Section(header: Text("Health Stats").foregroundColor(.blue).font(.title3)
                            .foregroundColor(.black)
                            .font(.body)
                            .textCase(nil)){
            
                    HStack{
                        if (vm.userModel != nil){
                            Picker(selection: Binding<String> (
                                get: {tempHeight },
                                set: {tempHeight = $0
                                    pickerID += 1
                                }),
                                   label: Text("Height")) {
                                ForEach(heightOptions, id: \.self ){ height in
                                        Text(height)
                                }
                            } // bug in swiftUI where picker wasn't updating, the id manually refreshes picker, allowing for the change
                                   .id(pickerID)
                        }
                    }
//                    .onTapGesture {
//                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
//                        isFocused = false // << reset color in bio textEditor
//                    }
                        HStack{
                            if (vm.userModel != nil){
                                Picker(selection: Binding<String> (
                                    get: {tempWeight },
                                    set: {tempWeight = $0
                                        pickerID += 1
                                    }),
                                       label: Text("Weight")) {
                                    ForEach(weightOptions.weightArray(), id: \.self ){ weight in
                                            Text(weight + " Ibs")
                                    }
                                }
                                       .id(pickerID)
                            }
                        }
                    HStack{
                        if (vm.userModel != nil){
                            Picker(selection: Binding<String> (
                                get: {tempAgenda },
                                set: {tempAgenda = $0
                                    pickerID += 1
                                }),
                                   label: Text("Fitness Agenda")) {
                                ForEach(fitnessAgenda, id: \.self ){ reason in
                                        Text(reason)
                                }
                            }
                                   .id(pickerID)
                        }
                           
                    }
                                
                }
               
                    Section(header: Text("Exercise Preferences").foregroundColor(.blue).font(.title3)
                                .foregroundColor(.black)
                                .font(.body)
                                .textCase(nil)) {
                        VStack(alignment: .center) { // add spacing between views
                            ExercisePreferenceSettingsTab(tags: exercisePreferenceForUser.exercises, selectedExercises: $selectedExercises)
                               
                        }
                        .padding(.bottom, 325)
                    }
                   // Spacer()
                                
                Text("Delete Profile")
                    .foregroundColor(.red)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .onTapGesture {
                        deleteAccountSheet = true
                    }
                  
            }
            .blur(radius: deleteAccountSheet ? 2 : 0) // blur when bottomsheet open
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading){
                    Button {
                       dismiss()
                    } label: {
                        Text("Back")
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing){
                    Button {
                      
                        // height picker
                        if tempHeight != originalHeightValue {
                            FirebaseManager.shared.firestore.collection("users").document(FirebaseManager.shared.auth.currentUser!.uid).updateData(["height": vm.userModel?.height])
                            vm.userModel?.height = tempHeight
                            showSuccessAlertForSettings.toggle()
                        }
                        // weight picker
                        else if (vm.userModel?.weight != originalWeightValue){
                            FirebaseManager.shared.firestore.collection("users").document(FirebaseManager.shared.auth.currentUser!.uid).updateData(["weight": vm.userModel?.weight])
                            showSuccessAlertForSettings.toggle()
                        }
                        //agenda
                        else if (vm.userModel?.agenda != originalAgenda) {
                            FirebaseManager.shared.firestore.collection("users").document(FirebaseManager.shared.auth.currentUser!.uid).updateData(["agenda": vm.userModel?.agenda])
                            showSuccessAlertForSettings.toggle()
                        }
                        
                        else if (selectedExercises != originalExercisePreferences){
                            vm.userModel?.exercisePreferences = selectedExercises
                            FirebaseManager.shared.firestore.collection("users").document(FirebaseManager.shared.auth.currentUser!.uid)
                                .updateData(["exercisePreferences": vm.userModel?.exercisePreferences])
                            showSuccessAlertForSettings.toggle()
                        }
                        
                        else if (name != originalName){
                            FirebaseManager.shared.firestore.collection("users").document(FirebaseManager.shared.auth.currentUser!.uid).updateData(["name": name])
                            vm.userModel?.name = name
                            showSuccessAlertForSettings.toggle()
                        }
                        
                        else if (userBio != originalBio){
                            if (tempBio.count) > 150{
                              print("showing fail alert")
                            }
                            else{
                                FirebaseManager.shared.firestore.collection("users").document(FirebaseManager.shared.auth.currentUser!.uid).updateData(["userBio": userBio])
                                vm.userModel?.userBio = userBio
                                   showSuccessAlertForSettings.toggle()
                            }
                        }
                        
                        else if(userInstagramHandle != originalSocialLink){
                            if isValidInstagramLink(userInstagramHandle){
                                FirebaseManager.shared.firestore.collection("users").document(FirebaseManager.shared.auth.currentUser!.uid).updateData(["userSocialLink": userInstagramHandle])
                                vm.userModel?.userSocialLink = userInstagramHandle
                                showSuccessAlertForSettings.toggle()
                            }
                            else{
                              print("social link returned not valid")
                            }
                        }
                       
                        
                    } label: {
                        Text("Save Changes")
                    }
                }
             
            }
           
        }
        .windowOverlay(isKeyAndVisible: self.$deleteAccountSheet, {
            GeometryReader { geometry in {
                BottomSheetView(
                    isOpen: self.$deleteAccountSheet,
                    maxHeight: geometry.size.height * 0.5 * 0.7, minHeight: geometry.size.height * 0.5 * 0.7
                ) {
                    DeleteProfileView(deleteSuccess: $deleteAccountSheet)
                        .frame(maxWidth: .infinity)
                        .background(Color("LightWhite"))
                       Spacer()
                        .onTapGesture{
                            self.deleteAccountSheet = false
                        }
                }

            }()
                    .edgesIgnoringSafeArea(.all)

            }

        })
        //work around to dismiss keyboard from editors
        .gesture(DragGesture().onChanged{_ in UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)})
        
        .onAppear{
          
            self.originalName = vm.userModel?.name ?? ""
            self.originalBio = vm.userModel?.userBio ?? ""
            
            self.tempName = vm.userModel?.name ?? ""
            self.tempHeight = vm.userModel?.height ?? ""
            self.tempWeight = vm.userModel?.weight ?? ""
            self.tempAgenda = vm.userModel?.agenda ?? ""
            
            selectedExercises = vm.userModel?.exercisePreferences ?? [""]
            self.originalHeightValue = vm.userModel?.height ?? ""
            self.originalWeightValue = vm.userModel?.weight ?? ""
            self.originalAgenda = vm.userModel?.agenda ?? ""
            self.originalExercisePreferences = vm.userModel?.exercisePreferences ?? [""]
            self.originalSocialLink = vm.userModel?.userSocialLink ?? ""
        }
    }
       
}


struct PersonalSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        PersonalSettingsView(vm: DashboardLogic(), deleteAccountSheet: .constant(false))
    }
}

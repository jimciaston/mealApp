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
    @State var healthSettingsPrivate: String = ""
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
    @State var tempHealthSettingsPrivate = ""
    @Environment(\.dismiss) var dismiss
    @State var originalName = ""
    @State var originalBio = ""
    @State var bioExceedsCharLimit = false
    @State var selectedExercises = [""]
    @State var originalHeightValue = ""
    @State var originalHealthSettings = ""
    @State var originalWeightValue = ""
    @State var originalSocialLink = ""
    @State var originalAgenda = ""
    @State var originalExercisePreferences = [""]
    @State var pickerID = 0
    @FocusState var isKeyboardFocused: Bool
    @State var isFocused = false
    @State private var isToggleOn = false
    @State private var isPopoverPresented = false
    
    var healthPrivateOptions = ["Yes", "No"]
    @State private var selectionIndex = 0
    func isValidInstagramLink(_ link: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: "^(https?:\\/\\/)?(www\\.)?instagram\\.com\\/[a-zA-Z0-9_\\.]+\\/?$", options: [])
        return regex.firstMatch(in: link, options: [], range: NSRange(location: 0, length: link.utf16.count)) != nil
    }
    
    
    var body: some View {
        
        NavigationView{
            Form{
                Section(header: Text("Personal Settings").foregroundColor(.blue).font(.title3)
                            .foregroundColor(Color("graySettingsPillbox"))
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
                        
                    UpdatePersonalSettingsHStack(vm: vm, name: $name, bio: $userBio, tempBio: tempBio, newName: tempName, isUserBioValid: $bioExceedsCharLimit, isFocused: $isFocused )
                       
                       
                    //social media link, preferred instagram
                    HStack{
                        Image(systemName: "camera")
                            .foregroundColor(Color("ButtonTwo"))
                            .padding(.trailing, 5)
                            
                        TextField(vm.userModel?.userSocialLink ?? "Link unavailable", text: $userInstagramHandle)
                            .focused($isKeyboardFocused)
                            .submitLabel(.done)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    
                    //standard alert for settings update
                    .alert(isPresented: $showSuccessAlertForSettings, content: {
                        Alert(title: Text("Settings Updated"),
                               message: Text(""), dismissButton:
                                    .default(Text("Got it")))
                    })
             }
                
                Section(header: HStack {
                            Text("Health Stats")
                                .foregroundColor(.blue)
                                .font(.title3)
                                .textCase(nil)
                            Image(systemName: "info.circle")
                                .foregroundColor(.blue)
                                .font(.title3)
                                .onTapGesture {
                                    isPopoverPresented = true
                                }
                                .popover(isPresented: $isPopoverPresented, content: {
                                   
                                        Text("Privacy Notice")
                                            .foregroundColor(.black)
                                            .font(.title3)
                                            .textCase(nil)
                                            .padding(.bottom, 10)
                                        Text("We collect your height and weight to help allow other users with similar body types to find you on our platform. This information is always kept private by default and can be toggled on and off at any time. \n\n Your health settings if searchable, will only show up on our search page. They will never be made public on your actual profile page for now. \n\n We take your privacy very seriously, and we will never share your personal information with anyone without your explicit consent.")
                                            .foregroundColor(.black)
                                            .padding(.all, 15)
                                            .background(Color.white)
                                            .cornerRadius(10)
                                            .shadow(color: Color.black.opacity(0.1), radius: 20, x: 0, y: 0)
                                    
                                })
                        }){
            
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
                                HStack {
                                    if (vm.userModel != nil) {
                                        Picker(selection: Binding<String> (
                                            get: {tempHealthSettingsPrivate },
                                            set: {tempHealthSettingsPrivate = $0
                                                pickerID += 1
                                            }), label: Text("Keep fitness stats private")) {
                                                ForEach(healthPrivateOptions, id: \.self) { privacyConfirmation in
                                                Text(privacyConfirmation) // yes or no
                                                    
                                            }
                                        }
                                         
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
                            FirebaseManager.shared.firestore.collection("users").document(FirebaseManager.shared.auth.currentUser!.uid).updateData(["height": tempHeight])
                            vm.userModel?.height = tempHeight
                            showSuccessAlertForSettings.toggle()
                        }
                        // weight picker
                       if (tempWeight != originalWeightValue){
                            FirebaseManager.shared.firestore.collection("users").document(FirebaseManager.shared.auth.currentUser!.uid).updateData(["weight": tempWeight])
                            vm.userModel?.weight = tempWeight
                            showSuccessAlertForSettings.toggle()
                        }
                        //agenda
                        if (vm.userModel?.agenda != originalAgenda) {
                            FirebaseManager.shared.firestore.collection("users").document(FirebaseManager.shared.auth.currentUser!.uid).updateData(["agenda": vm.userModel?.agenda])
                            showSuccessAlertForSettings.toggle()
                        }
                        
                       if (selectedExercises != originalExercisePreferences){
                            vm.userModel?.exercisePreferences = selectedExercises
                            FirebaseManager.shared.firestore.collection("users").document(FirebaseManager.shared.auth.currentUser!.uid)
                                .updateData(["exercisePreferences": vm.userModel?.exercisePreferences])
                            showSuccessAlertForSettings.toggle()
                        }
                        
                        if (name != originalName){
                            FirebaseManager.shared.firestore.collection("users").document(FirebaseManager.shared.auth.currentUser!.uid).updateData(["name": name])
                            vm.userModel?.name = name
                            showSuccessAlertForSettings.toggle()
                        }
                        
                        if (userBio != originalBio){
                            if (!bioExceedsCharLimit){
                              print("showing fail alert")
                            }
                            else{
                                FirebaseManager.shared.firestore.collection("users").document(FirebaseManager.shared.auth.currentUser!.uid).updateData(["userBio": userBio])
                                vm.userModel?.userBio = userBio
                                   showSuccessAlertForSettings.toggle()
                            }
                        }
                        if (tempHealthSettingsPrivate != originalHealthSettings){
                                FirebaseManager.shared.firestore.collection("users").document(FirebaseManager.shared.auth.currentUser!.uid).updateData(["healthSettingsPrivate": tempHealthSettingsPrivate])
                                vm.userModel?.healthSettingsPrivate = tempHealthSettingsPrivate
                                   showSuccessAlertForSettings.toggle()
                            
                        }
                        if(userInstagramHandle != originalSocialLink){
                            if isValidInstagramLink(userInstagramHandle){
                                FirebaseManager.shared.firestore.collection("users").document(FirebaseManager.shared.auth.currentUser!.uid).updateData(["userSocialLink": userInstagramHandle])
                                vm.userModel?.userSocialLink = userInstagramHandle
                                showSuccessAlertForSettings.toggle()
                            }
                            else{
                              print("No results returned")
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
            print(vm.userModel?.weight)
            self.originalName = vm.userModel?.name ?? ""
            self.originalBio = vm.userModel?.userBio ?? ""
            
            self.originalHealthSettings = vm.userModel?.healthSettingsPrivate ?? ""
            self.tempHealthSettingsPrivate = vm.userModel?.healthSettingsPrivate ?? ""
            
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

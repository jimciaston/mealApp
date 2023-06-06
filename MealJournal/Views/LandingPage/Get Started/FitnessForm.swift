//
//  FitnessForm.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/1/22.
//

import SwiftUI
import Firebase

struct FitnessForm: View {
    @Environment (\.dismiss) var dismiss
    @Environment (\.colorScheme) var colorScheme
    @StateObject var signUpController = LandingPageViewModel()
    var exercisePreferences = ExercisePreferenceForUser()
    @StateObject var vm = DashboardLogic()
    @AppStorage("signedIn") var signedIn = false
    @State private var userSignedIn = false
    @Environment(\.managedObjectContext) var moc
    @State var selectedExercises: [String] = []
    //getting info from previous sign up view
    @Binding var name: String
    @Binding var userEmailAddress: String
    @Binding var userLoginPassword: String
    @State private var healthSettingsPrivate = true // << if weight and height are shown
    var healthOptionsPrivate = ["Yes", "No"]
    @State private var selectionIndex = 0
    @State var showingGetStartedPopUp = false //tied to continue, show popup on true
    //options for picker
    @State private var selectedGender = ""
    @State private var selectedHeight = ""
    @State private var selectedWeight = ""
    @State private var agenda = "" //bulking, cutting , or maintaoinin
    @State var pickerVisible: Bool = false
    private var weightOptions = getWeight()
    private var fitnessAgenda = ["Bulking", "Cutting/Weight Loss", "Maintain", "Casual Health"]
    private var genderOptions = ["Male", "Female", "Non-binary/non-comforming", "Transgender", "Prefer not to respond"]
    private var heightOptions = ["4'0", "4'1","4'2","4'3", "4'4", "4'5","4'6","4'7","4'8","4'9","4'10","4'11","5'0","5'1", "5'2", "5'3", "5'4", "5'5","5'6","5'7","5'8","5'9","5'10","5'11","6'0","6'1","6'2","6'3","6'4","6'5","6'6","6'7","6'8","6'9","6'10","6'11","7'0","7'1","7'2"]
    
    //sets color of picker in selected
    init(name: Binding <String>, userEmailAddress: Binding <String>, userLoginPassword: Binding <String> ) {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Color("UserProfileCard2"))
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        UITableView.appearance().backgroundColor = .clear
        
        //iniatlize firebase
       
        //iniatilizes the binding , error if we take these out
        self._name = name
        self._userEmailAddress = userEmailAddress
        self._userLoginPassword = userLoginPassword
       
    }
   
    //moves button offset when picker dropdown occurs
    func isPickerVisible() -> Int{
        if pickerVisible {
            return 200
        }else{
            return 25
        }
    }

    
    var body: some View {
        //only run is user is SignedIn
        if(!userSignedIn){
            NavigationView{
                VStack{
                        Form {
                            Picker(selection: $selectedGender, label: Text("Gender")){
                                ForEach(genderOptions, id: \.self){ gender in
                                    Text(gender)
                                }
                            }
                            
                            Picker(selection: $selectedHeight, label: Text("Height (optional)")){
                                ForEach(heightOptions, id: \.self){ height in
                                    Text(height)
                                }
                            }
                            HStack{
                                Text("Weight (optional)")
                                     Picker(selection: $selectedWeight,label: Text("")){
                                         ForEach(weightOptions.weightArray(), id: \.self){weight in
                                             Text(weight + " Ibs")
                                         }
                                         .pickerStyle(WheelPickerStyle())
                                 }
                            }
                         
                            //highlight selection
                            Text("Diet Goals") //.listSectionSeparator(.hidden)
                                .padding(.top, 15)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .multilineTextAlignment(.center)
                                .listRowSeparator(.hidden)
                           
                            Picker("", selection: $agenda){
                                ForEach(fitnessAgenda, id: \.self) {
                                        Text($0)
                                        
                                    }
                                }
                                .clipped()
                                .pickerStyle(.segmented)
                                .navigationBarTitle(Text("Fitness Stats"))
                                .frame(height:50)
                            FitnessInterests(selectedExercises: $selectedExercises, exercises: exercisePreferences.exercises)
                                .frame(height: 350)
                                .padding(.bottom, -25)
                            
                            Button(action: {
                                    if(Auth.auth().currentUser?.email != nil){
                                        vm.fetchCurrentUser() //fetches current user
                                       //check if user is signed in
                                        userSignedIn = true
                                        
                                        // format date
                                        let date = Date()
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                                        let dateString = dateFormatter.string(from: date)
                                        
                                        
                                        //save user to Firebase
                                        LandingPageViewModel.storeUserInfomation(uid: Auth.auth().currentUser!.uid, email: userEmailAddress, name: name, height: selectedHeight, weight: selectedWeight, gender: selectedGender, agenda: agenda, dateJoined: dateString, exercisePreferences: selectedExercises, healthSettingsPrivate: "No")
                                            signedIn = true //updates storage container
                                          
                                    }
                                
                            })
                            {
                                Text("Complete Profile").bold()
                                    .padding([.leading, .trailing], 25)
                                    .foregroundColor(.white)
                                    .padding(10)
                                    .background(Color("ButtonTwo"))
                                    .font(.title3)
                                  .cornerRadius(5)
                                   
                                   // .offset(y:CGFloat(isPickerVisible()))
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    
                            }
                         
                            .padding(.top, 20)
                            .listRowSeparator(.hidden)
                            .fullScreenCover(isPresented: $userSignedIn){
                                UserDashboardView(vm: vm, signUpController: signUpController, dashboardRouter: DashboardRouter())
                            }
                            Button(action: {
                                if(Auth.auth().currentUser?.email != nil){
                                    userSignedIn = true
                                    vm.fetchCurrentUser() //fetches current user
                                   //check if user is signed in
                                   
                                    let date = Date()
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
                                    let dateString = dateFormatter.string(from: date)
                                    //save user to Firebase
                                    LandingPageViewModel.storeUserInfomation(uid: Auth.auth().currentUser!.uid, email: userEmailAddress, name: name, height: selectedHeight, weight: selectedWeight, gender: selectedGender, agenda: agenda, dateJoined: dateString, exercisePreferences: selectedExercises, healthSettingsPrivate: "No")
                                        signedIn = true //updates storage container
                              
                                }
                            }){
                                Text("Finish later")
                                    .foregroundColor(.blue)
                                    .padding()

                                    .font(.body)
                                    .padding(.top, -15)
                                    .padding(.bottom, 20)
                                    .cornerRadius(5)
                                   // .offset(y:CGFloat(isPickerVisible()))
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                  
                }
              
               .animation(.easeIn(duration: 2.50), value: showingGetStartedPopUp)
              
            }
            .ignoresSafeArea(.all)
            .blur(radius: showingGetStartedPopUp ? 2 : 0) // blur if popUp is Up
            .navigationViewStyle(.stack)
            
                //Notice pop up
            .popup(isPresented: $showingGetStartedPopUp) { // 3
                VStack{
                    ZStack { // 4
                        Color("LighterWhite")
                         GetStartedPopUpContent()
                    }
                    .frame(width: 350, height: 450)
                    .cornerRadius(25)
                    .shadow(color: Color("LighterWhite") ,radius: 2, x: 0, y: 4)
                }
            }
               // delay pop up
            .task{
                do{
                    // 1 nano = 1 second
                    try? await Task.sleep(nanoseconds: 1_000_000_000)
                    showingGetStartedPopUp = true
                }
            }
            //Overlay allows to not allow user to click while pop up is up
            .overlay{
                    if showingGetStartedPopUp {
                        Color.white.opacity(0.001)
                        .ignoresSafeArea()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .onTapGesture {
                            showingGetStartedPopUp = false
                        }
                    }
            }
                     
        
        }
    
       
    }
       
        
}



struct FitnessForm_Previews: PreviewProvider {
    static var previews: some View {
        FitnessForm(name: .constant("Bill"), userEmailAddress: .constant("1@aol.com"), userLoginPassword: .constant("Jm"))
    }
}


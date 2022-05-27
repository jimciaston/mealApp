//
//  FitnessForm.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/1/22.
//

import SwiftUI
import Firebase

struct FitnessForm: View {
    
    @StateObject var signUpController = SignUpController()
   
    @State private var userSignedIn = false
    @Environment(\.managedObjectContext) var moc
    
    //getting info from previous sign up view
    @Binding var userFirstName: String
    @Binding var userLastName: String
    @Binding var userEmailAddress: String
    @Binding var userLoginPassword: String
    
    public var signUpCompleted = false
    
    //options for picker
    @State private var selectedGender = ""
    @State private var selectedHeight = ""
    @State private var selectedWeight = ""
    @State private var agenda = "" //bulking, cutting , or maintaoinin
    @State var pickerVisible: Bool = false
    
    private var fitnessAgenda = ["Bulking", "Cutting", "Maintain"]
    private var genderOptions = ["Male", "Female", "Other"]
    private var heightOptions = ["4'0", "4'1","4'2","4'3", "4'4", "4'5","4'6","4'7","4'8","4'9","4'10","4'11","5'0","5'1", "5'2", "5'3", "5'4", "5'5","5'6","5'7","5'8","5'9","5'10","5'11","6'0","6'1","6'2","6'3","6'4","6'5","6'6","6'7","6'8","6'9","6'10","6'11","7'0","7'1","7'2"]
    
    //sets color of picker in selected
    init(userFirstName: Binding <String>, userLastName: Binding <String>, userEmailAddress: Binding <String>, userLoginPassword: Binding <String> ) {
        UISegmentedControl.appearance().selectedSegmentTintColor = .orange
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        UITableView.appearance().backgroundColor = .clear
        
        //iniatlize firebase
       
        //iniatilizes the binding , error if we take these out
        self._userFirstName = userFirstName
        self._userLastName = userLastName
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
   
    private var weightOptions = getWeight()
    var body: some View {
    NavigationView{
        ZStack{
                Form{
                    HStack{
                        Text("Gender")
                        Picker("", selection: $selectedGender){
                            ForEach(genderOptions, id: \.self){ gender in
                                Text(gender)
                            }
                    }
                    }
                    Picker(selection: $selectedHeight, label: Text("Height")){
                        ForEach(heightOptions, id: \.self){ height in
                            Text(height)
                        }
                    }
                    HStack{
                        Text("Weight")
                             Picker(selection: $selectedWeight,label: Text("")){
                                 ForEach(weightOptions.weightArray(), id: \.self){weight in
                                     Text(weight + " Ibs")
                                 }
                                 .pickerStyle(WheelPickerStyle())
                            // .frame(width:300, height:100)
                                
                         }
                    }
                   
                    //highlight selection
                    Text("Why are you eating?") //.listSectionSeparator(.hidden)
                        .padding()
                        .frame(width:300, height: 5 )
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
                    }
            Button(action: {
                
                    if(Auth.auth().currentUser?.email != nil){
                       //check if user is signed in
                        userSignedIn = true
                        print("user  signed in")
                       
                    }
                else{
                    print("user is not signed in")
                   
                   
                }
                
            })
            {
                NavigationLink("", destination: UserDashboardView(signUpController: signUpController), isActive: $userSignedIn)
                
                Text("Finish Me Off Baby")
                    .frame(width: 150)
                    .foregroundColor(.white)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [.orange, .pink]), startPoint: .leading, endPoint: .bottom))
                    .font(.title3)
                    .background(.clear)
                    .cornerRadius(5)
                    .offset(y:CGFloat(isPickerVisible()))
            }
           
//            NavigationLink(destination: UserDashboardView().navigationBarHidden(true)){
//
//                Button(""){
////                    let newUser = User(context: moc)
////                    newUser.id = UUID()
////                    newUser.email = userEmailAddress
////                    newUser.firstName = userFirstName
////                    newUser.goals = agenda
////                    newUser.height = selectedHeight
////                    newUser.lastName = userLastName
////                    newUser.password = userLoginPassword
////                    newUser.weight = selectedWeight
////
////                    try? moc.save()
//                    print("balls")
//                    createNewUserAccount(userEmail: userEmailAddress, userPassword: userLoginPassword)
//
//                }
//                Text("Finish Up")
//                   .frame(width: 150)
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(LinearGradient(gradient: Gradient(colors: [.orange, .pink]), startPoint: .leading, endPoint: .bottom))
//                    .font(.title3)
//                    .background(.clear)
//                    .cornerRadius(5)
//                    .offset(y:CGFloat(isPickerVisible()))
//                    }
                }
        
            } .offset(y:20) //moves down form
        
            .navigationViewStyle(.stack)
       
    }
        
}

//private func createNewUserAccount(userEmail: String, userPassword: String) {
//    Auth.auth().createUser(withEmail: userEmail, password: userPassword){ result, err in
//        if let err = err {
//            print("Failed to create user " , err)
//            return
//        }
//        print("Succesfully created user: \(result?.user.uid ?? "")")
//    }
//}


//
//struct FitnessForm_Previews: PreviewProvider {
//    static var previews: some View {
//        FitnessForm(userFirstName: .constant("dummy string"))
//    }
//}


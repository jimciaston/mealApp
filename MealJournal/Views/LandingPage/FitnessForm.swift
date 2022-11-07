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
    @StateObject var vm = DashboardLogic()
    @AppStorage("signedIn") var signedIn = false
 
    @Environment(\.managedObjectContext) var moc
    
    //getting info from previous sign up view
    @Binding var name: String
    @Binding var userEmailAddress: String
    @Binding var userLoginPassword: String
    
    public var signUpCompleted = false
    
    //options for picker
    @State private var selectedGender = ""
    @State private var selectedHeight = ""
    @State private var selectedWeight = ""
    @State private var agenda = "" //bulking, cutting , or maintaoinin
    @State var pickerVisible: Bool = false
    private var weightOptions = getWeight()
    private var fitnessAgenda = ["Bulking", "Cutting", "Maintain"]
    private var genderOptions = ["Male", "Female", "Other"]
    private var heightOptions = ["4'0", "4'1","4'2","4'3", "4'4", "4'5","4'6","4'7","4'8","4'9","4'10","4'11","5'0","5'1", "5'2", "5'3", "5'4", "5'5","5'6","5'7","5'8","5'9","5'10","5'11","6'0","6'1","6'2","6'3","6'4","6'5","6'6","6'7","6'8","6'9","6'10","6'11","7'0","7'1","7'2"]
    
    //sets color of picker in selected
    init(name: Binding <String>, userEmailAddress: Binding <String>, userLoginPassword: Binding <String> ) {
        UISegmentedControl.appearance().selectedSegmentTintColor = .orange
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
    NavigationView{
        ZStack{
                Form{
                        Picker(selection: $selectedGender, label: Text("Gender")){
                            ForEach(genderOptions, id: \.self){ gender in
                                Text(gender)
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
            VStack{
                Button(action: {
                    signedIn = true
                }){
                    Text("Finish later").bold()
                        .foregroundColor(.blue)
                        
                        .padding()
                        .background(.clear)
                        .font(.title3)
                        .background(.clear)
                        .cornerRadius(5)
                        .offset(y:CGFloat(isPickerVisible()))
                }
                .padding(.bottom, 25)
                Button(action: {
                        if(Auth.auth().currentUser?.email != nil){
                            vm.fetchCurrentUser() //fetches current user
                            //save user to Firebase
                            SignUpController.storeUserInfomation(uid: Auth.auth().currentUser!.uid, email: userEmailAddress, name: name, height: selectedHeight, weight: selectedWeight, gender: selectedGender, agenda: agenda)
                            
                                signedIn = true //updates app storage container
                        }
                    
                })
                {
                    Text("Complete Profile")
                        .padding([.leading, .trailing], 25)
                        .foregroundColor(.white)
                        .padding()
                        .background(.pink)
                        .font(.title3)
                        .background(.clear)
                        .cornerRadius(10)
                        .offset(y:CGFloat(isPickerVisible()))
                    
                }
                .fullScreenCover(isPresented: $signedIn){
                    UserDashboardView(vm: vm, signUpController: signUpController)
                }
            }
            
          
        }
    
    } .offset(y:20) //moves down form
        
.navigationViewStyle(.stack)
       
    }
        
}



struct FitnessForm_Previews: PreviewProvider {
    static var previews: some View {
        FitnessForm(name: .constant("Bill"), userEmailAddress: .constant("1@aol.com"), userLoginPassword: .constant("Jm"))
    }
}


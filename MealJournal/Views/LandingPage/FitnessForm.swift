//
//  FitnessForm.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/1/22.
//

import SwiftUI

struct FitnessForm: View {
    @State var selectedGenderIndex: Int = 0
    @State var selectedHeightIndex: Int = 0
    @State var selectedWeightIndex: Int = 0
    @State private var agenda = ""
    public var signUpCompleted = false
    @State var pickerVisible: Bool = false
    @State private var fitnessAgenda = ["Bulking", "Cutting", "Maintain"]
   
    private var genderOptions = ["Male", "Female", "Other"]
    private var heightOptions = ["4'0", "4'1","4'2","4'3", "4'4", "4'5","4'6","4'7","4'8","4'9","4'10","4'11","5'0","5'1", "5'2", "5'3", "5'4", "5'5","5'6","5'7","5'8","5'9","5'10","5'11","6'0","6'1","6'2","6'3","6'4","6'5","6'6","6'7","6'8","6'9","6'10","6'11","7'0","7'1","7'2"]
    
   // @Environment (\.managedObjectContext) var moc
  //  @Environment (\.dismiss) var dismiss
    
    //sets color of picker in selected
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = .orange
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        UITableView.appearance().backgroundColor = .clear
    }
   
    //moves button offset when picker dropdown occurs
    
    func isPickerVisible() -> Int{
        if pickerVisible {
            return 200
        }else{
            return 25
        }
    }
    func saveUser(){
       // try? moc.save()
    }
  
    private var weightOptions = getWeight()
    var body: some View {
    NavigationView{
        ZStack{
                Form{
                    HStack{
                        Text("Gender")
                        Picker("", selection: $selectedGenderIndex){
                            ForEach(0..<genderOptions.count, id: \.self){
                                Text(self.genderOptions[$0])
                            }
                    }
                    }
                    Picker(selection: $selectedHeightIndex,label: Text("Height")){
                        ForEach(0..<heightOptions.count){
                            Text(self.heightOptions[$0]).tag($0)
                        }
                    }
                    HStack{
                        Text("Weight")
                             Picker(selection: $selectedWeightIndex,label: Text("")){
                                 ForEach(0..<weightOptions.weightArray().count){
                                     Text(weightOptions.weightArray()[$0]+" Ibs")
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
            
            NavigationLink(destination: UserDashController().navigationBarHidden(true)){
                Button(""){
                    print("test it works")
                }
                Text("Finish Up")
                   .frame(width: 150)
                    .foregroundColor(.white)
                    .padding()
                    .background(LinearGradient(gradient: Gradient(colors: [.orange, .pink]), startPoint: .leading, endPoint: .bottom))
                    .font(.title3)
                    .background(.clear)
                    .cornerRadius(5)
                    .offset(y:CGFloat(isPickerVisible()))
                   
                    }
           
                }
            } .offset(y:20) //moves down form
        
            .navigationViewStyle(.stack)
    }
}


struct FitnessForm_Previews: PreviewProvider {
    static var previews: some View {
        FitnessForm()
    }
}


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
    @State var tempBio: String
    @State var showSuccessAlertForName = false
    @State var newName = ""
    @State var userBio = ""
    @State var isUserBioValid = true
    var charLimit = 150 // << character limit for user Bio
    
    //color in bio settings doesn't reset. IsFocused when user taps out of textEditor, will return to default color
    @Binding var isFocused: Bool
    func bioCharacterExceededBy() -> String{
        var charRemaining = charLimit - userBio.count
        if charRemaining == charLimit{
            isUserBioValid = true
        }
        return String(charRemaining)
    }
    
    
    var body: some View {
        HStack {
            Image(systemName: "person.crop.rectangle")
                .foregroundColor(Color("ButtonTwo"))
                .padding(.trailing, 5)
            TextField(name ?? "Name unavailable", text: $newName)
                .frame(maxWidth:.infinity, alignment: .leading) // expand to fill width
        }
        HStack {
                Image(systemName: "square.and.pencil")
                    .foregroundColor(Color("ButtonTwo"))
                   
                TextEditor(text: $userBio)
                    .foregroundColor(Color("textEditorDefault"))
                    .frame(minHeight: 20)
                        .fixedSize(horizontal: false, vertical: true)
                    .onTapGesture {
                        isFocused = true
                    }
                    .onChange(of: userBio) { newBio in
                        bio = newBio
                    }
            }

        .onAppear{
            userBio = vm.userModel?.userBio == "" ? "No bio entered" : vm.userModel?.userBio ?? "No bio entered";
        }
        if userBio.count > charLimit {
            Text(!isUserBioValid ? "Please shorten Bio by \(userBio.count - charLimit) characters" : "")
                .foregroundColor(.red)
                .font(.caption)
                .listRowSeparator(.hidden)
        }
       
           // .frame(height: isUserBioValid ? 15 : 0)
    }
}
//
//struct UpdatePersonalSettingsHStack_Previews: PreviewProvider {
//    static var previews: some View {
//        updatePersonalSettingsHStack()
//    }
//}

//
//  updatePersonalSettingsHStack.swift
//  MealJournal
//
//  Created by Jim Ciaston on 10/7/22.
//

import SwiftUI
import UIKit

struct TextViewWrapper: UIViewRepresentable {
    @Binding var text: String
    @Binding var isFocused: Bool
    @Binding var isUserBioValid: Bool
    let charLimit: Int
    
    func makeUIView(context: Context) -> UITextView {
        let textView = UITextView()
        textView.textColor = .lightGray
        textView.delegate = context.coordinator
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.autocapitalizationType = .sentences
        textView.isScrollEnabled = true
        textView.isEditable = true
        textView.isUserInteractionEnabled = true
        textView.backgroundColor = UIColor.clear
        return textView
    }
    
    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
        if isFocused {
            uiView.becomeFirstResponder()
        } else {
            uiView.resignFirstResponder()
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UITextViewDelegate {
        var parent: TextViewWrapper
        
        init(_ parent: TextViewWrapper) {
            self.parent = parent
        }
        
        func textViewDidChange(_ textView: UITextView) {
            parent.text = textView.text
            parent.isUserBioValid = textView.text.count <= parent.charLimit
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
            parent.isFocused = false
        }
        
        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if text == "\n" {
                textView.resignFirstResponder()
                return false
            }
            return true
        }
    }
}


struct UpdatePersonalSettingsHStack: View {
    @ObservedObject var vm: DashboardLogic
    @Binding var name: String
    @Binding var bio: String
    @State var tempBio: String
    @State var showSuccessAlertForName = false
    @State var newName: String
    @State var userBio = ""
    @State var userName = ""
    @Binding var isUserBioValid: Bool
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
            TextField(name ?? "Name unavailable", text: $userName)
                .frame(maxWidth:.infinity, alignment: .leading) // expand to fill width
                .foregroundColor(.gray)
                .onChange(of: userName) { updatedName in
                    name = updatedName
                }
        }
        HStack {
                Image(systemName: "square.and.pencil")
                    .foregroundColor(Color("ButtonTwo"))
                   
            TextViewWrapper(text: $userBio, isFocused: $isFocused, isUserBioValid: $isUserBioValid, charLimit: charLimit)
                       .foregroundColor(Color("textEditorDefault"))
                       .frame(minHeight: 80)
                       .fixedSize(horizontal: false, vertical: true)
                       .onTapGesture {
                           isFocused = true
                       }
                       .submitLabel(.done)
                    
                    .onChange(of: userBio) { newBio in
                        bio = newBio
                        isUserBioValid = newBio.count <= charLimit
                    
                    }
            }

        .onAppear{
            userBio = vm.userModel?.userBio == "" ? "No bio entered" : vm.userModel?.userBio ?? "No bio entered";
            userName = vm.userModel?.name == "" ? "No name entered" : vm.userModel?.name ?? "No name entered";
        }
        if userBio.count > charLimit {
            Text(!isUserBioValid ? "Please shorten bio by \(userBio.count - charLimit) characters" : "")
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

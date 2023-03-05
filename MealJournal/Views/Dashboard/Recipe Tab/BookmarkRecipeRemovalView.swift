//
//  BookmarkRecipeRemovalView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/16/23.
//

import SwiftUI

//struct BookmarkRecipeRemovalView: View {
//    @Binding var isRecipeSaved: Bool
//    @Environment(\.dismiss) var dismiss // << dismiss view
//    var body: some View {
//        VStack {
//          Text("Remove Recipe Bookmark?")
//            .font(.body)
//            .multilineTextAlignment(.center)
//            .padding()
//            HStack{
//                Button(action: {
//                    dismiss()
//                })
//                {
//                    Text("No")
//                        .font(.headline)
//                        .foregroundColor(.white)
//                }
//                .frame(width: 80, height: 50)
//                .background(Color.red)
//                .cornerRadius(10)
//                .padding()
//                //yes button
//                Button(action: {
//                    isRecipeSaved = true
//                    dismiss()
//                }) {
//                  Text("Yes")
//                    .font(.headline)
//                    .foregroundColor(.white)
//                    .padding()
//                }
//                .frame(width: 80, height: 50)
//                .background(Color.green)
//                .cornerRadius(10)
//                .padding()
//                .shadow(radius: 5)
//            }
//        
//        }
//        .background(Color.white)
//        .cornerRadius(10)
//        .padding()
//        .shadow(radius: 10)
//        .frame(width:355, height: 100)
//    }
//}
//
//struct BookmarkRecipeRemovalView_Previews: PreviewProvider {
//    static var previews: some View {
//        BookmarkRecipeRemovalView(isRecipeSaved: .constant(false))
//    }
//}

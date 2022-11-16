//
//  GetStartedPopUpContent.swift
//  MealJournal
//
//  Created by Jim Ciaston on 11/7/22.
//

import SwiftUI

struct GetStartedPopUpContent: View {
   
    var body: some View {
        VStack{
            ZStack{
                HStack {
                    Spacer()
                        Image(systemName: "xmark.circle")
                        
                        .foregroundColor(Color("ButtonTwo"))
                            .font(.system(size: 30)) //size of image
                            .padding(.trailing, 20)
                        }
                            Text("Important Notice")
                                .font(.title3)          
            }
          
            Text("") //just creates line separation
            Text("We ask these questions to allow users to search users of the same weight, height and gender. Dieting can be tough, but seeing others of similiar circumstance help.\n\n If you don't feel comfortable, please feel free to skip this step and continue to your profile ")
                .padding(.top, 25)
                .padding([.leading, .trailing], 25)
                .lineSpacing(15)
            Spacer()
                .font(.body)
               
        }
            
    }
}

struct GetStartedPopUpContent_Previews: PreviewProvider {
    static var previews: some View {
        GetStartedPopUpContent()
    }
}

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
            Text("Please be aware we ask about weight, height, and gender because this information enables us to connect users who have similar characteristics and offer support to each other during the dieting journey. \n\n If you prefer not to provide this information, please feel free to skip this step and proceed to your profile (you may add this information later on)")
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

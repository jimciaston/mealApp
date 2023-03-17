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
                HStack (){
                 
                        Image(systemName: "xmark.square")
                        .padding(.leading, -145)
                        .padding(.top, 25)
                        .foregroundColor(Color("ButtonTwo"))
                            .font(.system(size: 30)) //size of image
                          
                        }
              
                            Text("Important Notice")
                                .font(.title3)
                                .padding(.top, 25)
            }
          
            Text("") //just creates line separation
            Text("Please note we request information regarding your weight, height, and gender to facilitate the connection of users who share similar nutrition goals. \n\n We understand that this information may be sensitive, you  may choose to skip this step if you prefer. You may add this information to your profile at a later time.")
                .padding(.top, 25)
                .padding([.leading, .trailing], 25)
                .lineSpacing(10)
                
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

//
//  LandingPage.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/2/22.
//

import SwiftUI

struct LandingPage: View {
    @Environment (\.dismiss) var dismiss
    
    var body: some View {
        NavigationView{
            VStack{
                VStack{
                    Image("bodybuilding-1")
                        .resizable()
                        .renderingMode(.template)
                        .foregroundColor(.orange)
                        .frame(width:100, height:100)
                    Text("Welcome to Meal Journal")
                        .font(.title)
                        .padding()
                }
                .offset(y:-25)
                VStack{
                    NavigationLink(destination: createUserAccount().navigationBarHidden(true), label:{
                        Text("Get Started").fontWeight(.bold)
                        .frame(minWidth: 0, maxWidth: 200)
                        .padding(10)
                        .foregroundColor(.white)
                        .background(
                            RoundedRectangle(cornerRadius: 20)
                                .fill(
                                    LinearGradient(
                                        colors: [.orange, .yellow],
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )))
                        
                    }) 
                    
                    NavigationLink(destination: userLogin().navigationBarHidden(true), label: {
                        Text("Login").fontWeight(.semibold)
                            .frame(minWidth:0, maxWidth: 200)
                            .padding(10)
                            .foregroundColor(.black)
                            .overlay( RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.gray, lineWidth: 3)
                                )
                    })
                        .padding()
                }
               
            }
        
        }
    }
}
   
struct LandingPage_Previews: PreviewProvider {
    static var previews: some View {
        LandingPage()
    }
}

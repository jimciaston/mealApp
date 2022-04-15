//
//  SubscriptionView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 3/12/22.
//use in later update

import SwiftUI

struct SubscriptionPopUp: View {
    @Binding var show: Bool
    
    var body: some View {
        ZStack{
        if show {
            //sets background of userDash to black and opacity when showing
            Color.black.opacity(show ? 0.3 : 0).edgesIgnoringSafeArea(.all)
        VStack{
            HStack{
                Button(action: {
                    show = false
                }){
                    Image(systemName: "xmark")
                        .padding()
                        .font(.title2)
                        .foregroundColor(.black)
                }
               .padding(.leading, 250)
            }
                .frame(width:300)
            
            Text("Would you like to follow to Bradley Martin?")
                .multilineTextAlignment(.center)
                .padding()
                .foregroundColor(.black)
                .font(.title3)
                .padding(.top, -20)
            
                Button("Subscribe for Free"){
                //action
                }
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color("completeGreen")))
               
                .foregroundColor(.black)
                .font(.body)
                .padding(.bottom, 10)
                }
            .frame(maxWidth: 300)
            .border(Color.black, width: 2)
            .background(Color.white)
            }
        }
    }
}

struct SubscriptionPopUp_Previews: PreviewProvider {
    static var previews: some View {
        SubscriptionPopUp(show: Binding.constant(true))
    }
}

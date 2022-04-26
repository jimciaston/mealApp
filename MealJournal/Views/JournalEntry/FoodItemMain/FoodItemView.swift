//
//  FoodItemView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/3/22.
//

import SwiftUI

struct FoodItemView: View {
    // @State var foodName = ""
    
    var body: some View {
        VStack(alignment:.leading){
            Text("Chicken")
                .bold()
              //  .multilineTextAlignment(.trailing)
               
            Text("4 Oz")
                .padding(.top, 5)
            Spacer()
                .frame(maxWidth:.infinity)
           // NutrionalPieChart()
        }
    }
}

struct FoodItemView_Previews: PreviewProvider {
    static var previews: some View {
        FoodItemView()
    }
}

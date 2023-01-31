//
//  DeleteCustomItemView.swift
//  MealJournal
//
//  Created by Jim Ciaston on 1/23/23.
//

import SwiftUI

struct DeleteCustomItemView: View {
    @ObservedObject var customFoodLogic = CustomFoodLogic()
    @State var customItemID: UUID
    var body: some View {
        VStack{
            Text("Are you sure?")
                .bold()
                .font(.title2)
            Text("Once you delete your item, It will be gone forever")
                .padding(.top, 10)
           
                Text("Yes, I'm sure").fontWeight(.bold)
                    .frame(minWidth: 0, maxWidth: 200)
                    .padding(10)
                    .foregroundColor(.black)
                    
                //draw rectange around buttons
                    .overlay( RoundedRectangle(cornerRadius: 25)
                    .stroke(Color.red, lineWidth: 3)
                )
                    .onTapGesture {
                        //delete logic
                         customFoodLogic.deleteCustomFoodItem(customItemID: customItemID)
                         
                    }
            .padding(.top, 25)
        }
    }
}


//
//struct DeleteCustomItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        DeleteCustomItemView()
//    }
//}

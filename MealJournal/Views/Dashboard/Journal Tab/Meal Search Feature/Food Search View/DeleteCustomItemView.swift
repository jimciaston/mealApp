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
    @Binding var showDeleteItemView: Bool
    var body: some View {
        VStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.secondary)
                .frame(width: 60,height: 5)
                .padding(.top, 15)
                .onTapGesture {
                    self.showDeleteItemView.toggle()
                }
                
            
            Text("Are you sure?")
                .bold()
                .padding(.top, 25)
                .font(.title2)
            Text("Once deleted, your item will be gone forever")
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
                            showDeleteItemView = false
                    }
            .padding(.top, 25)
        }
        .frame(maxWidth: .infinity)
    }
}

struct DeleteCustomItemView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteCustomItemView(customItemID: UUID(), showDeleteItemView: .constant(true))
    }
}

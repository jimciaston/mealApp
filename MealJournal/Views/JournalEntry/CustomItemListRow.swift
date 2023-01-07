//
//  CustomItemListRow.swift
//  MealJournal
//
//  Created by Jim Ciaston on 10/4/22.
//

import SwiftUI

struct CustomItemListRow: View {
    @Binding var mealTimingToggle: Bool
    @Binding var sheetMode: SheetMode // << communicates with mealtimings
    @Binding var MealObject: Meal
    @Binding var isViewSearching: Bool
    @Binding var userSearch: Bool
    @Binding var resultsShowing: Int
   
    @Binding var item: Meal
    
    @State var mealName: String
    @Binding var dismissResultsView: Bool
    var body: some View {
                    ZStack{
                        HStack{
                            VStack(alignment:.leading){
                                Text(mealName ?? "default")
                                    .font(.body)
                                HStack{
                                    Text(String(item.calories ?? 0) + " cals")
                                        .font(.caption)
                                       
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading) //<<aligns to left of frame
                                }
                           
                            .frame(width:200)
                            .padding(.leading, -50)
                            
                            .foregroundColor(.black)
                          
                        Button(action: {
                            switch sheetMode {
                                case .none:
                                    sheetMode = .mealTimingSelection
                                mealTimingToggle = true //meal timing list comes to view
                                case .mealTimingSelection:
                                    sheetMode = .none
                                mealTimingToggle = false //list leaves view
                            case .quarter:
                                sheetMode = .none
                            }
                            
                            //communicates with mealtimingselectionview
                            MealObject = item
                        }){
                            Image(systemName: "plus.app")
                                .font(.largeTitle)
                                .foregroundColor(.blue)
                                .padding(.trailing, -30) // <<moves plus
                        }
                        
                            //allows button to be separely clicked //in view
                        .buttonStyle(BorderlessButtonStyle())
                            
                }
                        NavigationLink(destination: FoodItemView(
                            meal:.constant(item),
                            mealName: mealName ?? "Default",
                            mealBrand: item.brand ?? "Generic",
                            mealCalories: item.calories ?? 0,
                            mealCarbs: item.carbs ?? 0,
                            mealProtein: item.protein ?? 0,
                            mealFat: item.fat ?? 0,
                            mealUnitSize: item.servingSizeUnit ?? "Default",
                            mealServingSize: item.servingSize ?? 0,
                            dismissResultsView: $dismissResultsView
                        )
                        ){
                            emptyview()
                        }
                        .navigationBarHidden(true)
                        .opacity(0)//hides emptyview
                   
            }
              
                .padding([.leading, .trailing], 60)
                .padding([.top, .bottom], 10)
                .background(RoundedRectangle(
                    cornerRadius:20).fill(Color("LightWhite")))
                .foregroundColor(.black)
                .opacity(mealTimingToggle ? 0.3 : 1)
                
        
               
           
        
    }
    
}

//struct CustomItemListRow_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomItemListRow()
//    }
//}

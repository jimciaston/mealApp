//
//  hideKeyboard.swift
//  MealJournal
//
//  Created by Jim Ciaston on 2/11/22.
//

import SwiftUI

    func hide_UserKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil,
                                        from: nil, for: nil)
    
}



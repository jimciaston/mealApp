//
//  ActivityIndicator.swift
//  MealJournal
//
//  Created by Jim Ciaston on 8/2/22.
//

import SwiftUI

struct ActivityIndicator: View {
    @State var loading = true
    
    var scaleSize: CGFloat = 1.0
    var body: some View {
        VStack{
          ProgressView()
                .scaleEffect(scaleSize, anchor: .center)
                .progressViewStyle(CircularProgressViewStyle(tint:.blue))
        }
       
    }
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
        ActivityIndicator()
    }
}

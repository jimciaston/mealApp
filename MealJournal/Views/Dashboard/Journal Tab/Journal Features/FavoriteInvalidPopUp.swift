//
//  favoriteInvalidPopUp.swift
//  MealJournal
//
//  Created by Jim Ciaston on 12/8/22.
//

import SwiftUI

struct FavoriteInvalidPopUp: View {
    @Binding var journalSavedAlready: Bool
    @Binding var attemptedSameDaySave: Bool
    @Binding var journalSaved: Bool
    @Binding var isExistingJournalEntrysEmpty: Bool
    var body: some View {
                if attemptedSameDaySave {
                    Text("Must wait until day completed to save")
                .foregroundColor(.black)
                } else if journalSavedAlready {
                    Text("You have already saved this journal.") .foregroundColor(.black)
                } else if journalSaved {
                    Text("Journal Saved") .foregroundColor(.black)
                }
                else if isExistingJournalEntrysEmpty == true {
                    Text("Cannot save an empty journal").foregroundColor(.black)
                }
            }
        }

//struct FavoriteInvalidPopUp_Previews: PreviewProvider {
//    static var previews: some View {
//        FavoriteInvalidPopUp()
//    }
//}

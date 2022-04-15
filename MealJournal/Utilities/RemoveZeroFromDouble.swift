//
//  RemoveZeroFromDouble.swift
//  MealJournal
//
//  Created by Jim Ciaston on 4/14/22.
//
//removes trailing zero after double
import Foundation
extension Double {
    func removeZerosFromEnd() -> String {
        let formatter = NumberFormatter()
        let number = NSNumber(value: self)
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 16 //maximum digits in Double after dot (maximum precision)
        return String(formatter.string(from: number) ?? "")
    }
}

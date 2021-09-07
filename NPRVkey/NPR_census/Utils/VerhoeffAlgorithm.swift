//
//  AddharValidationCheck.swift
//  NPR-2020
//
//  Created by Dileep on 17/12/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation


final class Verhoeff {
    
    private static let multiplicationTable =
    [
        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
        [1, 2, 3, 4, 0, 6, 7, 8, 9, 5],
        [2, 3, 4, 0, 1, 7, 8, 9, 5, 6],
        [3, 4, 0, 1, 2, 8, 9, 5, 6, 7],
        [4, 0, 1, 2, 3, 9, 5, 6, 7, 8],
        [5, 9, 8, 7, 6, 0, 4, 3, 2, 1],
        [6, 5, 9, 8, 7, 1, 0, 4, 3, 2],
        [7, 6, 5, 9, 8, 2, 1, 0, 4, 3],
        [8, 7, 6, 5, 9, 3, 2, 1, 0, 4],
        [9, 8, 7, 6, 5, 4, 3, 2, 1, 0]
    ]
    
    private static let permutationTable =
    [
        [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],
        [1, 5, 7, 6, 2, 8, 3, 0, 9, 4],
        [5, 8, 0, 3, 7, 9, 6, 1, 4, 2],
        [8, 9, 1, 6, 0, 4, 3, 5, 2, 7],
        [9, 4, 5, 3, 1, 2, 6, 8, 7, 0],
        [4, 2, 8, 6, 5, 7, 3, 9, 0, 1],
        [2, 7, 9, 3, 8, 0, 6, 4, 1, 5],
        [7, 0, 4, 6, 9, 1, 3, 2, 5, 8]
    ]
    
    private static let inverseTable = [0, 4, 3, 2, 1, 5, 6, 7, 8, 9]
    
    private static func verhoeffDigit(for number: String) -> String {
        var c = 0
        let nums = reversedIntArray(from: number)
        for i in 0..<nums.count {
            c = multiplicationTable[c][permutationTable[((i + 1) % 8)][nums[i]]]
        }
        return String(inverseTable[c])
    }
    
    static func validateVerhoeff(for string: String) -> Bool {
           var c = 0
           let nums = reversedIntArray(from: string)
           for i in 0..<nums.count {
               c = multiplicationTable[c][permutationTable[(i % 8)][nums[i]]]
           }
           return (c == 0)
       }
    
    private static func reversedIntArray(from string: String) -> [Int] {
        var intArray = [Int]()
        for elem in string {
            guard let intValue = Int(String(elem)) else {
                fatalError("Invalid input")
            }
            intArray.append(intValue)
        }
        let reversed = Array(intArray.reversed())
        return reversed
    }
}

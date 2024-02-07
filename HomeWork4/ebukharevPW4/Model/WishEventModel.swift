//
//  WishEventModel.swift
//  ebukharevPW4
//
//  Created by Евгений Бухарев on 05.02.2024.
//

import Foundation

class WishEventModel{
    let title: String
    let description: String
    let startDate: Date
    let endDate: Date
    
    init(title: String, description: String, startDate: Date, endDate: Date) {
        self.title = title
        self.description = description
        self.startDate = startDate
        self.endDate = endDate
    }
}

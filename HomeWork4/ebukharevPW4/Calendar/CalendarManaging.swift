//
//  CalendarManaging.swift
//  ebukharevPW4
//
//  Created by Eвгений Бухарев on 06.10.2023.
//

import EventKit

protocol CalendarManaging{
    func create(eventModel: WishEventModel)-> Bool
}

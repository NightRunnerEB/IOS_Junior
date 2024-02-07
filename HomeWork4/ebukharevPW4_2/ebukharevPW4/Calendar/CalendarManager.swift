//
//  CalendarManager.swift
//  ebukharevPW4
//
//  Created by Eвгений Бухарев on 06.10.2023.
//

import EventKit

final class CalendarManager: CalendarManaging{
    private let eventStore: EKEventStore = EKEventStore()
    
    func create(eventModel: WishEventModel) -> Bool {
        var result: Bool = false
        let group = DispatchGroup()
        group.enter()
        
        create(eventModel: eventModel) { isCreated in
            result = isCreated
            group.leave()
        }
        
        group.wait()
        return result
    }
    
    func create(eventModel: WishEventModel, completion: ((Bool) -> Void)?){
        let createEvent: EKEventStoreRequestAccessCompletionHandler = { [weak self] (granted, error) in
            guard granted, error == nil, let self else{
                completion?(false)
                return
            }
            
            let event = EKEvent(eventStore: self.eventStore)
            
            event.title = eventModel.title
            event.notes = eventModel.description
            event.startDate = eventModel.startDate
            event.endDate = eventModel.endDate
            event.calendar = self.eventStore.defaultCalendarForNewEvents
            
            do{
                try self.eventStore.save(event, span: .thisEvent)
            }catch let error as NSError{
                print("failed to save event with error: \(error)")
            }
            
            completion?(true)
        }
        
        if #available(iOS 17.0, *) {
        eventStore.requestFullAccessToEvents(completion: createEvent)
        } else {
        eventStore.requestAccess(to: .event, completion: createEvent)
        }
    }
}

//
//  EventViewModel.swift
//  FireStore
//
//  Created by FUKA on 26.3.2022.
//

import Foundation

class EventViewModel: ObservableObject {
    @Published var eventDetails: Event? = nil
    
    /* init(_ id: String?, _ user: User?, _ dateAndTime: String?, _ type: String?, _ locationDetails: String?, _ moreDetails: String?) {
        self.user = user
        self.dateAndTime = dateAndTime
        self.type = type
        self.locationDetails = locationDetails
        self.moreDetails = moreDetails
    } */
}

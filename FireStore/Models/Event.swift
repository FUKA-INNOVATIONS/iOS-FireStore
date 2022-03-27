//
//  Event.swift
//  FireStore
//
//  Created by FUKA on 26.3.2022.
//

import Foundation


struct Event {
    var id: String? = nil
    var user: User
    var trustedContacts: Array<User>
    var dateAndTime: String
    var type: String
    var locationDetails: String
    var moreDetails: String
}

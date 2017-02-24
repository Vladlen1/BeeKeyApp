//
//  Users.swift
//  BeeKey
//
//  Created by Kirill on 20.01.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import RealmSwift

class Users: Object
{
    dynamic var name = ""
    dynamic var surname = ""
    dynamic var login = ""
    dynamic var password = ""
    dynamic var state = false
    dynamic var created = NSDate()
    
}

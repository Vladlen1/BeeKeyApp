//
//  Keys.swift
//  BeeKey
//
//  Created by Влад Бирюков on 24.01.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import Foundation
import RealmSwift

class Keys: Object
{
    dynamic var key_name = ""
    dynamic var site = ""
    dynamic var login = ""
    dynamic var image = ""
    dynamic var password = ""
    dynamic var activity = false
    dynamic var user: Users!
    dynamic var created = NSDate()
    }

//
//  Delivery.swift
//  Lopawlty
//
//  Created by user194247 on 12/2/21.
//

import Foundation

class Delivery {
    var deliveryDayName:String
    var deliveryDayNumber:String
    var deliveryMonth:String
    var deliveryTimeRange:String
    
    init(deliveryDayName:String, deliveryDayNumber:String, deliveryMonth:String, deliveryTimeRange:String) {
        self.deliveryDayName = deliveryDayName
        self.deliveryDayNumber = deliveryDayNumber
        self.deliveryMonth = deliveryMonth
        self.deliveryTimeRange = deliveryTimeRange
    }
    
    convenience init() {
        self.init(deliveryDayName:"", deliveryDayNumber:"", deliveryMonth:"", deliveryTimeRange:"")
    }
    
    convenience init(firebaseDictionary : [String: Any]) {
        let deliveryDayName = firebaseDictionary["deliveryDayName"] as! String? ?? ""
        let deliveryDayNumber = firebaseDictionary["deliveryDayNumber"] as! String? ?? ""
        let deliveryMonth = firebaseDictionary["deliveryMonth"] as! String? ?? ""
        let deliveryTimeRange = firebaseDictionary["deliveryTimeRange"] as! String? ?? ""
        
        self.init(deliveryDayName : deliveryDayName, deliveryDayNumber : deliveryDayNumber, deliveryMonth : deliveryMonth, deliveryTimeRange : deliveryTimeRange)
    }
    
    var firebaseDictionary : [String: Any] {
        return ["deliveryDayName" : deliveryDayName, "deliveryDayNumber" : deliveryDayNumber , "deliveryMonth" : deliveryMonth, "deliveryTimeRange" : deliveryTimeRange]
    }
}

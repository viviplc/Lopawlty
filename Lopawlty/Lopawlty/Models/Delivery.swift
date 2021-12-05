//
//  Delivery.swift
//  Lopawlty
//
//  Created by Viviana Leyva on 12/2/21.
//

/**
 This class is the model for a Delivery which is a single delivery attached to a Sale object. It provides the functionality to initialize using a Firebase Collection Dictionary, as well as convert from a Delivery object to a Firebase collection dictionary.
 */

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
    
    //a convenience constructor that takes a firebase dictionary. This is used when we have a firebase object of data and want to convert it to this class
    convenience init(firebaseDictionary : [String: Any]) {
        let deliveryDayName = firebaseDictionary["deliveryDayName"] as! String? ?? ""
        let deliveryDayNumber = firebaseDictionary["deliveryDayNumber"] as! String? ?? ""
        let deliveryMonth = firebaseDictionary["deliveryMonth"] as! String? ?? ""
        let deliveryTimeRange = firebaseDictionary["deliveryTimeRange"] as! String? ?? ""
        
        self.init(deliveryDayName : deliveryDayName, deliveryDayNumber : deliveryDayNumber, deliveryMonth : deliveryMonth, deliveryTimeRange : deliveryTimeRange)
    }
    
    //function that takes the current instance of the class and gives out a dictionary in the [String: Any] format the firebase uses
    var firebaseDictionary : [String: Any] {
        return ["deliveryDayName" : deliveryDayName, "deliveryDayNumber" : deliveryDayNumber , "deliveryMonth" : deliveryMonth, "deliveryTimeRange" : deliveryTimeRange]
    }
}

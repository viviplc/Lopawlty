//
//  Delivery.swift
//  Lopawlty
//
//  Created by user194247 on 12/2/21.
//

import Foundation

class Delivery {
    var deliveryDateTime:String
    var saleId : String
    
    init(deliveryDateTime:String, saleId : String) {
        self.deliveryDateTime = deliveryDateTime
        self.saleId = saleId
    }
    
    convenience init() {
        self.init(deliveryDateTime:"", saleId:"")
    }
}

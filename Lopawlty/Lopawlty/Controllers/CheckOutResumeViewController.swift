//
//  CheckOutResumeViewController.swift
//  Lopawlty
//
//  Created by user193926 on 12/1/21.
//

import UIKit
import Foundation

class CheckOutResumeViewController: UIViewController {
    
    @IBOutlet weak var LblTotalItems: UILabel!
    @IBOutlet weak var LblSubTotal: UILabel!
    @IBOutlet weak var LblShipping: UILabel!
    @IBOutlet weak var LblPriceNoTax: UILabel!
    @IBOutlet weak var LblGstHst: UILabel!
    @IBOutlet weak var LblPstRst: UILabel!
    @IBOutlet weak var LblGrandTotal: UILabel!
    
    var totalItems = 0
    var subTotal = 0.0
    var shipping = 5.2

    override func viewDidLoad() {
        super.viewDidLoad()

        LblTotalItems.text = "\(totalItems)"
        LblSubTotal.text = "$ \(String(format: "%.2f", subTotal))"
        LblShipping.text = "$ \(shipping)"
        
        let priceNoTax = calculatePriceNotaxes()
        LblPriceNoTax.text = "$ \(String(format: "%.2f", priceNoTax))"
       
        let gsthst = calculateTaxGstHst(priceNoTax: priceNoTax)
        LblGstHst.text = "$ \(String(format: "%.2f", gsthst))"
        
        let pstrst = calculateTaxPstRst(priceNoTax: priceNoTax)
        LblPstRst.text = "$ \(String(format: "%.2f", pstrst))"
        
        let grandTotal = calculateGrandTotal(noTax: priceNoTax, gst: gsthst, pst: pstrst)
        LblGrandTotal.text = "$ \(String(format: "%.2f", grandTotal))"
    }
    
    func calculatePriceNotaxes() -> Double {
        var totalNoTax = 0.0
        totalNoTax = subTotal + shipping
        return totalNoTax
    }
    
    func calculateTaxGstHst(priceNoTax : Double) -> Double{
        var totalGstHst = 0.0
        totalGstHst = priceNoTax * 0.08
        return totalGstHst
    }

    func calculateTaxPstRst(priceNoTax : Double) -> Double{
        var totalPstRst = 0.0
        totalPstRst = priceNoTax * 0.05
        return totalPstRst
    }
    
    func calculateGrandTotal(noTax: Double, gst : Double, pst: Double) -> Double{
        var total = 0.0
        total = noTax + gst + pst
        return total
    }
}

//
//  OrderConfirmationViewController.swift
//  Lopawlty
//
//  Created by user193926 on 12/2/21.
//

import UIKit
import Firebase

class OrderConfirmationViewController: UIViewController {

    
    @IBOutlet weak var LblTotalItems: UILabel!
    
    @IBOutlet weak var BtnPaymentMethod: UIButton!
    @IBOutlet weak var BtnDate: UIButton!
    @IBOutlet weak var BtnPlaceOrder: UIButton!
    
    @IBOutlet weak var BtnSeeItems: UIButton!
    @IBOutlet weak var LblSubtotal: UILabel!
    @IBOutlet weak var LblFeesTaxes: UILabel!
    @IBOutlet weak var LblGrandTotal: UILabel!
    @IBOutlet weak var LblDayWeek: UILabel!
    @IBOutlet weak var LblDayNum: UILabel!
    @IBOutlet weak var LblMonth: UILabel!
    @IBOutlet weak var LblTimeInterval: UILabel!
    @IBOutlet weak var LblAddress: UILabel!
    @IBOutlet weak var LblComplementary: UILabel!
    @IBOutlet weak var LblCityPostal: UILabel!
    
    @IBOutlet weak var ShippingViewInfo: UIView!
    
    var saleId = ""
    var sale : Sale = Sale()
    var products : [Product] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonsStyles()
        //infoTest()
        
        loadSaleInfoFromFirebase()
        
        
    }
    
    func setOrderInfo() {
        let subTotal = sale.payment.subTotal
        let subTotalText = String(format: "%.2f",subTotal)
        LblSubtotal.text = "$ \(subTotalText)"
        
        let taxes = sale.payment.taxes
        let taxesText = String(format: "%.2f",taxes)
        LblFeesTaxes.text = "$ \(taxesText)"
        
        let total = sale.payment.totalCost
        let totalText = String(format: "%.2f",total)
        LblGrandTotal.text = "$ \(totalText)"
        
        LblDayWeek.text = sale.delivery.deliveryDayName
        LblDayNum.text = sale.delivery.deliveryDayNumber
        LblMonth.text = sale.delivery.deliveryMonth
        
        LblTimeInterval.text = sale.delivery.deliveryTimeRange
        
        LblAddress.text = sale.address.street
        LblComplementary.text = sale.address.complementaryInfo
        LblCityPostal.text = sale.address.postalCode
        
        LblTotalItems.text = String(sale.totalItems)
    }
    
    
    func infoTest() {
        LblSubtotal.text = "$ 25.36"
        LblFeesTaxes.text = "$ 5.34"
        LblGrandTotal.text = "$ 45.67"
        LblDayWeek.text = "Wednesday"
        LblDayNum.text = "30"
        LblMonth.text = "Dec"
        LblTimeInterval.text = "9:00 AM - 11:00 AM"
        LblAddress.text = "275 Larch Street"
        LblComplementary.text = "Building B Unit 301"
        LblCityPostal.text = "Waterloo, ON N2R 2L5"
    }
    
    func setButtonsStyles() {
        BtnSeeItems.layer.borderWidth = 1 
        BtnSeeItems.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1).cgColor
        BtnSeeItems.layer.cornerRadius = 15
        BtnPaymentMethod.layer.borderWidth = 1
        BtnPaymentMethod.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1).cgColor
        BtnPaymentMethod.layer.cornerRadius = 15
        BtnDate.layer.borderWidth = 1
        BtnDate.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1).cgColor
        LblTimeInterval.layer.cornerRadius = 15
        LblTimeInterval.layer.borderWidth = 1
        LblTimeInterval.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1).cgColor
        ShippingViewInfo.layer.borderWidth = 2
        ShippingViewInfo.layer.borderColor = UIColor(red: 204/255, green: 228/255, blue: 255/255, alpha: 1).cgColor
        BtnPlaceOrder.layer.cornerRadius = 15
    }
    
    func loadSaleInfoFromFirebase() {
        let db = Firestore.firestore()
        
        let docRef = db.collection("Sales").document(saleId)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let data = document.data()
                self.sale = Sale(firebaseDictionary: data!)
                self.sale.getProducts() { (products) in
                    self.products = products
                    print("PRODUCT 1 NAME -> \(self.products[0].name)")
                }
                print("successfully got all models from db")
                self.setOrderInfo()
            } else {
                print("Document does not exist")
            }
        }
        
    }
    
    @IBAction func BtnPlaceOrderClick(_ sender: Any) {
        let confirmationImg = UIImage(named: "confirmation")
        
               
        let imageView = UIImageView(frame: CGRect(x:40 ,y: 60, width: 200, height: 200))
        imageView.image = confirmationImg
        
        let alert = UIAlertController(title: "Thanks for shopping with us! \n\n\n\n\n\n\n\n\n\n",message: nil, preferredStyle: .alert)
        
        alert.view.addSubview(imageView)
        
        let placeAction = UIAlertAction(title: "Place it", style: .default, handler: { [self] _ in
            print("Place it selected")
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(placeAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
        
    }
    
    
    @IBAction func btnSeeItemsClicked(_ sender: Any) {
        //CheckoutConfirmationToSeeMore
        self.performSegue(withIdentifier: "CheckoutConfirmationToSeeMore", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.destination is OrderItemsViewController {
                let resume = segue.destination as? OrderItemsViewController
                resume?.orderItems = self.products
            }
        }
    
    
}

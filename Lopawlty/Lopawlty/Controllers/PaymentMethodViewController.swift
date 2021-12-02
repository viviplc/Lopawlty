//
//  PaymentMethodViewController.swift
//  Lopawlty
//
//  Created by user193926 on 12/2/21.
//

import UIKit
import MonthYearPicker

class PaymentMethodViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var BtnMonth: UIButton!
    @IBOutlet weak var LblYear: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    

    @IBAction func BtnMonthClick(_ sender: Any) {
        
        let picker = MonthYearPickerView(frame: CGRect(origin: CGPoint(x: 0, y: 30), size: CGSize(width: 270, height: 200)))
        picker.minimumDate = Date()
        picker.maximumDate = Calendar.current.date(byAdding: .year, value: 10, to: Date())
        
        let alertController = UIAlertController(title: "Select expiration month \n\n\n\n\n\n\n", message: nil, preferredStyle: .alert)
        alertController.view.addSubview(picker)
        let selectAction = UIAlertAction(title: "Ok", style: .default, handler: { [self] _ in
            let dateSelected = picker.date
            print("Selected Date: \(dateSelected)")
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MM"
            let monthSel = dateFormatter.string(from: dateSelected)
            dateFormatter.dateFormat = "yy"
            let yearSel = dateFormatter.string(from: dateSelected)
            BtnMonth.setTitleColor(UIColor(red: 0, green: 0, blue: 0, alpha: 1), for: .normal)
            BtnMonth.setTitle(monthSel,for: .normal)
            LblYear.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
            LblYear.text = yearSel
        })
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(selectAction)
            alertController.addAction(cancelAction)
            present(alertController, animated: true)
    }
    
    
    @IBAction func btnInfoCVVClick(_ sender: Any) {
        let alertController = UIAlertController(title: "CVV Number", message: "you can find your CVV number backward from your credit card", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true)
    }
    
    @objc func DismissKeyboard(){
    //Causes the view to resign from the status of first responder.
    view.endEditing(true)
    }

}

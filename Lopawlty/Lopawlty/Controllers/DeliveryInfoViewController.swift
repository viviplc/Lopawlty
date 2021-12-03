//
//  DeliveryInfoViewController.swift
//  Lopawlty
//
//  Created by user193926 on 12/1/21.
//

import UIKit
import Firebase

class DeliveryInfoViewController: UIViewController {

    @IBOutlet weak var Day1View: UIView!
    @IBOutlet weak var Day2View: UIView!
    @IBOutlet weak var Day3View: UIView!
    @IBOutlet weak var Day4View: UIView!
    
    @IBOutlet weak var Day1Btn: UIButton!
    @IBOutlet weak var Day2Btn: UIButton!
    @IBOutlet weak var Day3Btn: UIButton!
    @IBOutlet weak var Day4Btn: UIButton!
    
    @IBOutlet weak var Day1DayWeek: UILabel!
    @IBOutlet weak var Day1DayNum: UILabel!
    @IBOutlet weak var Day1Month: UILabel!
    @IBOutlet weak var Day2DayWeek: UILabel!
    @IBOutlet weak var Day2DayNum: UILabel!
    @IBOutlet weak var Day2Month: UILabel!
    @IBOutlet weak var Day3DayWeek: UILabel!
    @IBOutlet weak var Day3DayNum: UILabel!
    @IBOutlet weak var Day3Month: UILabel!
    @IBOutlet weak var Day4DayWeek: UILabel!
    @IBOutlet weak var Day4DayNum: UILabel!
    @IBOutlet weak var Day4Month: UILabel!
        
    @IBOutlet weak var Btn9AM: UIButton!
    @IBOutlet weak var Btn11AM: UIButton!
    @IBOutlet weak var Btn1PM: UIButton!
    @IBOutlet weak var Btn3PM: UIButton!
    
    var saleId = ""
    var selectableDayStrings : [[String : String]] = []
    var selectedDayIndex = -1
    var selectedDeliveryTimeRange:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setDatesButtonsInfo()
        setHoursButtonsStyles()
    
        
    }
    
    func setDatesButtonsInfo(){
        let calendar = Calendar.current
        let today = Date()
        let midnight = calendar.startOfDay(for: today)
        
        for index in 1...4{
            let nextDay = calendar.date(byAdding: .day, value: index, to: midnight)!
             
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE"
            let dayWeekString = dateFormatter.string(from: nextDay)
            dateFormatter.dateFormat = "d"
            let dayNumString = dateFormatter.string(from: nextDay)
            dateFormatter.dateFormat = "MMM"
            let monthString = dateFormatter.string(from: nextDay)
    
            selectableDayStrings.append(["deliveryDayName" : dayWeekString, "deliveryDayNumber" : dayNumString, "deliveryMonth" : monthString])
            
            switch index {
            case 1:
                Day1DayWeek.text = dayWeekString
                Day1DayNum.text = dayNumString
                Day1Month.text = monthString
            case 2:
                Day2DayWeek.text = dayWeekString
                Day2DayNum.text = dayNumString
                Day2Month.text = monthString
            case 3:
                Day3DayWeek.text = dayWeekString
                Day3DayNum.text = dayNumString
                Day3Month.text = monthString
            case 4:
                Day4DayWeek.text = dayWeekString
                Day4DayNum.text = dayNumString
                Day4Month.text = monthString
            default:
                print("Date error")
            }
        }
    }
    
    func setHoursButtonsStyles() {
        Btn9AM.layer.cornerRadius = 15
        Btn9AM.layer.borderWidth = 1
        Btn9AM.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1).cgColor
        Btn11AM.layer.cornerRadius = 15
        Btn11AM.layer.borderWidth = 1
        Btn11AM.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1).cgColor
        Btn1PM.layer.cornerRadius = 15
        Btn1PM.layer.borderWidth = 1
        Btn1PM.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1).cgColor
        Btn3PM.layer.cornerRadius = 15
        Btn3PM.layer.borderWidth = 1
        Btn3PM.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1).cgColor
    }
    
    
    @IBAction func BtnDay1Click(_ sender: Any) {
        resetDayButtons()
        Day1View.layer.backgroundColor = UIColor(red: 1, green:1, blue: 1, alpha: 1).cgColor
        Day1Btn.layer.borderWidth = 3
        Day1Btn.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1).cgColor
        selectedDayIndex = 0
    }
    
    @IBAction func BtnDay2Click(_ sender: Any) {
        resetDayButtons()
        Day2View.layer.backgroundColor = UIColor(red: 1, green:1, blue: 1, alpha: 1).cgColor
        Day2Btn.layer.borderWidth = 3
        Day2Btn.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1).cgColor
        selectedDayIndex = 1
    }
    
    @IBAction func BtnDay3Click(_ sender: Any) {
        resetDayButtons()
        Day3View.layer.backgroundColor = UIColor(red: 1, green:1, blue: 1, alpha: 1).cgColor
        Day3Btn.layer.borderWidth = 3
        Day3Btn.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1).cgColor
        selectedDayIndex = 2
    }
    
    @IBAction func BtnDay4Click(_ sender: Any) {
        resetDayButtons()
        Day4View.layer.backgroundColor = UIColor(red: 1, green:1, blue: 1, alpha: 1).cgColor
        Day4Btn.layer.borderWidth = 3
        Day4Btn.layer.borderColor = UIColor(red: 0, green: 122/255, blue: 255/255, alpha: 1).cgColor
        selectedDayIndex = 3
    }
    
    func resetDayButtons() {
        Day1View.layer.backgroundColor = UIColor(red: 204/255, green:228/255, blue: 1, alpha: 1).cgColor
        Day1Btn.layer.borderWidth = 0
        Day2View.layer.backgroundColor = UIColor(red: 204/255, green:228/255, blue: 1, alpha: 1).cgColor
        Day2Btn.layer.borderWidth = 0
        Day3View.layer.backgroundColor = UIColor(red: 204/255, green:228/255, blue: 1, alpha: 1).cgColor
        Day3Btn.layer.borderWidth = 0
        Day4View.layer.backgroundColor = UIColor(red: 204/255, green:228/255, blue: 1, alpha: 1).cgColor
        Day4Btn.layer.borderWidth = 0
    }
    
    @IBAction func Btn9AmClick(_ sender: Any) {
        resetHourButtons()
        Btn9AM.layer.borderWidth = 3
        selectedDeliveryTimeRange = "9:00 AM - 11:00 AM"
    }
    
    @IBAction func Btn11AmClick(_ sender: Any) {
        resetHourButtons()
        Btn11AM.layer.borderWidth = 3
        selectedDeliveryTimeRange = "11:00 AM - 1:00 PM"
    }
    
    @IBAction func Btn1PmClick(_ sender: Any) {
        resetHourButtons()
        Btn1PM.layer.borderWidth = 3
        selectedDeliveryTimeRange = "1:00 PM - 3:00 PM"
    }
    
    @IBAction func Btn3PmClick(_ sender: Any) {
        resetHourButtons()
        Btn3PM.layer.borderWidth = 3
        selectedDeliveryTimeRange = "3:00 PM - 5:00 PM"
    }
    
    func resetHourButtons() {
        Btn9AM.layer.borderWidth = 1
        Btn11AM.layer.borderWidth = 1
        Btn1PM.layer.borderWidth = 1
        Btn3PM.layer.borderWidth = 1
    }
    
    func validateDeliveryInfoSelected() -> Bool {
        var validated = true
        var errorMessage = ""
        if(selectedDayIndex < 0) {
            validated = false
            errorMessage += "Please choose a suitable date. "
        }
        
        if(selectedDeliveryTimeRange.count == 0) {
            validated = false
            errorMessage += "Please choose a time range. "
        }
        
        if(!validated) {
            Utils.alert(message: errorMessage, viewController: self)
        }
        
        return validated
    }
    
    @IBAction func btnContinueClicked(_ sender: Any) {
        //deliveryToCreditCard
        if(validateDeliveryInfoSelected()) {
            let newDelivery = createDelivery()
            let db = Firestore.firestore()
            let firebaseNewDeliveryDict = newDelivery.firebaseDictionary;
            db.collection("Sales").document(saleId).setData( ["delivery" : firebaseNewDeliveryDict], merge: true){ err in
                if let err = err {
                    print("error adding delivery: \(err)")
                } else {
                    print("updated delivery of sale \(self.saleId)")
                    self.performSegue(withIdentifier: "deliveryToCreditCard", sender: self)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.destination is PaymentMethodViewController {
                let resume = segue.destination as? PaymentMethodViewController
                resume?.saleId = self.saleId
            }
        }
    
    func createDelivery() -> Delivery {
        //deliveryToCreditCard
        let selectedDeliveryDate = selectableDayStrings[selectedDayIndex]
        let deliveryDayName = selectedDeliveryDate["deliveryDayName"]!
        let deliveryDayNumber = selectedDeliveryDate["deliveryDayNumber"]!
        let deliveryMonth = selectedDeliveryDate["deliveryMonth"]!
        let newDelivery = Delivery(deliveryDayName: deliveryDayName, deliveryDayNumber: deliveryDayNumber, deliveryMonth: deliveryMonth, deliveryTimeRange: selectedDeliveryTimeRange)
        return newDelivery
    }
    
}

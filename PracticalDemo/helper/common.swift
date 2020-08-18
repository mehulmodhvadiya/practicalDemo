//
//  Common.swift
//  Catalogue
//
//  Created by CTPLMac8 on 25/06/18.
//  Copyright © 2018 Cmarix Technolab Pvt. Ltd. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

//import Alamofire
//import SideMenu
//import Firebase
//import FBSDKLoginKit
//import FacebookCore
//import FacebookLogin
//import GoogleSignIn

let activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()

class Common {
    
    static let shared = Common()
    var appName : String
    var preference : UserDefaults
    var screenWidth : CGFloat
    var screenHeight : CGFloat
    
    var appVersion : String
    var appBuildVersion : String
    var arrSelfList = [String]()

    
    
    init() {
        
        appName = Bundle.main.infoDictionary![kCFBundleNameKey as String] as! String
        preference = UserDefaults.standard
        screenWidth = UIScreen.main.bounds.size.width
        screenHeight = UIScreen.main.bounds.size.height
        
        appVersion = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        appBuildVersion = Bundle.main.infoDictionary!["CFBundleVersion"] as! String
    }
    
    
    
    // MARK: - Email Validation -
    
    func isValidEmail(strEmail : String) -> Bool {
        
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: strEmail)
        
        
    }
    
    func getAgeFromBirthDate(strBirthDate : String) -> String {
        
        let dateFormatter = DateFormatter.init()
        dateFormatter.dateFormat = "dd-MM-YYYY"
        
        let now = Date()
        let birthday: Date = dateFormatter.date(from: strBirthDate)!
        let calendar = Calendar.current
        
        let ageComponents = calendar.dateComponents([.year], from: birthday, to: now)
        let age = ageComponents.year!
        
        return String(age)
    }
    
    func isValidAge(strAge : String) -> Bool {
        
        if !(strAge.count > 0){
            
            return false
        }
        
        let intAge = Int(strAge)
        
        if intAge! >= 18 {
            
            return true
        }
        
        return false
        
    }
    
    func isValidSpendLimit(strSpendLimit : String) -> Bool {
        
        if !(strSpendLimit.count > 0){
            
            return false
        }
        
        let intSpendLimit = Int(strSpendLimit)
        
        if intSpendLimit! >= 5 {
            
            return true
        }
        
        return false
        
    }
    
    // MARK: - Remove White Space -
    
    func removeWhiteSpaceFromString(str : String) -> String {
        
        if str.count > 0 {
            
            let trimmedString = str.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            
            return trimmedString
        }
        else{
            
            return ""
        }
        
    }
    
    // MARK: - Alert  -
    
    func showAlert(strMsg : String, vc : UIViewController, completion: @escaping () -> Void)  {
        
        let alert = UIAlertController.init(title: appName, message: strMsg, preferredStyle: UIAlertController.Style.alert)
        
        let actionOk = UIAlertAction.init(title: "OK", style: UIAlertAction.Style.default) { (action) in
            
            completion()
        }
        alert.addAction(actionOk)
        
        vc.present(alert, animated: true) {
            
        }
        
    }
    
    // MARK: - Preference -
    
    func setPreference(strKey : String, value : String) {
        
        preference.set(value, forKey: strKey)
        preference.synchronize()
    }
    
    func getPreference(strKey : String) -> String {
        
        return preference.string(forKey:strKey) ?? ""
    }
    
    
    func UIColorFromRGB(rgbValue: UInt) -> UIColor {
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    //    func createGradient(frame : CGRect) -> CAGradientLayer  {
    //
    //        let gradient = CAGradientLayer()
    //
    //        gradient.frame = frame
    //        gradient.colors = [Constants.gradientColorBlueFirst.cgColor,Constants.gradientColorBlueSecond.cgColor]
    //        gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
    //        gradient.endPoint = CGPoint(x: 1.0, y: 0.0)
    //
    //        return gradient
    //    }
    
    func image(fromLayer layer: CALayer) -> UIImage {
        UIGraphicsBeginImageContext(layer.frame.size)
        
        layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let outputImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return outputImage!
    }
    
    func doLogoutFromApp()  {
        
    }
    
    
    //MARK: - Activity Indicator in status bar -
    
    func showActivityIdicatonInStatusBar()  {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    func hideActivityIdicatonInStatusBar()  {
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    //MARK: - Time stamp to date string -
    
    func dateStringFromTimeStamp(timeStamp : String,format : String) -> String {
        
        let df = DateFormatter.init()
        df.dateFormat = format
        
        let date = Date.init(timeIntervalSince1970: Double(timeStamp)!)
        
        return df.string(from: date)
    }
    
    func countBytesInMB(withData data : Data) -> String {
        
        let bcf = ByteCountFormatter()
        bcf.allowedUnits = [.useMB]
        bcf.countStyle = .file
        
        return bcf.string(fromByteCount: Int64(data.count))
    }
    
    func getCurrentTimeStamp() -> String {
        
        let timestamp = Date().timeIntervalSince1970
        
        var strTimeStamp = "\(timestamp)"
        
        strTimeStamp = strTimeStamp.replacingOccurrences(of: ".", with: "")
        
        return strTimeStamp
    }
    
    func convertDateOfBirth(dateOfBirth: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: dateOfBirth)
        dateFormatter.dateFormat = "dd/MM/yyyy"
        var strConvertedDate = ""
        if let convertedDate = date {
            strConvertedDate = dateFormatter.string(from: convertedDate)
        }
        return strConvertedDate
    }
    
    func setLocalNotification(hour:Int, min:Int, second:Int, isRepeate:Bool){
        
//        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//
//        let msgTitleMonday = "You personalised daily forecast is ready"
//
//        for i in 1..<8
//        {
//            print("counts\(i)")
//            let content = UNMutableNotificationContent()
//            content.title = "MyPandit"
//            content.body = msgTitleMonday
//            var dateComponents = DateComponents()
//            dateComponents.calendar = Calendar.current
//
//            dateComponents.weekday = Int(i)  // Tuesday
//            dateComponents.hour = hour // 14:00 hours
//            dateComponents.minute = min    // 14:00 hours
//
//            // Create the trigger as a repeating event.
//            let trigger = UNCalendarNotificationTrigger(
//                dateMatching: dateComponents, repeats: true)
//            let uuidString = UUID().uuidString
//            let request = UNNotificationRequest(identifier: uuidString,
//                                                content: content, trigger: trigger)
//
//            // Schedule the request with the system.
//            let notificationCenter = UNUserNotificationCenter.current()
//            notificationCenter.add(request) { (error) in
//                if error != nil {
//                    // Handle any errors.
//                }
//            }
//        }
    }
    
}






//MARK: - Extensions -

extension UIViewController {
    
    /**
     *  Height of status bar + navigation bar (if navigation bar exist)
     */
    
    var topbarHeight: CGFloat {
        return UIApplication.shared.statusBarFrame.size.height +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
    
    func setTitleView() {
        
        let iv = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 62.5, height: 25.83))
        iv.contentMode = UIView.ContentMode.scaleAspectFit
        //   iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "couchshoprlogo")
        self.navigationItem.titleView = iv
    }
    
    func startLoading(){
        activityIndicator.center = self.view.center;
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.style = UIActivityIndicatorView.Style.gray;
        view.addSubview(activityIndicator);
        activityIndicator.startAnimating();
        //  UIApplication.shared.beginIgnoringInteractionEvents();
        
    }
    func stopLoading(){
        activityIndicator.stopAnimating();
        //  UIApplication.shared.endIgnoringInteractionEvents();
    }
    
}

extension UIView {
    
    func setShadowToView()  {
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.6
        self.layer.shadowRadius = 1.5
        self.layer.shadowOffset = CGSize(width: 0.5, height: 0.5)
    }
    
    @discardableResult
    func addBorders(edges: UIRectEdge,
                    color: UIColor,
                    inset: CGFloat = 0.0,
                    thickness: CGFloat = 1.0) -> [UIView] {
        
        var borders = [UIView]()
        
        @discardableResult
        func addBorder(formats: String...) -> UIView {
            let border = UIView(frame: .zero)
            border.backgroundColor = color
            border.translatesAutoresizingMaskIntoConstraints = false
            addSubview(border)
            addConstraints(formats.flatMap {
                NSLayoutConstraint.constraints(withVisualFormat: $0,
                                               options: [],
                                               metrics: ["inset": inset, "thickness": thickness],
                                               views: ["border": border]) })
            borders.append(border)
            return border
        }
        
        
        if edges.contains(.top) || edges.contains(.all) {
            addBorder(formats: "V:|-0-[border(==thickness)]", "H:|-inset-[border]-inset-|")
        }
        
        if edges.contains(.bottom) || edges.contains(.all) {
            addBorder(formats: "V:[border(==thickness)]-0-|", "H:|-inset-[border]-inset-|")
        }
        
        if edges.contains(.left) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:|-0-[border(==thickness)]")
        }
        
        if edges.contains(.right) || edges.contains(.all) {
            addBorder(formats: "V:|-inset-[border]-inset-|", "H:[border(==thickness)]-0-|")
        }
        
        return borders
    }
    
    
}

extension UINavigationController {
    
    func makeNavigationBarTransperent()  {
        
        self.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = .clear
        
        
        //        let iv = UIImageView.init(frame: CGRect(x: 0, y: 0, width: 150, height: 62))
        //        iv.backgroundColor = UIColor.white
        //        iv.contentMode = UIViewContentMode.scaleAspectFill
        //        iv.clipsToBounds = true
        //        iv.image = #imageLiteral(resourceName: "couchshoprlogo")
        //        self.navigationItem.titleView = iv
    }
}

extension String {
    
    var convertStringToCurrency : String {
        
        let number = Double(self)
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        // formatter.locale = Locale(identifier: "en_US")
        formatter.locale = Locale.current
        
        return formatter.string(from: number! as NSNumber)!
        
        
    }
    
    var convertCurrencyToString : String {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        // formatter.locale = Locale(identifier: "en_US")
        formatter.locale = Locale.current
        
        let number = formatter.number(from: self)
        
        return (number?.stringValue)!
    }
    
}

//MARK: - Class for loader in UIButton -



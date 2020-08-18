//
//  StudentModel.swift
//  SQliteDabaseDemo
//
//  Created by mehul modhvadiya on 13/03/20.
//  Copyright © 2020 mehul modhvadiya. All rights reserved.
//

import Foundation

class StudentModel {
    var Sfname:String
    var Slname:String
    var Semail:String
    var Saddress:String
    var Shobbies:String
    var Sgender:String
    var Sphonenum:String
    var userImage: String
    var id:Int
    
    init(id:Int,Sfname:String,Slname:String,Semail:String,Saddress:String,Shobbies:String,Sgender:String,Sphonenum:String,userImage:String) {
        self.Sfname = Sfname
        self.Slname = Slname
        self.Semail = Semail
        self.Saddress = Saddress
        self.Shobbies = Shobbies
        self.Sgender = Sgender
        self.Sphonenum = Sphonenum
        self.userImage = userImage
        self.id = id
    }
}

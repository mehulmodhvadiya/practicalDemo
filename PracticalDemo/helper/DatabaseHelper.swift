//
//  DatabaseHelper.swift
//  SQliteDabaseDemo
//
//  Created by mehul modhvadiya on 13/03/20.
//  Copyright © 2020 mehul modhvadiya. All rights reserved.
//

import UIKit
import SQLite3
import Foundation

class DatabaseHelper: NSObject {
    
    static let instance = DatabaseHelper()
    
    var db: OpaquePointer?
    
    private override init() {
    }
    
    
    func openDataBase()
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("StudentNewDb.sqlite")
        print("\(fileURL.path)")
        
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK {
            print("error opening database")
        }
        
        if sqlite3_exec(db, "CREATE TABLE IF NOT EXISTS Student4 (id INTEGER PRIMARY KEY AUTOINCREMENT, sname TEXT,Pdate TEXT , squestion TEXT, squestion1 TEXT)", nil,nil,nil) != SQLITE_OK {
            let errmsg = String(cString: sqlite3_errmsg(db)!)
            print("error creating table: \(errmsg)")
        }
        
        
    }
    func insertData(sname:String,date:String,question1:String,question2:String)
    {
        let insertStatementString = "INSERT INTO Student4 (sname,Pdate,squestion,squestion1) VALUES (?,?,?,?)"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (sname as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (date as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (question1 as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (question2 as NSString).utf8String, -1, nil)

            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func insertSname(sname:String,date:String)
    {
        let insertStatementString = "INSERT INTO Student3 (sname,Pdate) VALUES (?,?)"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (sname as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (date as NSString).utf8String, -1, nil)
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    func insertSquestion(squestion1:String)
    {
        let insertStatementString = "INSERT INTO Student3 (squestion) VALUES (?)"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 3, (squestion1 as NSString).utf8String, -1, nil)

            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func insertquestion2(squestion2:String)
    {
        let insertStatementString = "INSERT INTO Student3 (squestion1) VALUES (?)"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 4, (squestion2 as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
        func FetchAllStudentList() -> [StudentModel] {
            let queryStatementString = "SELECT * FROM Student4;"
            var queryStatement: OpaquePointer? = nil
            var studentList : [StudentModel] = []
            if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
                while sqlite3_step(queryStatement) == SQLITE_ROW {
                    let id = sqlite3_column_int(queryStatement, 0)
                    let sname = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                    let date = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                    let squestion = String(cString: sqlite3_column_text(queryStatement, 3))
                    let squestion1 = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                    
                    studentList.append(StudentModel(id: Int(id), Sname: sname, SQuestion1:squestion , SQuestion2: squestion1, Sdate: date))
                    print("Query Result:")
                    print("\(sname) | \(squestion) | \(squestion1)")
                    print("\(studentList.count)")
                }
            } else {
                print("SELECT statement could not be prepared")
            }
            sqlite3_finalize(queryStatement)
            return studentList
        }
    
    func deleteByID(id:Int) {
        let deleteStatementStirng = "DELETE FROM Student WHERE Id = ?;"
        var deleteStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(deleteStatement, 1, Int32(id))
            if sqlite3_step(deleteStatement) == SQLITE_DONE {
                print("Successfully deleted row.")
            } else {
                print("Could not delete row.")
            }
        } else {
            print("DELETE statement could not be prepared")
        }
        sqlite3_finalize(deleteStatement)
    }
    
    
    //let updateStatementString = "UPDATE Contact SET Name = 'Adam' WHERE Id = 1;"
    func updateStudentList(updateStatementString:String) {
        var updateStatement: OpaquePointer?
        if sqlite3_prepare_v2(db, updateStatementString, -1, &updateStatement, nil) ==
            SQLITE_OK {
            if sqlite3_step(updateStatement) == SQLITE_DONE {
                print("\nSuccessfully updated row.")
            } else {
                print("\nCould not update row.")
            }
        } else {
            print("\nUPDATE statement is not prepared")
        }
        sqlite3_finalize(updateStatement)
    }
    
}

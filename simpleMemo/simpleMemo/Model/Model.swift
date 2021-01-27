//
//  Model.swift
//  simpleMemo
//
//  Created by 정지현 on 2021/01/06.
//

import Foundation

class Memo: NSObject {
    var content: String
    var insertDate: Date
    
    init(content: String, insertDate: Date) {
        self.content = content
        self.insertDate = insertDate
        //insertDate = Date()
    }
    
    
    static var dummyMemoList = [
    Memo(content: "First memo", insertDate: Date()),
    Memo(content: "Second", insertDate: Date(timeIntervalSinceNow: 300)),
    Memo(content: "Third", insertDate: Date(timeIntervalSinceReferenceDate: 500)),
    Memo(content: "TableView Cell", insertDate: Date())
    ]
    
}

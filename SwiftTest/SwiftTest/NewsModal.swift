//
//  NewsModal.swift
//  SwiftTest
//
//  Created by Ranjan on 17/07/18.
//  Copyright © 2018 Ranjan. All rights reserved.
//

import Foundation

let DEFAULTVALUE = "NA"

// Extension to delete prefix from string
extension String {
    func deletingPrefix(_ prefix: String) -> String {
        guard self.hasPrefix(prefix) else { return self }
        return String(self.dropFirst(prefix.count))
    }
}
// This  modal object contains information of news
// Every object is one unique news
class NewsModal {
    
    var mainHeadline: String?
    var subHeadline: String?
    var author: String?
    var date: String?

    init(mainHeadline: String?,subHeadline: String?,author: String?,date: String?){
        
        self.mainHeadline = mainHeadline ?? DEFAULTVALUE
        self.subHeadline = subHeadline ?? DEFAULTVALUE
        self.author = author?.deletingPrefix("By ") ?? DEFAULTVALUE
        self.date = date ?? DEFAULTVALUE
        
    }
}

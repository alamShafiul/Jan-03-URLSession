//
//  Data.swift
//  Jan-03-URLSession_DataTask
//
//  Created by Admin on 4/1/23.
//

import Foundation

struct MyData: Decodable, Encodable {
    var id: Int
    var title: String
    var body: String
}

extension MyData {
    static var dataList: [MyData] = []
}

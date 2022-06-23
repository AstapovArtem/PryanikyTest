//
//  SearchResponse.swift
//  TestTask
//
//  Created by Artem Astapov on 22.06.2022.
//

import Foundation

struct SearchResponse: Decodable {
    var data: [DataElement]
    var view: [String]
}

struct DataElement: Decodable {
    var name: String
    var data: DataElementInfo
}

struct DataElementInfo : Decodable {
    var text: String?
    var url: String?
    var selectedId: Int?
    var variants: [Variant]?
}

struct Variant: Decodable {
    var id: Int
    var text: String
}

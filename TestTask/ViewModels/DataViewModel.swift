//
//  DataViewModel.swift
//  TestTask
//
//  Created by Artem Astapov on 23.06.2022.
//

import Foundation
import Kingfisher

class DataViewModel {
    
    private var networkService = NetworkService()
    
    var data: Box<[DataElement]> = Box([])
    var views: Box<[String]> = Box([])
    
    func receiveSearchResponse() {
        let _ = networkService.fetchData(from: UrlRequests.pryanikiJSONRequest) { [weak self] response in
            self?.views.value = response?.view ?? []
            self?.data.value = response?.data ?? []
        }
    }
}

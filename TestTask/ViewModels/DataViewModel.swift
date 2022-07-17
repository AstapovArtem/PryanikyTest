//
//  DataViewModel.swift
//  TestTask
//
//  Created by Artem Astapov on 23.06.2022.
//

import Foundation
import Kingfisher
import RxSwift


class DataViewModel {
    
    private var networkService = NetworkService()
    
    var data: PublishSubject<[DataElement]> = PublishSubject()
    var views: PublishSubject<[String]> = PublishSubject()
    
    func receiveData() {
        networkService.fetchData(from: UrlRequests.pryanikiJSONRequest) { [weak self] response in
            self?.data.onNext(response?.data ?? [])
            self?.views.onNext(response?.view ?? [])
        }
    }
    
}

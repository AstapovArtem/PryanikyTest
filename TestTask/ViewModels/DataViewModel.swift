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
    
    var searchResponse: PublishSubject<SearchResponse> = PublishSubject()
    
    func receiveData() {
        networkService.fetchData(from: UrlRequests.pryanikiJSONRequest) { [weak self] response in
            guard let response = response else { return }
            self?.searchResponse.onNext(response)
        }
    }
    
}

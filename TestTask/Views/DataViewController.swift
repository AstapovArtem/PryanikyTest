//
//  DataViewController.swift
//  TestTask
//
//  Created by Artem Astapov on 23.06.2022.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol DataViewControllerDelegate {
    func showAlert(text: String)
}

class DataViewController: UIViewController {
    
    private var viewsFactory: ViewsFactory?
    private var viewModel = DataViewModel()
    
    // MARK: UI Elements
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        scrollView.frame = view.bounds
        return scrollView
    }()
    
    private var label: UILabel = {
        let label = UILabel()
        label.text = "test"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = DataViewModelConstants.contentStackViewSpacing
        stackView.widthAnchor.constraint(equalToConstant: DataViewModelConstants.contentViewHeightWidth).isActive = true
        return stackView
    }()
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewsFactory = ViewsFactory(dataVcDelegate: self)
        viewModel.receiveData()
        setupElements()
        
        title = "Pryaniki"
        
        let response = viewModel.searchResponse.subscribe { [weak self] response in
            guard
                let data = response.element?.data,
                let views = response.element?.view
            else { return }
            
            views.map({
                guard let newView = self?.viewsFactory?.createLabel(with: $0, models: data) else { return }
                self?.stackView.addArrangedSubview(newView)
            })
            
            let calculatedScrollViewSize = CGSize(width: self?.view.frame.width ?? 0, height: ViewHeightCalculated.viewHeight(views: views))
            if self?.scrollView.frame.height ?? 0 < calculatedScrollViewSize.height {
                self?.scrollView.contentSize = calculatedScrollViewSize
            }
        }

    }
    
    // MARK: Setup UI elements
    
    private func setupElements() {
        view.addSubview(scrollView)
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        
        scrollView.addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: DataViewModelConstants.contentTopAnchor).isActive = true
    }
    
}

extension DataViewController: DataViewControllerDelegate {
    
    func showAlert(text: String) {
        let alert = UIAlertController(title: "Оповещение", message: "Вы вызвали элемент: \n\(text)", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    
}

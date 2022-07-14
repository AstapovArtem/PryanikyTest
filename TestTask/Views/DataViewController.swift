//
//  DataViewController.swift
//  TestTask
//
//  Created by Artem Astapov on 23.06.2022.
//

import Foundation
import UIKit

protocol DataViewControllerDelegate {
    func showAlert(text: String)
}

class DataViewController: UIViewController {
    
    private var viewsFactory: ViewsFactory?
    private var viewModel = DataViewModel()
    private var views: [String]?
    private var data: [DataElement]?
    
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
        viewModel.receiveSearchResponse()
        setupElements()
        bindViews()
        bindData()
        
        title = "Pryaniki"
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
    
    private func loadViews() {
        guard let views = views, let data = data else { return }
        
        for view in views {
            guard let newView = viewsFactory?.createLabel(with: view, models: data) else { return }
            newView.widthAnchor.constraint(equalToConstant: DataViewModelConstants.contentViewHeightWidth).isActive = true
            newView.heightAnchor.constraint(equalToConstant: DataViewModelConstants.contentViewHeightWidth).isActive = true
            stackView.addArrangedSubview(newView)
        }
        
        let calculatedScrollViewSize = CGSize(width: view.frame.width, height: ViewHeightCalculated.viewHeight(elements: views.count))
        if scrollView.bounds.height < calculatedScrollViewSize.height {
            scrollView.contentSize = calculatedScrollViewSize
        }
    }
    
    // MARK: Binding data
    
    private func bindViews() {
        viewModel.views.bind { (views) in
            DispatchQueue.main.async {
                self.views = views
            }
        }
    }
    
    private func bindData() {
        viewModel.data.bind { data in
            DispatchQueue.main.async {
                self.data = data
                self.loadViews()
            }
        }
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

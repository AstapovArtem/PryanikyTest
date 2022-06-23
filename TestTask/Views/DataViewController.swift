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
        stackView.spacing = 5
        stackView.widthAnchor.constraint(equalToConstant: 130).isActive = true
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
    }
    
    // MARK: Setup UI elements
    
    private func setupElements() {
        view.addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    private func loadViews() {
        guard let views = views, let data = data else { return }

        for view in views {
            guard let newView = viewsFactory?.createLabel(with: view, models: data) else { return }
            newView.widthAnchor.constraint(equalToConstant: 130).isActive = true
            newView.heightAnchor.constraint(equalToConstant: 130).isActive = true
            newView.backgroundColor = .systemGray5
            stackView.addArrangedSubview(newView)
            
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

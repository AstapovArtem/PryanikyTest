//
//  MainViewController.swift
//  TestTask
//
//  Created by Artem Astapov on 23.06.2022.
//

import Foundation
import UIKit
import Kingfisher


class MainViewController: UIViewController {
    
    // MARK: UI Elements
    
    private var receiveDataButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Receive data", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 20
        button.layer.shadowOpacity = 0.4
        button.layer.shadowOffset = CGSize(width: 2.5, height: 4)
        button.layer.shadowRadius = 3
        return button
    }()
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupReceiveDataButton()
    }
    
    // MARK: Setup UI Elements
    
    private func setupReceiveDataButton() {
        view.addSubview(receiveDataButton)
        receiveDataButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        receiveDataButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        receiveDataButton.widthAnchor.constraint(equalToConstant: 200).isActive = true
        receiveDataButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        receiveDataButton.addTarget(self, action: #selector(openDataVC), for: .touchUpInside)

    }
    
    // MARK: Button actions
    
    @objc func openDataVC() {
        let vc = DataViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

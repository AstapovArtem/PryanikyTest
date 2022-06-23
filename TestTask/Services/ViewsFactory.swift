//
//  LabelFactory.swift
//  TestTask
//
//  Created by Artem Astapov on 23.06.2022.
//

import Foundation
import UIKit
import Kingfisher
private var assocKey : UInt8 = 0

class ViewsFactory {
    
    var dataVcDelegate: DataViewControllerDelegate
    
    private var viewSize: CGFloat = 100
    
    func createLabel(with id: String, models: [DataElement]) -> UIView? {
        switch id.description {
        case "hz":
            let model = models.filter({ $0.name == "hz" })
            guard let element = model.first?.data else { return nil}
            return generateHzView(element: element)
        case "selector":
            let model = models.filter({ $0.name == "selector" })
            guard let element = model.first?.data else { return nil }
            return generateSelectorStackView(element: element)
        case "picture":
            guard let model = models.filter({ $0.name == "picture" }).first else { return nil }
            return generatePictureView(element: model.data)
        default:
            return nil
        }
    }
    
    // MARK: Init
    
    init(dataVcDelegate: DataViewControllerDelegate) {
        self.dataVcDelegate = dataVcDelegate
    }
    
    // MARK: Generating views
    
    private func generateHzView(element: DataElementInfo) -> UIView? {
        let view = UIView()
        
        guard let text = element.text else { return nil }
        let textLabel = UILabel()
        textLabel.text = text
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(textLabel)
        textLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showAlert(sender:)))
        guard let text = element.text else { return textLabel }
        tap.text = text
        view.addGestureRecognizer(tap)
        
        return view
    }
    
    private func generatePictureView(element: DataElementInfo) -> UIImageView? {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.isUserInteractionEnabled = true
        
        guard let urlString = element.url else { return nil }
        let url = URL(string: urlString)
        imageView.kf.setImage(with: url)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(showAlert(sender:)))
        guard let text = element.text else { return imageView }
        tap.text = text
        imageView.addGestureRecognizer(tap)
        
        return imageView
    }
    
    private func generateSelectorStackView(element: DataElementInfo) -> UIView? {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.distribution = .equalCentering
        
        view.addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        guard let variants: [Variant] = element.variants else { return UIView() }
        
        for variant in variants {
            let label = UILabel()
            label.text = variant.text
            label.isUserInteractionEnabled = true
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(showAlert(sender:)))
            tap.text = String(variant.id)
            label.addGestureRecognizer(tap)
            
            stackView.addArrangedSubview(label)
        }
        
        return view
    }
    
    // MARK: Actions
    
    @objc func showAlert(sender: UITapGestureRecognizer) {
        dataVcDelegate.showAlert(text: sender.text)
    }
    
}

extension UITapGestureRecognizer {
    
    public var text:String{
        get{
            return objc_getAssociatedObject(self, &assocKey) as! String
        }
        set(newValue){
            objc_setAssociatedObject(self, &assocKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
        }
    }
}

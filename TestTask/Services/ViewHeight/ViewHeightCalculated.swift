//
//  ViewHeightCalculated.swift
//  TestTask
//
//  Created by Artem Astapov on 14.07.2022.
//

import UIKit


class ViewHeightCalculated {
    
    static func viewHeight(elements: Int) -> CGFloat {
        let elements = CGFloat(elements)
        
        let elementsHeight = DataViewModelConstants.contentViewHeightWidth * elements
        
        return DataViewModelConstants.contentTopAnchor * 2 + elementsHeight + (DataViewModelConstants.contentStackViewSpacing * (elements - 1))
    }
}

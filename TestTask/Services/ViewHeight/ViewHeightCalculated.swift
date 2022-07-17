//
//  ViewHeightCalculated.swift
//  TestTask
//
//  Created by Artem Astapov on 14.07.2022.
//

import UIKit


class ViewHeightCalculated {
    
    static func viewHeight(views: [String]) -> CGFloat {
        var totalHeight: CGFloat = DataViewModelConstants.contentTopAnchor
        
        for view in views {
            switch view {
            case "hz": totalHeight += DataViewModelConstants.hzViewHeight + DataViewModelConstants.contentStackViewSpacing
            case "picture": totalHeight += DataViewModelConstants.contentViewHeightWidth + DataViewModelConstants.contentStackViewSpacing
            case "selector": totalHeight += DataViewModelConstants.selectorHeight + DataViewModelConstants.contentStackViewSpacing
            default: totalHeight += 0
            }
        }
        
        return totalHeight
    }
}

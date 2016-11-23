//
//  RatingControl.swift
//  MovieAssistant
//
//  Created by Adam Parr on 15/11/2016.
//  Copyright © 2016 Adam Parr. All rights reserved.
//

import UIKit

class RatingControl: UIView {
    
    // MARK: Properties
    
    var rating:Int = 0 {
        didSet {
            updateButtonSelections()
        }
    }
    var buttons = [UIButton]()
    
    // MARK: Methods
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let filledStar = UIImage(named: "filledStar")
        let emptyStar = UIImage(named: "emptyStar")
        
        // Create our 5 buttons
        for _ in 0 ..< 5 {
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: 44, height: 44))
            button.addTarget(self, action: #selector(buttonTapped), for: .touchDown)
            
            button.adjustsImageWhenHighlighted = false
            
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(filledStar, for: [.highlighted, .selected])
            
            buttons.append(button)
            addSubview(button)
        }
    }
    
    
    override func layoutSubviews() {
        
        var frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        
        // For each button in buttons move over button width + spacing
        for (index, button) in buttons.enumerated() {
            frame.origin.x = CGFloat(index * (44 + 5))
            button.frame = frame
        }
        
        updateButtonSelections()
    }
    
    
    func buttonTapped(button: UIButton) {

        rating = buttons.index(of: button)! + 1
        
        updateButtonSelections()
    }
    
    
    func updateButtonSelections() {
        
        // If index of button is less than rating then select it
        for (index, button) in buttons.enumerated() {
            button.isSelected = index < rating
        }
    }

}

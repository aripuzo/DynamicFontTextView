//
//  DynamicFontTextView.swift
//  DynamicFontTextView
//
//  Created by ari on 28/03/2021.
//  Copyright © 2021 Button Technology. All rights reserved.
//

import UIKit

@IBDesignable
class DynamicFontTextView: UITextView {
    
    var maxCount = 300
    var steps: CGFloat!
    
    var startFontSize: CGFloat? = 26 {
        didSet {
            steps = (startFontSize! - endFontSize!) + 1
        }
    }
    
    var endFontSize: CGFloat? = 17 {
        didSet {
            steps = (startFontSize! - endFontSize!) + 1
        }
    }
    
    override func layoutSubviews() {
        self.delegate = self
    }
    
}

extension DynamicFontTextView: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let currentText = textView.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: text)
        let count = updatedText.count
        
        let currentStep = steps - CGFloat(floor(Double(maxCount)/Double(count)))
        
        textView.font = UIFont(name: textView.font!.fontName, size: endFontSize! + currentStep)
        
        return  count <= maxCount
    }
    
    
}

//
//  FlipCoinKit.swift
//
//  Created by Tobias Schultka on 05.08.16.
//  Copyright © 2016 tobias-schultka.com. All rights reserved.
//

import Foundation
import UIKit

class FlipCoinManager {
    
    private enum Progress: Float {
        case Full = 0.0
        case Half = 0.5
    }
    
    private let FLIP_COIN_ANIMATON_KEY = "flipCoinAnimation"
    private let TRANSITION_TYPE = "flip"
    private let TRANSITION_SUBTYPE = "fromRight"
    
    private var mainView: UIView
    private var images: [UIImage]
    private var imageView: UIImageView?
    private var completion: (() -> Void)?
    
    private var isRotating: Bool = false
    private var isStopping: Bool = false
    
    private var currentIndex: Int = 0
    private var stopIndex: Int = 0
    
    var speed: Double = 0.20
    
    init(view: UIView, images: [UIImage]) {
        self.mainView = view
        self.images = images
        
        for (index, image) in images.enumerate() {
            if (index == 0) {
                addImage(image)
            }
        }
    }
    
    // add image view to main view
    private func addImage(image: UIImage) {
        let imageView = UIImageView(image: image)
        
        imageView.frame = CGRect(
            x: 0,
            y: 0,
            width: mainView.frame.width,
            height: mainView.frame.height
        )
        
        mainView.addSubview(imageView)
        self.imageView = imageView
    }
    
    // start half or full flip animation
    private func flip(progress: Progress) {
        CATransaction.begin()
        CATransaction.setCompletionBlock({
            self.flipComplete(progress)
        })
        
        let transition = CATransition()
        
        transition.startProgress = progress.rawValue
        transition.endProgress = progress.rawValue + 0.5
        transition.type = TRANSITION_TYPE
        transition.subtype = TRANSITION_SUBTYPE
        transition.duration = speed
        transition.repeatCount = 0
        transition.fillMode = kCAFillModeForwards
        transition.removedOnCompletion = false
        
        mainView.layer.addAnimation(transition, forKey: FLIP_COIN_ANIMATON_KEY)
        
        CATransaction.commit()
    }
    
    // increase current index or go back to zero, if last image is reached
    private func increaseCurrentIndex() {
        currentIndex += 1
        
        if (currentIndex == images.count) {
            currentIndex = 0
        }
    }
    
    // event is called after every half round
    private func flipComplete(progress: Progress) {
        if (!isRotating) {
            return
        }
        
        // it's also possible to flip a colored view, without any images
        if let imageView = self.imageView {
            if (progress == .Full) {
                increaseCurrentIndex()
                imageView.image = self.images[currentIndex]
            }
        }
        
        if (currentIndex == stopIndex && isStopping && progress == .Half) {
            stopFlipping(currentIndex)
        } else {
            self.flip(progress == .Full ? .Half : .Full)
        }
    }
    
    // start infinite flipping
    func startFlipping() {
        if (isRotating) {
            return
        }
        
        isStopping = false
        isRotating = true
        completion = nil
        flip(.Full)
    }
    
    // stop flipping as soon as image is reached
    func stopFlipping(index: Int, completion: () -> Void) {
        isStopping = true
        stopIndex = index
        self.completion = completion
    }
    
    // stop flipping immediately
    func stopFlipping(index: Int) {
        isRotating = false
        isStopping = false
        
        if let imageView = self.imageView {
            imageView.image = self.images[index]
        }
        
        if let completion = self.completion {
            completion()
        }
        
        mainView.layer.removeAllAnimations()
    }
}

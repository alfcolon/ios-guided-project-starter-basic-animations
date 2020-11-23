//
//  ViewController.swift
//  BasicAnimations
//
//  Created by alfredo on 1/28/20.
//  Copyright © 2020 Alfredo. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLabel()
        configureButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        label.center = self.view.center //moving label to middle of the screen
    }
    
    func configureLabel(){
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        label.widthAnchor.constraint(equalTo: label.heightAnchor).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 12
        
        label.text = "💃🏾"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 96)
    }

    func configureButtons(){
        
        //MARK: 1. Create Buttons, Set Attribues, Add To View
        
        let rotateButton = UIButton(type: .system)
        rotateButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(rotateButton)
        rotateButton.setTitle("Rotate", for: .normal)
        //target: runs action
        rotateButton.addTarget(self, action: #selector(rotateButtonTapped), for: .touchUpInside)
        
        let keyButton = UIButton(type: .system)
        keyButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(keyButton)
        keyButton.setTitle("Key", for: .normal)
        //target: runs action
        keyButton.addTarget(self, action: #selector(keyButtonTapped), for: .touchUpInside)
        
        let springButton = UIButton(type: .system)
        springButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(springButton)
        springButton.setTitle("Spring", for: .normal)
        //target: runs action
        springButton.addTarget(self, action: #selector(springButtonTapped), for: .touchUpInside)
        
        let squashButton = UIButton(type: .system)
        squashButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(squashButton)
        squashButton.setTitle("Squash", for: .normal)
        //target: runs action
        squashButton.addTarget(self, action: #selector(squashButtonTapped), for: .touchUpInside)

        let anticipationButton = UIButton(type: .system)
        anticipationButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(anticipationButton)
        anticipationButton.setTitle("Anticipation", for: .normal)
        //target: runs action
        anticipationButton.addTarget(self, action: #selector(anticipationButtonTapped), for: .touchUpInside)
        
        //MARK: 2. Create Stackview, Set Attributes, Add to View
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        //MARK: 3. Add Buttons to Stackview
        
        stackView.addArrangedSubview(rotateButton) //add button inside stackview
        stackView.addArrangedSubview(keyButton)
        stackView.addArrangedSubview(springButton)
        stackView.addArrangedSubview(squashButton)
        stackView.addArrangedSubview(anticipationButton)
        
        //Method 4 for activating constraints
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
    }
    
    @objc func rotateButtonTapped(){
        label.center = view.center //make sure center of label is in center of the view
        
        UIView.animate(withDuration: 2.0, animations: {
            //what you want the view to look like when the animation is complete
            self.label.transform = CGAffineTransform(rotationAngle: CGFloat.pi/4)//45 degree of rotation
        }) { (_) in
            //completion closure allows you to do something to the object after it is transformed
            UIView.animate(withDuration: 2.0){
                //identity transform is the original state of that view
                self.label.transform = .identity
            }
        }
    }
    @objc func keyButtonTapped(){
        label.center = view.center //make sure center of label is in center of the view
        
        UIView.animateKeyframes(withDuration: 5.0, delay: 0, options: [], animations: {
            //Create a collection of keyframes
            //withRelativeStartTime: check documentation
            //relativeDuration: % of totalAnimationTime frame will run for
            
            //MARK: Breaking Animation Up Into 4 Different Key Frames
            
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
                //Transform label by 45 Degress
                self.label.transform = CGAffineTransform(rotationAngle: CGFloat.pi/4)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25){
                self.label.transform = .identity
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.25){
                self.label.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 50)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25){
                self.label.center = self.view.center
            }
        }, completion: nil)
    }
    
    @objc func springButtonTapped(){
        label.center = self.view.center
        //transform label before the animation is run (make smaller)
        label.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        UIView.animate(withDuration: 3.0, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
            //endstate is sets the label to it's original size
            self.label.transform = .identity
            
        }, completion: nil)
    }
    
    @objc func squashButtonTapped(){
        //push label off screen
        label.center = CGPoint(x: view.center.x, y: -label.bounds.size.height)
        let animationBlock = {
            //0-40% run:
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4) {
                self.label.center = self.view.center
            }
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.2) {
                self.label.transform = CGAffineTransform(scaleX: 1.7, y: 0.6)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.2) {
                self.label.transform = CGAffineTransform(scaleX: 0.6, y: 1.7)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.15) {
                self.label.transform = CGAffineTransform(scaleX: 1.11, y: 0.9)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.85, relativeDuration: 0.15) {
                self.label.transform = .identity
            }
        }
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: [], animations: animationBlock, completion: nil)
    }
    
    @objc func anticipationButtonTapped(){
        let animationBlock = {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.1) {
                self.label.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 16.0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.1, relativeDuration: 0.2) {
                self.label.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 16.0)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.8) {
                self.label.center = CGPoint(
                    x: self.view.bounds.size.width + self.label.bounds.size.width,
                    y: self.view.center.y)
            }
        }
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: [], animations: animationBlock, completion: nil)
    }
}


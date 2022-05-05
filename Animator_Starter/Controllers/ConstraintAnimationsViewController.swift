//
//  ConstraintAnimationsViewController.swift
//  Animator_Starter
//
//  Created by Harrison Ferrone on 18.02.18.
//  Copyright © 2018 Paradigm Shift Development, LLC. All rights reserved.
//

import UIKit

class ConstraintAnimationsViewController: UIViewController {
    
    // MARK: Storyboard outlets
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var newsletterView: UIView!
    @IBOutlet weak var welcomeCenterX: NSLayoutConstraint!
    @IBOutlet weak var newsletterCenterX: NSLayoutConstraint!
    
    // MARK: Additional variables
    var newsletterInfoLabel = UILabel()
    var animationManager: AnimationManager!
    
    // MARK: Appearance
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Programmatic views
        newsletterInfoLabel.backgroundColor = .clear
        newsletterInfoLabel.text = "Help us make your animation code that much better by subscribing to our weekly newsletter! \n\n It's free and you can unsubscribe any time without hurting our feelings...much."
        newsletterInfoLabel.font = UIFont(name: "Bodoni 72 Oldstyle", size: 15)
        newsletterInfoLabel.textColor = .darkGray
        newsletterInfoLabel.textAlignment = .left
        newsletterInfoLabel.alpha = 0
        newsletterInfoLabel.backgroundColor = .clear
        newsletterInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        newsletterInfoLabel.numberOfLines = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // TODO: Offscreen positioning
        self.animationManager = AnimationManager.init(activeConstraints: [welcomeCenterX, newsletterCenterX])
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // TODO: Fire initial animations
        self.animateViewsOnScreen()
    }
    
    // MARK: Actions
    @IBAction func moreInfoPressed(_ sender: Any) {
        self.animateNewsLetterHeight()
        self.animateWelcomeLabel()
    }
    
    // MARK: Animations
    func animateViewsOnScreen() {
        UIView.animate(withDuration: 1.5, delay: 0.25, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [.curveEaseInOut]) {
            self.welcomeCenterX.constant = self.animationManager.constraintsOrigins[0]
            self.newsletterCenterX.constant = self.animationManager.constraintsOrigins[1]
            self.view.layoutIfNeeded()
        }
    }
    
    func animateNewsLetterHeight() {
        if let heightConstraint = self.newsletterView.returnConstraint(withID: "NewsLetterHeightConstraint") {
            print(heightConstraint.debugDescription)
            heightConstraint.constant = 350
            UIView.animate(withDuration: 1.75, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: []) {
                self.view.layoutIfNeeded()
            } completion: { completed in
                self.addDynamicInfoLabel()
            }
        } else {
            
        }
    }
    
    func animateWelcomeLabel() {
        let modifiedTopConstraint = NSLayoutConstraint(item: self.welcomeLabel, attribute: .top, relatedBy: .equal, toItem: self.welcomeLabel.superview, attribute: .top, multiplier: 1, constant: 100)
        if let topConstraint = self.view.returnConstraint(withID: "WelcomeTopConstraint") {
            topConstraint.isActive = false
            modifiedTopConstraint.isActive = true
        } else {
           
        }
        UIView.animate(withDuration: 0.75) {
            self.view.layoutIfNeeded()
        }
    }
    
    func addDynamicInfoLabel() {
        newsletterView.addSubview(newsletterInfoLabel)
        let xAnchor = self.newsletterInfoLabel.centerXAnchor.constraint(equalTo: self.newsletterView.leftAnchor, constant: -75)
        let yAnchor = self.newsletterInfoLabel.centerYAnchor.constraint(equalTo: self.newsletterView.centerYAnchor)
        let widthAnchor = self.newsletterInfoLabel.widthAnchor.constraint(equalTo: self.newsletterView.widthAnchor, multiplier: 0.75)
        let heightAnchor = self.newsletterInfoLabel.heightAnchor.constraint(equalTo: self.newsletterView.widthAnchor)
        NSLayoutConstraint.activate([xAnchor,yAnchor,widthAnchor,heightAnchor])
        self.view.layoutIfNeeded()
    
        UIView.animate(withDuration: 0.75) {
            xAnchor.constant = self.newsletterView.frame.size.width/2
            self.newsletterInfoLabel.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
}

extension UIView {
    func returnConstraint(withID: String) -> NSLayoutConstraint? {
        var searchConstraint: NSLayoutConstraint?
        for constraint in self.constraints {
            if constraint.identifier == withID {
                searchConstraint = constraint
            }
        }
        return searchConstraint
    }
}

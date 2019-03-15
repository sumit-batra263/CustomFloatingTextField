//
//  FloatingTextField.swift
//  MVVM
//
//  Created by User on 13/03/19.
//  Copyright © 2019 User. All rights reserved.
//

import Foundation
import UIKit

/*
    Enum to classify text field
 */
enum TextFieldType{
    case normal, password
}


class FloatingTextField:UITextField{
    //MARK: Properties
    private var usernameLabelYAnchorConstraint: NSLayoutConstraint!
    private var usernameLabelLeadingAnchor: NSLayoutConstraint!
    public var textFieldType:TextFieldType!{
        didSet{
            if textFieldType == .normal{
                usernameLabel.text = "Username"
            }else {
                usernameLabel.text = "Password"
                self.isSecureTextEntry = true
            }
        }
    }
    
    private lazy var usernameLabel:UILabel! = {
        let label = UILabel()
        label.text = "Username"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.alpha = 0.5
        return label
    }()
    
    //MARK: Initialization Functions
    init() {
        super.init(frame:UIScreen.main.bounds)
        load()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public override func awakeFromNib() {
        load()
    }
    
    //MARK: Helper Functions
    
    /// This function apply necessary changes to the view
    private func  load(){
            addSubview(usernameLabel)
            backgroundColor = UIColor.white
            configureViews()
    }
    
    /// This function applying necessary constraints to the **usernameLabel** property
    func configureViews() {
        usernameLabelYAnchorConstraint = usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0)
        usernameLabelLeadingAnchor = usernameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5)
        NSLayoutConstraint.activate([
            usernameLabelYAnchorConstraint,
            usernameLabelLeadingAnchor,
            ])
    }
    
    /// Call this function when the textfield begins editing. This will shift the placeholder label **usernameLabel** up using an animation.
    func callWhenTextDidBeginEditing(){
        usernameLabel.alpha = 0.5
        usernameLabelYAnchorConstraint.constant = -25
        usernameLabelLeadingAnchor.constant = 0
        performAnimation(transform: CGAffineTransform(scaleX: 0.8, y: 0.8))
    }
    
    /// Call this function when the textfield did end editing. This will move back the label into its original position using an animation.
    func callWhenTextDidEndEditing(){
        if self.text!.count > 0 {return}
        usernameLabelYAnchorConstraint.constant = 0
        usernameLabelLeadingAnchor.constant = 5
        performAnimation(transform: CGAffineTransform(scaleX: 1, y: 1))
    }
    
    /// This function applies transform to the **usernameLabel** using a UIView animation.
    func performAnimation(transform: CGAffineTransform) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.usernameLabel.transform = transform
            self.layoutIfNeeded()
        }, completion:nil)
    }
    
}


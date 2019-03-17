//
//  ViewController.swift
//  CustomFloatingTextField
//
//  Created by Sumit Batra on 13/03/19.
//  Copyright © 2019 Sumit Batra. All rights reserved.

import UIKit

class ViewController: UIViewController {
  
    @IBOutlet weak var userNameTxtField: FloatingTextField!
    @IBOutlet weak var passwordTxtField: FloatingTextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        userNameTxtField.delegate = self
        passwordTxtField.textFieldType = .password
    }

    //MARK: Actions
    @IBAction func loginBtnAction(_ sender: Any) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            userNameTxtField.resignFirstResponder()
            userNameTxtField.callWhenTextDidEndEditing()
            passwordTxtField.resignFirstResponder()
            passwordTxtField.callWhenTextDidEndEditing()
    }
    
}

extension ViewController:UITextFieldDelegate{
    
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            return textField.resignFirstResponder()
        }
        
        func textFieldDidBeginEditing(_ textField: UITextField) {
            if textField == userNameTxtField{
                userNameTxtField.callWhenTextDidBeginEditing()
            }else{
                passwordTxtField.callWhenTextDidBeginEditing()
            }
        }
        
        func textFieldDidEndEditing(_ textField: UITextField) {
            if let text = textField.text, text.isEmpty {
                if textField == userNameTxtField{
                    userNameTxtField.callWhenTextDidEndEditing()
                }else{
                    passwordTxtField.callWhenTextDidEndEditing()
                }
            }
        }
}

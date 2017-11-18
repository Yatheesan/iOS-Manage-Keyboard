//
//  ViewController.swift
//  SampleProject
//
//  Created by Yatheesan Chandreswaran on 11/18/17.
//  Copyright © 2017 Yatheesan Chandreswaran. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var UserNameTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    @IBOutlet weak var filedOne: UITextField!
    
    @IBOutlet weak var loginBtn: UIButton!
    var activeTextField : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let center: NotificationCenter = NotificationCenter.default;
        center.addObserver(self, selector: #selector(keyboardDidShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        center.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func keyboardDidShow(notification: Notification){
        let info: NSDictionary = notification.userInfo! as NSDictionary
        let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        let keyboardY = self.view.frame.size.height - keyboardSize.height
        let editingTextFieldY : CGFloat! = self.activeTextField?.frame.origin.y
        
        if self.view.frame.origin.y >= 0 {
            //Checking if the textfield is really hidden behind the keyboard
            if editingTextFieldY > keyboardY - 60 {
                UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                    self.view.frame = CGRect(x: 0, y: self.view.frame.origin.y - (editingTextFieldY! - (keyboardY - 60)), width: self.view.bounds.width, height: self.view.bounds.height)
                }, completion: nil)
            }
        }
        
    }
    
    @objc func keyboardWillHide(notification: Notification){
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height)
        }, completion: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    @IBAction func userTapped(_ sender: Any) {
        self.UserNameTextField.resignFirstResponder()
        self.PasswordTextField.resignFirstResponder()
        self.filedOne.resignFirstResponder()
    }
    
    
}


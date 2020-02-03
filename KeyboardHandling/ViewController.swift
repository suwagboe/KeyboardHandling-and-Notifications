//
//  ViewController.swift
//  KeyboardHandling
//
//  Created by Amy Alsaydi on 2/3/20.
//  Copyright © 2020 Amy Alsaydi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //outlets
    @IBOutlet weak var pursuitLogo: UIImageView!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var pursuitLogoCenteryConstriant: NSLayoutConstraint!

    private var keyboardIsVisible = false
    private  var originalYConstraint: NSLayoutConstraint!
    //the constaint for the height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        registerForKeyboardNotification()
       // puslateLogo()
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        
    }
    //NotificationCenter is like a caller ... it will know when things happen and react.
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyobardNotification()
    }
    
    private func registerForKeyboardNotification(){
        //NotificationCenter.default - singleton
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        
          NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    private func unregisterForKeyobardNotification(){
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc
    private func keyboardWillShow(_ notification: NSNotification){
        print("keyboardWillShow")
     //   print(notification.userInfo)
        //UIKeyboardFrameBeginUserInfoKey
        guard let keyboardFrame = notification.userInfo?["UIKeyboardFrameBeginUserInfoKey"] as? CGRect else {
            return
            // shouldn't do a fatalError.. because you dont wanna crash the app if you dont get the info you wanted
        }
        moveKeyboardUp(keyboardFrame.size.height)
    }
    
    @objc
    private func keyboardWillHide(_ notification: NSNotification){
        resetUI()
        print("keyboardWillhide")
       // print(notification.userInfo)
        // ToDo: Complete
    }

    private func moveKeyboardUp(_ height: CGFloat){
        if keyboardIsVisible {return} // prevents the constraints from running multiple times.
        originalYConstraint = pursuitLogoCenteryConstriant // save the original value
        
        pursuitLogoCenteryConstriant.constant -= (height * 0.8)
       // print("originalYCondtraint :\(originalYConstraint)")
        UIView.animate(withDuration: 0.5){
            self.view.layoutIfNeeded()
        }
        
        keyboardIsVisible = true
    }
    
    // writing a method that will reset everything
    private func resetUI(){
        keyboardIsVisible = false
        // need a value to keep the original value of the constaint because we changed it
        // we can do the below because we KNOW the value of 0 before
       // pursuitLogoCenteryConstriant.constant = 0
        pursuitLogoCenteryConstriant.constant -= originalYConstraint.constant
        
        UIView.animate(withDuration: 1.0){
            self.view.layoutIfNeeded()
        }
    }
    
    private func puslateLogo(){
        UIView.animate(withDuration: 0.3, delay: 0.0, options: [.repeat], animations: { self.pursuitLogo.transform = CGAffineTransform(scaleX: 1.2, y: 1.2) }, completion: nil)
    }
}

extension ViewController: UITextFieldDelegate{
     
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
     //   resetUI()
        
       // print("originalYCondtraint :\(originalYConstraint)")
        return true
    }
    
    
}


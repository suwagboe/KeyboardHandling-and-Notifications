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
    
    //the constaint for the height
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        userNameTextField.delegate = self
        passwordTextField.delegate = self
        registerForKeyboardNotification()
    }
    
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
           pursuitLogoCenteryConstriant.constant -= height
        
        keyboardIsVisible = true
    }
    
    // writing a method that will reset everything
    private func resetUI(){
        keyboardIsVisible = false
        // need a value to keep the original value of the constaint because we changed it
        // we can do the below because we KNOW the value of 0 before
        pursuitLogoCenteryConstriant.constant = 0
    }
}

extension ViewController: UITextFieldDelegate{
     
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        resetUI()
        return true
    }
    
    
}


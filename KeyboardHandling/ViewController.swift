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
    @IBOutlet weak var pursuitLogoCenterConstriant: NSLayoutConstraint!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
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
        print("keyboard frame is: \(keyboardFrame)")
    }
    
    @objc
    private func keyboardWillHide(_ notification: NSNotification){
        print("keyboardWillhide")
        print(notification.userInfo)
    }


}


//
//  ViewController.swift
//  TextField的DidBeginEditing代理
//
//  Created by 贺嘉炜 on 2017/7/10.
//  Copyright © 2017年 贺嘉炜. All rights reserved.
//

import UIKit

class ViewController: UIViewController ,UITextFieldDelegate {

    @IBOutlet var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
//        textField.resignFirstResponder()
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }

}


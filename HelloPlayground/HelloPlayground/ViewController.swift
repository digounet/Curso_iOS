//
//  ViewController.swift
//  HelloPlayground
//
//  Created by Treinamento on 27/07/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var lblMsg: UILabel!
    
    var clickCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        lblMsg.text = CalendarUtil.getCurrentDateAsText()
    }

    
    @IBAction func btnCountClick(_ sender: Any) {
        clickCount = clickCount + 1
        lblMsg.text = String(clickCount)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


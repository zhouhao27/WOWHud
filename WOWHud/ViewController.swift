//
//  ViewController.swift
//  WOWHud
//
//  Created by Zhou Hao on 20/8/15.
//  Copyright © 2015 Zhou Hao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showHud(sender: AnyObject) {
        
        let hud = WOWHud.showHudInView(self.view)
        hud.text = "Loading"
        
        GCD.delay(12) { () -> () in

            WOWHud.dismissHud()
        }
        
    }

}


//
//  HomePageController.swift
//  BeeKey
//
//  Created by Kirill on 22.02.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit

class HomePageController: UIViewController {
    
    @IBAction func signInPerform(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "signIn")
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromRight
        view.window!.layer.add(transition, forKey: kCATransition)
        
        self.present(resultViewController, animated:false, completion:nil)
    }
    @IBAction func registration(_ sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "registration")
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromTop
        view.window!.layer.add(transition, forKey: kCATransition)
        
        self.present(resultViewController, animated:false, completion:nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

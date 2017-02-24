//
//  informationTableViewController.swift
//  BeeKey
//
//  Created by Влад Бирюков on 24.01.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit
import RealmSwift

class informationTableViewController: UITableViewController {

    @IBOutlet weak var key_name: UILabel!
    @IBOutlet weak var site: UILabel!
    @IBOutlet weak var login: UILabel!
    @IBOutlet weak var password: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    
    let key_encrypt = "bbC2H19lkVbQDfakxcrtNMQdd0FloLyw"
    let iv = "gqLOHUioQ0QjhuvI"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(informationTableViewController.swiped(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        let backgroundImage = UIImage(named: "tableBackground")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        
        let realm = try! Realm()
        let key = realm.objects(Keys.self).filter("activity == true").first
        
        key_name.text = key!.key_name
        site.text = key!.site
        login.text = key!.login
        password.text = try! key!.password.decrypt(key_encrypt, iv)
        photoImage.image = UIImage(named: key!.image)
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let translationTransform = CATransform3DTranslate(CATransform3DIdentity, -500, 400, 0)
        cell.layer.transform = translationTransform
        cell.backgroundColor = .clear
        
        UIView.animate(withDuration: 1, delay: 0.1 * Double(indexPath.row), options: .curveEaseInOut, animations: {
            cell.layer.transform = CATransform3DIdentity
        })
    }
    
    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        let realm = try! Realm()
        let key = realm.objects(Keys.self).filter("activity == true").first
        
        try! realm.write {
            key!.activity = false
        }
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "TableLeyController")
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        view.window!.layer.add(transition, forKey: kCATransition)
        
        self.present(resultViewController, animated:false, completion:nil)
    }
    
    func swiped(_ gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer{
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                
                let resultViewController = storyBoard.instantiateViewController(withIdentifier: "TableLeyController")
                let transition = CATransition()
                transition.duration = 0.5
                transition.type = kCATransitionPush
                transition.subtype = kCATransitionFromLeft
                view.window!.layer.add(transition, forKey: kCATransition)
                
                self.present(resultViewController, animated:false, completion:nil)
            default:
                break
            }
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    

}

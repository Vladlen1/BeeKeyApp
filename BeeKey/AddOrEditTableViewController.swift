//
//  AddOrEditTableViewController.swift
//  BeeKey
//
//  Created by Влад Бирюков on 24.01.17.
//  Copyright © 2017 Влад Бирюков. All rights reserved.
//

import UIKit
import RealmSwift
import Jelly

class AddOrEditTableViewController: UITableViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var vissible_password: UISwitch!
    @IBOutlet weak var key_name: UITextField!
    @IBOutlet weak var url: UITextField!
    @IBOutlet weak var login: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var photoImage: UIImageView!
    
    private var keys: Keys!
    var icon = ""
    let key_encrypt = "bbC2H19lkVbQDfakxcrtNMQdd0FloLyw" // length == 32
    let iv = "gqLOHUioQ0QjhuvI"
    
//    static let delegate = AddOrEditTableViewController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(AddOrEditTableViewController.swiped(_:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let backgroundImage = UIImage(named: "tableBackground")
        let imageView = UIImageView(image: backgroundImage)
        self.tableView.backgroundView = imageView
        
        let keys = try! Realm().objects(Keys.self)
        for key in keys{
            if(key.activity == true){
                key_name.text = key.key_name
                url.text = key.site
                login.text = key.login
                password.text = try! key.password.decrypt(key_encrypt, iv)
                icon = key.image
                photoImage.image = UIImage(named: icon)
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let degree: Double = 90
        let rotationAngle = CGFloat(degree * M_PI / 180)
        let rotationTransform = CATransform3DMakeRotation(rotationAngle, 0, 1, 0)
        cell.layer.transform = rotationTransform
        cell.backgroundColor = .clear
        
        UIView.animate(withDuration: 1, delay: 0.05 * Double(indexPath.row), options: .curveEaseInOut, animations: {
            cell.layer.transform = CATransform3DIdentity
        })
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        key_name.resignFirstResponder()
        url.resignFirstResponder()
        login.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    @IBAction func Cancel(_ sender: UIBarButtonItem) {
        deactivate()
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "TableLeyController")
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        view.window!.layer.add(transition, forKey: kCATransition)
        
        self.present(resultViewController, animated:false, completion:nil)
    }
    
    @IBAction func saveKey(_ sender: UIBarButtonItem) {
        if validateFields() {
            if (addNewKey()){
                let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
                
                let resultViewController = storyBoard.instantiateViewController(withIdentifier: "TableLeyController")
                let transition = CATransition()
                transition.duration = 1
                transition.type = kCATransitionPush
                transition.subtype = kCATransitionMoveIn
                view.window!.layer.add(transition, forKey: kCATransition)
                
                self.present(resultViewController, animated:false, completion:nil)
            }
        }
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

    @IBAction func on_of_security_password(_ sender: Any) {
        if(vissible_password.isOn){
            password.isSecureTextEntry = false
        }else{
            password.isSecureTextEntry = true
        }
    }
    
    private func addNewKey() -> Bool {
        let realm = try! Realm()
        if(activity_key()){
            deactivate()
        }else{
            try! realm.write {
                let newKey = Keys()
                
                newKey.key_name = self.key_name.text!
                newKey.login = self.login.text!
                newKey.site = self.url.text!
                if icon == ""{
                    newKey.image = "Image"
                }else{
                    newKey.image = icon
                }
                newKey.password = try! self.password.text!.encrypt(key_encrypt,iv)!
                
                let user = realm.objects(Users.self).filter("state == true").first
                newKey.user = user
                realm.add(newKey)
                self.keys = newKey
            }
        }
        return true
    }

    private func validateFields() -> Bool {
        
        if key_name.text!.isEmpty || login.text!.isEmpty ||
            password.text!.isEmpty || url.text!.isEmpty {
            
            let alertController = UIAlertController(title: "Validation Error", message: "All fields must be filled", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.destructive) { alert in
                alertController.dismiss(animated: true, completion: nil)
            }
            
            let customPresentation = JellySlideInPresentation(dismissCurve: .linear,
                                                              presentationCurve: .linear,
                                                              cornerRadius: 15,
                                                              backgroundStyle: .blur(effectStyle: .light),
                                                              jellyness: .jellier,
                                                              duration: .slow,
                                                              directionShow: .top,
                                                              directionDismiss: .bottom,
                                                              widthForViewController: .fullscreen,
                                                              heightForViewController: .fullscreen,
                                                              horizontalAlignment: .center,
                                                              verticalAlignment: .center,
                                                              marginGuards: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10),
                                                              corners: [.topLeft,.bottomRight])
            let jellyAnimator = JellyAnimator(presentation: customPresentation)
            jellyAnimator.prepare(viewController: alertController)
            
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
            
            return false
            
        } else {
            return true
        }
    }
    
    private func activity_key() -> Bool{
        let keys = try! Realm().objects(Keys.self)
        for key in keys{
            if(key.activity == true){
                let realm = try! Realm()
                try! realm.write {
                    key.key_name = self.key_name.text!
                    key.login = self.login.text!
                    key.site = self.url.text!
                    key.password = try! self.password.text!.encrypt(key_encrypt, iv)!
                    key.image = icon
                }
                return true
            }
        }
        return false
    }
    
    private func deactivate(){
        let realm = try! Realm()
        let key = realm.objects(Keys.self).filter("activity == true").first
        
        try! realm.write {
            key?.activity = false
        }

    }
    
    func SetImage(_ icons: String){
        icon = icons
        photoImage.image = UIImage(named: icon)
    }
}














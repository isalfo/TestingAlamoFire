//
//  ViewController.swift
//  AlamofireTest
//
//  Created by Gonzalo Alfonso on 29/09/2021.
//
//  TODO: Avoid code duplication

import UIKit
import Kingfisher

class ViewController: UIViewController {
  
  @IBOutlet weak var nameLbl: UILabel!
  @IBOutlet weak var emailLbl: UILabel!
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
  @IBOutlet weak var idLbl: UILabel!
  @IBOutlet weak var imgView: UIImageView!
  @IBOutlet weak var downloadImgBtn: UIButton!
  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }
  
  func setup() {
    nameLbl.text = ""
    nameLbl.numberOfLines = 0
    emailLbl.text = ""
    emailLbl.numberOfLines = 0
    idLbl.text = ""
    activityIndicator.hidesWhenStopped = true
    activityIndicator.stopAnimating()
  }
  
  @IBAction func downloadImgClicked(_ sender: Any) {
    activityIndicator.startAnimating()
    downloadImgBtn.isHidden = true
    imgView.kf.setImage(with: URL(string: "https://www.apple.com/v/swift/c/images/overview/icon_swift_hero_large.png"))
    activityIndicator.stopAnimating()
  }
  
  @IBAction func deleteUserClicked(_ sender: Any) {
    
    self.activityIndicator.startAnimating()
    let id = 11040
    
    NetworkingProvider().deleteUser(id: id) {
      self.nameLbl.text = ""
      self.emailLbl.text = ""
      self.idLbl.text = "User with ID \(id) deleted"
      self.activityIndicator.stopAnimating()
    }
    failure: { error in
      
      self.showSimpleAlert("Error", message: error?.localizedDescription ?? "")
    }
  }
  
  @IBAction func addUserClicked(_ sender: Any) {
    let newUser = User(name: "Me", email: "Me@Me.com", gender: "Female", status: "Active")
    self.activityIndicator.startAnimating()
    
    NetworkingProvider().addUser(user: newUser) { user in
      
      self.nameLbl.text = user.name
      self.emailLbl.text = user.email
      self.idLbl.text = user.id?.description
      self.activityIndicator.stopAnimating()
      
    } failure: { error in
      
      self.activityIndicator.stopAnimating()
      self.showSimpleAlert("Error", message: error?.localizedDescription ?? "")
    }
  }
  
  @IBAction func getUsersClicked(_ sender: Any) {
    self.activityIndicator.startAnimating()
    
    NetworkingProvider().getUser(id: 11040) { user in
      
      self.nameLbl.text = user.name
      self.emailLbl.text = user.email
      self.idLbl.text = user.id?.description
      self.activityIndicator.stopAnimating()
      
    } failure: { error in
      
      self.activityIndicator.stopAnimating()
      self.showSimpleAlert("Error", message: error?.localizedDescription ?? "")
    }
  }
  @IBAction func updateUserClicked(_ sender: Any) {
    
    self.activityIndicator.startAnimating()
    
    let newUser = User(name: "Ro", email: "asde@ren.com", gender: "Male", status: "Active")
    
    NetworkingProvider().updateUser(id: 11040, user: newUser) { user in
      
      self.nameLbl.text = user.name
      self.emailLbl.text = user.email
      self.idLbl.text = user.id?.description
      self.activityIndicator.stopAnimating()
      
    } failure: { error in
      self.activityIndicator.stopAnimating()
      self.showSimpleAlert("Error", message: error?.localizedDescription ?? "")
    }
  }
}

extension ViewController {
  func showSimpleAlert(_ title: String = "Error", message: String) {
    
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
    alert.addAction(action)
    self.present(alert, animated: true, completion: nil)
  }
}

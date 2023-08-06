
import UIKit
import SwiftUI

class SearchVC: UIViewController {
    
    let logoImageView:UIImageView =
    {
        let Image = UIImageView()
        Image.image = UIImage(named: "gh-logo")!
        return Image
    }()
    let userNameTextField = GH_TextField()
    let callToActionButton = GH_Button(backgroungColor: .systemGreen, title: "Get Followers")
    
   // MARK: -  LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground  // for both dark nd lightmode
        userNameTextField.delegate = self
        style()
        layout()
        KeyboardDismiss()
        
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - ACTION
    
    func KeyboardDismiss()
    {
        let tab = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tab)
    }
    
    
    @objc func pushFollowerListVC()
    {
        guard let userName = userNameTextField.text  , !userName.isEmpty else {
            presenGHAlertOnMainThread(title: "Empty UserName", message: "please Enter username we need to know who to look for", buttonTitle: "OK")
            
            return}
        let followerListVC      = FollowersListVC()
        followerListVC.name     = userName
        followerListVC.title    = userName
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    


}

extension SearchVC
{
    func style()
    {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoImageView)
        view.addSubview(userNameTextField)
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
    }
    func layout()
    {
        NSLayoutConstraint.activate([
            
            // MARK: - LOGO CONSTRAINT
            
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor , constant: 50),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            
            
            // MARK: - TEXTFIELD CONSTRAINT
            
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor , constant: 50),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 50),
            view.trailingAnchor.constraint(equalTo:userNameTextField.trailingAnchor, constant: 50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            
            // MARK: - BUTTONCONSTRAINT
            
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor , constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 50),
            view.trailingAnchor.constraint(equalTo:callToActionButton.trailingAnchor, constant: 50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50),
           
        ])
    }
}


// MARK: - DELEGATE

extension SearchVC:UITextFieldDelegate
{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("PRESSED")
        pushFollowerListVC()
        return true
    }
}







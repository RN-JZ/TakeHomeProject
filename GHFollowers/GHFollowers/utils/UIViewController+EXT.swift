


import UIKit

private var container:UIView =
{
    var view = UIView()
    view.backgroundColor = .systemBackground
    view.alpha = 0
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
}()

extension UIViewController
{
    
   
    
    func presenGHAlertOnMainThread(title:String , message:String , buttonTitle:String)
    {
        DispatchQueue.main.async
        {
            let alertVC =   GH_AlertVC(title: title , message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle =   .overFullScreen
            alertVC.modalTransitionStyle   =   .crossDissolve
            self.present(alertVC, animated: true, completion: nil)
            
            
            
        }
        
    }
    
    func showLoadindView()
    {
        
        view.addSubview(container)
        
        UIView.animate(withDuration: 0.25) {
            container.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        container.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            container.topAnchor.constraint(equalTo: view.topAnchor),
            container.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        activityIndicator.startAnimating()

        
    }
    
    func dismissLoadingView()
    {
        DispatchQueue.main.async{
            container.removeFromSuperview()
            
        }
        
    }
    
    func showEmptyStateView(with message:String , In view:UIView)
    {
        let emptyStateView = GHEmptyStateView(message: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}

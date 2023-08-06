
import UIKit

class FavoritiesVC: UIViewController{
    
    let tableView = UITableView()
    var followers : [Follower] = []

    override func viewDidLoad()
    {
        super.viewDidLoad()
        configureViewController()
       
        configureTaleView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("VIEW WILL APPEAR")
        getFavourite()
    }
    func configureTaleView()
    {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 80
        tableView.register(FavouriteCell.self, forCellReuseIdentifier: FavouriteCell.reuseId)
    }
    func configureViewController()
    {
        view.backgroundColor = .systemBackground
        title = "Favourite"
        navigationController?.navigationBar.prefersLargeTitles = true
       
    }
    
    func getFavourite()
    {
        PersistanceManager.reteriveFavourite { result in
            switch result
            {
            case .success(let favourite):
               
                if favourite.isEmpty
                {
                    DispatchQueue.main.async
                    {
                        [weak self] in
                        guard let self = self else {return}
                        self.showEmptyStateView(with: "This user has no favourite", In: self.view)
                    }
                     
                    
                    
                }
                else{
                    self.followers = favourite
                    print(self.followers.count)
                    DispatchQueue.main.async
                    {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
                
                break
            case .failure(let error):
                self.presenGHAlertOnMainThread(title: "NO FAVOURITE", message: "\(error)", buttonTitle: "ok")
                break
            }
        }
    }


}

extension FavoritiesVC: UITableViewDelegate , UITableViewDataSource
{
   
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followers.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavouriteCell.reuseId) as! FavouriteCell
        cell.follower = followers[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let action = UIContextualAction(style: .destructive, title: "delete")
        {
            (action , view  , completionHandle) in
            
            print("CLICK DELETE")
            // TODO :- WHICH Items TO REMOVE
            let fav = self.followers[indexPath.row]
            self.followers.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .left)
            
            PersistanceManager.updateWithFavourite(favourite: fav, action:.remove) { [weak self] error in
                guard let self = self else {return}
                guard let error = error else {return}
                self.presenGHAlertOnMainThread(title: "Unable to remove", message: error.rawValue, buttonTitle: "ok")
            }
           
           
        }
        
        
        return UISwipeActionsConfiguration(actions: [action])
    }
}



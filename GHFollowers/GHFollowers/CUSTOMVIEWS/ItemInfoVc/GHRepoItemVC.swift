


import UIKit

class GHRepoItemVC: GH_ItemInfoVC
{
    override func viewDidLoad() {
            super.viewDidLoad()
            configureItems()
        }
        
        
        private func configureItems() {
            itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
            itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
            actionButton.set(backgroungColor: .systemPurple, title: "GitHub Profile")
        }
    override func actionButtonTapped() {
        print("CLICKED")
        delegate.didTabGitHubProfile(for: user)
    }
}

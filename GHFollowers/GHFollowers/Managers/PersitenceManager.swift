


import Foundation
enum PersitenceactionType
{
    case add , remove
}
struct PersistanceManager
{
    static private let defaults = UserDefaults.standard
    static private let key = "favorites"
    static func updateWithFavourite(favourite:Follower , action:PersitenceactionType , completion:@escaping(GHError?)->Void)
    {
        reteriveFavourite { result in
           switch result
            {
           case .success(let favourites):
           
               var reterieveFavourite = favourites
               switch action
               {
                 case .add:
               
                   guard !reterieveFavourite.contains(favourite) else{
                       completion(.alreadyPresent)
                       return
                   }
                   reterieveFavourite.append(favourite)
                  
                   break
               
    
               case .remove:
               
                   reterieveFavourite.removeAll{
                       $0.login == favourite.login
                   }
                   break
              
               }
               completion(Save(favourite: reterieveFavourite))
           
           case .failure(let error):
               completion(error)
          
           }
        }
    }
    
    static func reteriveFavourite(completion: @escaping(Result<[Follower],GHError>)->Void)
    {
        guard let favouriteData = defaults.object(forKey: key) as? Data  else{
            completion(.success([]))
            return
        }
        do{
            let favourite = try JSONDecoder().decode([Follower].self, from: favouriteData)
            completion(.success(favourite))
            
        }catch
        {
            completion(.failure(.invalidData))
        }
    }
    
    
    static func Save(favourite:[Follower])->GHError?
    {
        do{
            let encode = JSONEncoder()
            let encodeFavourite = try encode.encode(favourite)
            defaults.set(encodeFavourite, forKey: key)
            return nil
        }catch{
            return .invalidData
        }
        
    }
    
}


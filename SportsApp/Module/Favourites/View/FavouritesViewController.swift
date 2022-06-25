//
//  FavouritesViewController.swift
//  SportsApp
//
//  Created by n0shy on 21/06/2022.
//

import UIKit
import CoreData
import Kingfisher
import Network

protocol FavouritesProtocol {
    
}

struct FavouritesResultView {
    
}

class FavouritesViewController: UITableViewController, FavouritesProtocol {

    var myPresenter = Routerfavourites.presenter
    var favourites : [NSManagedObject]! = []
    var coredataManager : CoredataManagerVSFavourites = CoredataManager()
    var netWorkFlag : Bool?


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let monitor = NWPathMonitor()
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                self.netWorkFlag = true
                print("We're connected!")
            } else {
                self.netWorkFlag = false
                print("No connection.")
            }

        }

        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)

        
        title = "Favourites"

        setupTableView()
        getData()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        favourites = coredataManager.fetchFavouriteLeagues(fetchedData: &favourites)
        tableView.reloadData()
    }
    
    func setupTableView()
    {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    func getData(){
        //attachview func
        myPresenter.attachView(view: self)
        //getdata func
        myPresenter.fetchFavouritesData()
    }

}

extension FavouritesViewController{
        // MARK: - Table view data source

        override func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }

        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return favourites?.count ?? 0
        }

        
        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueFavouritesCellID", for: indexPath) as! LeagueCell
            cell.leagueNameText.text = favourites[indexPath.row].value(forKey: "leagueName") as? String
            let url = URL(string: (favourites[indexPath.row].value(forKey: "leagueImgURL") as? String)!)
            
            let resizingProcessor = ResizingImageProcessor(referenceSize: (cell.leagueImg.frame.size), mode: .aspectFit)
            cell.leagueImg.kf.setImage(with: url, options: [.processor(resizingProcessor)])
            cell.viewCell.layer.cornerRadius = cell.viewCell.frame.height / 2
            cell.leagueImg.layer.cornerRadius = 110 / 2
            cell.vcDelegation = self
            
            return cell
        }
        
        override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if(editingStyle == .delete)
            {
                coredataManager.deleteFavouriteLeague(deletedData: favourites[indexPath.row])
                favourites.remove(at: indexPath.row)
                tableView.reloadData()
            }
        }
        
        override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            myPresenter.checkInternetConnection()
            if netWorkFlag!{
                
                let tempLeagueData = LeaguesResultView(id: (favourites[indexPath.row].value(forKey: "leagueId") as? String) ?? "", name: (favourites[indexPath.row].value(forKey: "leagueName") as? String) ?? "", imageURL: (favourites[indexPath.row].value(forKey: "leagueImgURL") as? String) ?? "", ytURL: (favourites[indexPath.row].value(forKey: "leagueYtuURL") as? String) ?? "")
                
                    let detailsVC = self.storyboard?.instantiateViewController(identifier: "LeaguesDetailsVCID") as! LeaguseDetailsViewController
                    myPresenter.setLeagueData(leagueData : tempLeagueData)
                    detailsVC.modalPresentationStyle = .fullScreen
                    self.present(detailsVC, animated: true, completion: nil)
                
            }
            else{
                let alert1 = UIAlertController(title: "Unable to connect", message: "Please check your Internet connection ", preferredStyle: .actionSheet)

                alert1.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {action in
                    print("Cancel is pressed")
                    
                }))
                self.present(alert1, animated: true, completion: nil)
            }
            

            }
    
        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 130
        }

}

extension FavouritesViewController : customCellProtocol
{
    func cell(cell: LeagueCell, didTapBtn: UIButton) {
        let rowIndex = self.tableView.indexPath(for: cell)?.row
        let url = favourites[rowIndex!].value(forKey: "leagueYtuURL") as! String
        let youtubeURL = URL(string:  "https://"+url)
        UIApplication.shared.open(youtubeURL!)
    }
}

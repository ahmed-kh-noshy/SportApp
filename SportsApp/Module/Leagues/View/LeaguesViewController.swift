//
//  LeaguesViewController.swift
//  SportsApp
//
//  Created by n0shy on 20/06/2022.
//

import UIKit
import Kingfisher

protocol LeaguesProtocol {
    func stopAnimator()
    func reloadTableData()
}

protocol customCellProtocol {
    func cell(cell: LeagueCell, didTapBtn: UIButton)
}

struct LeaguesResultView
{
    var id: String
    var name: String
    var imageURL : String
    var ytURL : String
}

class LeaguesViewController: UITableViewController {

    let indicator = UIActivityIndicatorView(style: .large)
    var myPresenter = RouterClass.presenter
    var resultView :[LeaguesResultView]!
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Leagues"
        setupTableView()
        animator()
        getData()
    }
    
    func animator()
    {
        indicator.center = self.view.center
        self.view.addSubview(indicator)
        indicator.startAnimating()
            
    }
    
    func getData()
    {
        myPresenter.attachView(view: self)
        myPresenter.getLeagues()
        print("In Leagues VC\(myPresenter.sportName ?? "")")
    }
    
    func setupTableView()
    {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }

}

extension LeaguesViewController: LeaguesProtocol
{
    func stopAnimator() {
        indicator.stopAnimating()
    }
    
    func reloadTableData() {
        
        resultView = myPresenter.leaguesResult?.map({ (item) -> LeaguesResultView in
            return LeaguesResultView(id: item.idLeague ?? " ", name: item.strLeague ?? " ", imageURL: item.strBadge ?? " ", ytURL: item.strYoutube ?? " ")
        })
 
        self.tableView.reloadData()
    }
}

extension LeaguesViewController
{
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultView?.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeagueCellid", for: indexPath) as! LeagueCell

        // Configure the cell...
      
        cell.leagueNameText.text = resultView[indexPath.row].name
        let url = URL(string: resultView[indexPath.row].imageURL)
        
        let resizingProcessor = ResizingImageProcessor(referenceSize: (cell.leagueImg.frame.size), mode: .aspectFit)
        cell.leagueImg.kf.setImage(with: url, options: [.processor(resizingProcessor)])
        cell.viewCell.layer.cornerRadius = cell.viewCell.frame.height / 2
        cell.leagueImg.layer.cornerRadius = 110 / 2
        cell.vcDelegation = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let detailsVC = self.storyboard?.instantiateViewController(identifier: "LeaguesDetailsVCID") as! LeaguseDetailsViewController
        myPresenter.setLeagueData(leagueData : resultView[indexPath.row])
        detailsVC.modalPresentationStyle = .fullScreen
        self.present(detailsVC, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }

}

extension LeaguesViewController : customCellProtocol{
    func cell(cell: LeagueCell, didTapBtn: UIButton) {
        let rowIndex = (self.tableView.indexPath(for: cell)?.row)!
        print("the row index is \(rowIndex)")
        let youtubeUrl = URL(string: "https://"+resultView[rowIndex].ytURL)!
        UIApplication.shared.open(youtubeUrl)
    }
    
}

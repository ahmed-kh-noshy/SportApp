//
//  HomeViewController.swift
//  SportsApp
//
//  Created by n0shy on 20/06/2022.
//

import UIKit
import Kingfisher

protocol HomeProtocol
{
    func stopAnimator()
    func reloadCollectionData()
}

struct ResultView
{
    var name: String?
    var imageURL : String?
}

class HomeViewController: UIViewController {

    @IBOutlet weak var myHomeCollection: UICollectionView!
    let indicator = UIActivityIndicatorView(style: .large)
    var myPresenter = HomePresenter()
    var resultView :[ResultView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupCollectionView()
        animator()
        getData()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let selectedItemNum = myHomeCollection.indexPathsForSelectedItems![0][1]
        print(resultView[selectedItemNum].name!)
        myPresenter.setSportName(sportName: resultView[selectedItemNum].name ?? "")
        let _ = segue.destination as! LeaguesViewController
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func setupCollectionView()
    {
        myHomeCollection.delegate = self
        myHomeCollection.dataSource = self
        //myHomeCollection.flo
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
        myPresenter.getSports()
    }

}



extension HomeViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //number of sports
        return resultView?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellid", for: indexPath) as! HomeCollectionCell
        
        cell.cellText.text = resultView[indexPath.row].name
        
        cell.cellImage.setRounded()
        let url = URL(string: resultView[indexPath.row].imageURL ?? "")
        let resizingProcessor = ResizingImageProcessor(referenceSize: (cell.cellImage.frame.size), mode: .aspectFit)
        cell.cellImage.kf.setImage(with: url, options: [.processor(resizingProcessor)])
        
        cell.layer.cornerRadius = 15
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.gray.cgColor
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (self.myHomeCollection.frame.size.width - 24) / 2 , height: self.myHomeCollection.frame.size.width / 2)
        
        
    }
    
    /*
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    */

    
}

extension HomeViewController : HomeProtocol{
    func stopAnimator(){
        
        indicator.stopAnimating()
    }
    
    func reloadCollectionData(){
        
        resultView = myPresenter.sportsResult.map({
            (item) -> ResultView in
            //print(item.strSport!)
            return ResultView(name: item.strSport!, imageURL: item.strSportThumb!)
        })
        myHomeCollection.reloadData()
    }
}

extension UIImageView {

   func setRounded() {
       layer.borderWidth = 5
       layer.masksToBounds = false
       layer.borderColor = UIColor.white.cgColor
       layer.cornerRadius = self.frame.height / 2
       clipsToBounds = true
   }
}

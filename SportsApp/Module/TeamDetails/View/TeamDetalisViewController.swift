//
//  TeamDetalisViewController.swift
//  SportsApp
//
//  Created by n0shy on 23/06/2022.
//

import UIKit
import Kingfisher
class TeamDetalisViewController: UIViewController {

        var team: Team!
        let myPresenter = RouterTeamDetails.presenter
        
        @IBOutlet weak var teamBadge: UIImageView!
        @IBOutlet weak var teamName: UILabel!
        @IBOutlet weak var teamSport: UILabel!
        @IBOutlet weak var teamLeague: UILabel!
        @IBOutlet weak var teamCountry: UILabel!
        @IBOutlet weak var teamGender: UILabel!
        @IBOutlet weak var teamInformedYear: UILabel!
        @IBOutlet weak var teamStedium: UILabel!
        @IBOutlet weak var teamDescription: UILabel!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            getTeam()
            setScreenData()
            
            
            
        }
        

        @IBAction func backButtonAction(_ sender: UIBarButtonItem) {
            self.dismiss(animated: true, completion: nil)
        }
        func getTeam() {
            team = myPresenter.selectedTeam
            print(team.strTeam ?? "")
        }
        func setScreenData() {
            teamName.text = team.strTeam
            let imageURL = URL(string: team.strTeamBadge ?? "")
            
            teamBadge.layer.cornerRadius = teamBadge.frame.height / 2
            let resizingProcessor = ResizingImageProcessor(referenceSize: (teamBadge.frame.size), mode: .aspectFit)
            
            teamBadge.kf.setImage(with: imageURL, options: [.processor(resizingProcessor)])
            teamSport.text = team.strSport
            teamGender.text = team.strGender
            teamLeague.text = team.strLeague
            teamCountry.text = team.strCountry
            teamStedium.text = team.strStadium
            teamInformedYear.text = team.intFormedYear
            teamDescription.text = team.strDescriptionEN
            
        }
        
    }

//
//  LeagueCell.swift
//  SportsApp
//
//  Created by n0shy on 20/06/2022.
//

import UIKit

class LeagueCell: UITableViewCell {
    
    
    
    
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var leagueImg: UIImageView!
    @IBOutlet weak var leagueNameText: UILabel!
    
    
    @IBAction func youtubeBtn(_ sender: UIButton) {
        print("You clicked the btn")
        //print(youtubeBtn.title(for: .normal))
        //vcDelegation = LeaguesVC()
        print("I will print self")
        print(self)
        print("I will print sender")
        print(sender)
        vcDelegation.cell(cell: self, didTapBtn: sender)
    }
   
    
    var vcDelegation : customCellProtocol!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

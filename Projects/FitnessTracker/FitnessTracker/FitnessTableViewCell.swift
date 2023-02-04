//
//  FitnessTableViewCell.swift
//  FitnessTracker
//
//  Created by Jane Schmidt on 4/7/22.
//
/*
 Ashley Ziegler amziegle@iu.edu
 Jane Schmidt schmija@iu.edu
 Taylor Yang tayyang@iu.edu
 Fitness Tracker
 5/5/2022
 */

import UIKit

class FitnessTableViewCell: UITableViewCell {
    
    @IBOutlet var type: UILabel!
    @IBOutlet var date: UILabel!
    @IBOutlet var mile: UILabel!
    @IBOutlet var duration: UILabel!
    @IBOutlet var notes: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


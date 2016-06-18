//
//  Movie Cell.swift
//  MovieViewer
//
//  Created by Mazen Raafat Ibrahim on 6/15/16.
//  Copyright © 2016 Mazen Raafat Ibrahim. All rights reserved.
//

import UIKit

class Movie_Cell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var posterView: UIImageView!
    
    @IBOutlet weak var ratings: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        posterView.layer.borderWidth=1.0
        posterView.layer.masksToBounds = false
        posterView.layer.borderColor = UIColor.whiteColor().CGColor
        posterView.layer.cornerRadius = 13
        posterView.layer.cornerRadius = posterView.frame.size.height/2
        posterView.clipsToBounds = true
        

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

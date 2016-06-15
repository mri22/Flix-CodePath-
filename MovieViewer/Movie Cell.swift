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
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

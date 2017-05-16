//
//  TableViewCell.swift
//  TheMovieDB
//
//  Created by Nehemiah Horace on 5/15/17.
//  Copyright © 2017 Nehemiah Horace. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var movies: Movies!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_ movie: Movies) {
        self.movies = movie
    }

}

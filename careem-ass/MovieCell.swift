//
//  MovieCell.swift
//  careem-ass
//
//  Created by Huy Nguyễn on 5/9/18.
//  Copyright © 2017 Huy Nguyen. All rights reserved.
//

import UIKit
import SDWebImage

class MovieCell: UITableViewCell {

    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var lblOverView: UILabel!
    
    let releaseDateFormatter = DateFormatter.newFormatterWithFormat("MMMM dd, yyyy")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCell(movie: MovieObj) {
        
        lblTitle.text = movie.movieName
        lblReleaseDate.text = movie.releaseDate?.reformat(with: releaseDateFormatter)
        lblOverView.text = movie.overview
        
        guard let strPoster = movie.posterURL else {
            imgPoster.image = #imageLiteral(resourceName: "no_image")
            return
        }
        
        imgPoster.sd_setImage(with: URL(string: strPoster.getPosterUrl(with: .w780)), placeholderImage: #imageLiteral(resourceName: "placeholder"), options: .cacheMemoryOnly, completed: nil)
    }
}

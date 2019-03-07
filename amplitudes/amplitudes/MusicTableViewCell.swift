//
//  MusicTableViewCell.swift
//  amplitudes
//
//  Created by Lawrence Bang on 20/11/18.
//  Copyright © 2018 Lawrence Bang. All rights reserved.
//

import UIKit
import CoreData

class MusicTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var genreLabel: UILabel!
    
//    func updateCell (music: Music) {
//        titleLabel.text = music.strAlbum
//        artistLabel.text = music.strArtist
//        genreLabel.text = music.strGenre
//        
//        //imgView.image = music.albumThumb as? UIImage
//
//    }

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

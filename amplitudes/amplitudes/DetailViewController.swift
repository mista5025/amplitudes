//
//  DetailViewController.swift
//  amplitudes
//
//  Created by Lawrence Bang on 19/11/18.
//  Copyright © 2018 Lawrence Bang. All rights reserved.
//

import UIKit
import CoreData

class DetailViewController: UIViewController {

    
    @IBOutlet weak var albumPicture: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var moodLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
    
    var musicInfo: Music!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }

    override func viewDidAppear(_ animated: Bool) {
        titleLabel.text = musicInfo.strAlbum
        artistLabel.text = musicInfo.strArtist
        genreLabel.text = musicInfo.strGenre
        moodLabel.text = musicInfo.strMood
        reviewLabel.text = musicInfo.strReview
        albumPicture.image = UIImage(data: musicInfo!.albumThumb! as Data)
       // albumPicture.image = (UIImage)(musicInfo.albumThumb)
        
        //sending the file via message
        let activity = UIActivityViewController(activityItems: [musicInfo], applicationActivities: nil)
        present(activity, animated: true, completion: nil)
        
    }
    
}

//
//  SearchViewController.swift
//  amplitudes
//
//  Created by Lawrence Bang on 19/11/18.
//  Copyright © 2018 Lawrence Bang. All rights reserved.
//

import UIKit
import CoreData

class SearchViewController: UIViewController, UISearchBarDelegate {

    var albumThumb: NSData!
    var strArtist: String!
    var idAlbum: Int32!
    var strAlbum: String!
    var strGenre: String!
    var strMood: String!
    var strReview: String!
    
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var keywordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // save
    @IBAction func saveButton(_ sender: UIButton) {
        
        let persistentContainer = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer
        let context = persistentContainer?.viewContext
        let music = Music(context: context!)
        music.strArtist = strArtist
        music.strAlbum = strAlbum
        music.strGenre = strGenre
        music.strMood = strMood
        music.strReview = strReview
        music.albumThumb = albumThumb
        
        try! context?.save()
//        print("\(music)")
        print("saved")
        
    }
    
    
    // search
    
    @IBAction func searchData(_ sender: UIButton) {
        
        let text = keywordTextField.text!
        let searchurl = URL(string: "https://theaudiodb.com/api/v1/json/195003/searchalbum.php?s=\(text)")

        let urlRequest = URLRequest(url: searchurl!)
        let task = URLSession.shared.dataTask(with: urlRequest) {
            (data, response, error)
            in
            if(error == nil) {
                do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any]
                    // array to string use [[String: Any]]
                    let d = json["album"] as! [[String: Any]]
                    
                    let random = (Int)(arc4random_uniform((UInt32)(d.count)))
                    //let random = Int.random(in: 0..<d.count)
                    let image_url = d[random]["strAlbumThumb"] as! String
                    
                    // showing image to ImageView
                    let url = URL(string: image_url)
                    
                    DispatchQueue.main.async {
                        let image_data = try! Data(contentsOf: url!)
                        // save data
                        self.strAlbum = d[random]["strAlbum"] as! String
                        self.strArtist = d[random]["strArtist"] as! String
                        self.strGenre = d[random]["strGenre"] as! String
                        self.albumThumb = image_data as! NSData
                        self.strMood = d[random]["strMood"] as! String
                        self.strReview = d[random]["strDescriptionEN"] as! String
                        self.pictureView.image = UIImage(data: image_data)
                        self.titleLabel.text = self.strAlbum
                        self.artistLabel.text = self.strArtist
                        self.genreLabel.text = self.strGenre
                        print("done")
                    }
                }
                catch {
                    print("Json format error")
                }
            }else {
                print("Error")
            }
            
        }
        task.resume()
    }
    
}

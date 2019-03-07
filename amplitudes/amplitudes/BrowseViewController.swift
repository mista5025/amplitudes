//
//  BrowseViewController.swift
//  amplitudes
//
//  Created by Lawrence Bang on 19/11/18.
//  Copyright © 2018 Lawrence Bang. All rights reserved.
//

import UIKit
import CoreData

class BrowseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    var musics = [Music]()
    
    var selectedMusics : Music!
    
    // search (update table)
    var currentMusicArray = [Music]()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // persistentContainer
        let pc = (UIApplication.shared.delegate as! AppDelegate).persistentContainer
        let context = pc.viewContext
        // fetch request
        let fetchRequest : NSFetchRequest<Music> = Music.fetchRequest()
        //currentMusicArray = try! context.fetch(fetchRequest)
        musics = try! context.fetch(fetchRequest)
//
        // search
        setUpSearchBar()
        
        // layout
        alterLayout()
        
        currentMusicArray = musics
    }
    
    // search
    private func setUpSearchBar() {
        searchBar.delegate = self
    }
    
    // layout
    func alterLayout() {
        table.tableHeaderView = UIView()
        // search bar in section header
        table.estimatedSectionHeaderHeight = 50
        navigationItem.titleView = searchBar
        searchBar.placeholder = "search artist"
    }
    
    
    // search bar
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            currentMusicArray = musics;
            table.reloadData()
            return
        }
        currentMusicArray = musics.filter({ (music) -> Bool in
            music.strAlbum!.lowercased().contains(searchText.lowercased())
        })
        currentMusicArray = musics.filter({ (music) -> Bool in
            music.strArtist!.lowercased().contains(searchText.lowercased())
        })
        table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return currentMusicArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MusicTableViewCell
        cell.artistLabel.text = currentMusicArray[indexPath.row].strArtist
        cell.titleLabel.text = currentMusicArray[indexPath.row].strAlbum
        cell.genreLabel.text = currentMusicArray[indexPath.row].strGenre
        // get image from CoreData
        let d = currentMusicArray[indexPath.row].albumThumb! as Data
        cell.imgView.image = UIImage(data: d)
        return cell
    }
    
    // pass data to detail Controller
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedMusics = currentMusicArray[indexPath.row]
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationController = segue.destination as! DetailViewController
        destinationController.musicInfo = selectedMusics
    }
}

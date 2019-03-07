//
//  Music+CoreDataProperties.swift
//  amplitudes
//
//  Created by Lawrence Bang on 24/11/18.
//  Copyright © 2018 Lawrence Bang. All rights reserved.
//
//

import Foundation
import CoreData


extension Music {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Music> {
        return NSFetchRequest<Music>(entityName: "Music")
    }

    @NSManaged public var albumThumb: NSData?
    @NSManaged public var idAlbum: Int32
    @NSManaged public var strAlbum: String?
    @NSManaged public var strArtist: String?
    @NSManaged public var strGenre: String?
    @NSManaged public var strMood: String?
    @NSManaged public var strReview: String?

}

//
//  Movie.swift
//  MovieAssistant
//
//  Created by Adam Parr on 08/11/2016.
//  Copyright © 2016 Adam Parr. All rights reserved.
//

import UIKit

class Movie: NSObject, NSCoding {
    
    var title: String
    var desc: String
    var rating: Int
    
    init(title: String, desc: String, rating: Int) {
        self.title = title
        self.desc = desc
        self.rating = rating
    }
    
    required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "title") as! String
        desc = aDecoder.decodeObject(forKey: "desc") as! String
        rating = aDecoder.decodeInteger(forKey: "rating")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "title")
        aCoder.encode(desc, forKey: "desc")
        aCoder.encode(rating, forKey: "rating")
    }

}

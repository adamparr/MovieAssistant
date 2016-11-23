//
//  AddMovieViewController.swift
//  MovieAssistant
//
//  Created by Adam Parr on 08/11/2016.
//  Copyright © 2016 Adam Parr. All rights reserved.
//

import UIKit

class AddMovieViewController: UIViewController {

    // MARK: Properties -----------------------------------------------------------------------------------------------------
    
    @IBOutlet weak var movieTitle: UITextField!
    @IBOutlet weak var movieDesc: UITextField!
    @IBOutlet weak var movieRating: RatingControl!
    @IBOutlet weak var addMovieButton: UIButton!
    @IBOutlet weak var delete: UIButton!
    
    var movie: Movie?
    var deleteSelection = false

    
    // MARK: Actions --------------------------------------------------------------------------------------------------------
    
    @IBAction func addMovie(_ sender: Any) {
        let title = movieTitle.text!
        let desc = movieDesc.text!
        let rating = movieRating.rating
        
        // Put movie info in 'movie' so ViewController can grab it
        movie = Movie(title: title, desc: desc, rating: rating)
        
        performSegue(withIdentifier: "addMovieUnwind", sender: self)
        
    }
    
    @IBAction func deleteMovie(_ sender: Any) {
        
        deleteSelection = true
        performSegue(withIdentifier: "addMovieUnwind", sender: self)
    }
    
    // MARK: Overrides ------------------------------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        
        // if movie != nil then customise layout
        if let movie = movie {
            movieTitle.text = movie.title
            movieDesc.text = movie.desc
            movieRating.rating = movie.rating
            
            addMovieButton.setTitle("Update", for: .normal)
            navigationItem.title = "Edit Movie"
            delete.isHidden = false
        }
    }
    
    

}

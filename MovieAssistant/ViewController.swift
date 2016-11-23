//
//  ViewController.swift
//  MovieAssistant
//
//  Created by Adam Parr on 08/11/2016.
//  Copyright © 2016 Adam Parr. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    // MARK: Properties -----------------------------------------------------------------------------------------------------
    
    @IBOutlet weak var tableView: UITableView!
    
    var movies = [Movie]() {
        didSet {
            save()
            tableView.reloadData()
        }
    }

    
    // MARK: Actions --------------------------------------------------------------------------------------------------------
    
    @IBAction func addBarButton(_ sender: Any) {
        
        // Presents AddMovieViewController
        performSegue(withIdentifier: "addMovie", sender: nil)
    }
    

    @IBAction func suggestMeAMovie(_ sender: Any) {
        
        // Random cell
        let randNum = arc4random_uniform(UInt32(movies.count))
        let index = IndexPath(row: Int(randNum), section: 0)
        let cell = tableView.cellForRow(at: index)
        
        performSegue(withIdentifier: "addMovie", sender: cell)
    }
    
    // MARK: Prepare for segues ---------------------------------------------------------------------------------------------
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
        // If unwind segue came from AddMovieViewController
        if let vc = segue.source as? AddMovieViewController, let movie = vc.movie {
            
            if vc.deleteSelection {
                let indexPath = tableView.indexPathForSelectedRow!
                movies.remove(at: indexPath.row)
                
            } else {
                
                // If user selected cell to edit previously, update that cells contents
                if let indexPath = tableView.indexPathForSelectedRow {
                    movies[indexPath.row] = movie
                } else {
                    movies.append(movie)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addMovie" {
            let vc = segue.destination as! AddMovieViewController
            
            // Pass selectedCell's data to AddMovieViewController
            if let selectedCell = sender as? MovieCell {
             let indexPath = tableView.indexPath(for: selectedCell)!
             let selectedMovie = movies[indexPath.row]
                
              vc.movie = selectedMovie
            }
        }
    }
    
    
    // MARK: Overrides ------------------------------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        load()
    }
    
    
    // MARK: TableView ------------------------------------------------------------------------------------------------------
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath) as! MovieCell
        
        // Configure cell
        cell.title.text = movies[indexPath.row].title
        cell.desc.text = movies[indexPath.row].desc
        cell.rating.rating = movies[indexPath.row].rating
                
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "addMovie", sender: tableView.cellForRow(at: indexPath))
    }
    
    
    // MARK: Saving and loading ---------------------------------------------------------------------------------------------
    
    func save() {
        let defaults = UserDefaults.standard
        let data = NSKeyedArchiver.archivedData(withRootObject: movies)
        defaults.set(data, forKey: "movies")
    }
    
    func load() {
        let defaults = UserDefaults.standard
        if let data = defaults.object(forKey: "movies") as? Data {
            movies = NSKeyedUnarchiver.unarchiveObject(with: data) as! [Movie]
        }
    }
}









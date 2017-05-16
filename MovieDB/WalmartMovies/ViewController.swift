//
//  ViewController.swift
//  TheMovieDB
//
//  Created by Nehemiah Horace on 5/15/17.
//  Copyright © 2017 Nehemiah Horace. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UISearchResultsUpdating, UISearchControllerDelegate, UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var movies = [Movies]()
    var filteredMovies = [Movies]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setSearchController()
        getMoviesRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as! TableViewCell
        let movie: Movies
        
        if searchController.isActive && searchController.searchBar.text != "" {
            movie = filteredMovies[indexPath.row]
            cell.configureCell(movie)
        }
        return cell
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }
    
    func getMoviesRequest() {
        
        let postData = NSData(data: "{}".data(using: String.Encoding.utf8)!)
        let url = "https://api.themoviedb.org/3/search/movie?api_key=56a98d5f2dc64b146be8603f7e21a34b&language=en-US&query=test&page=1&include_adult=false"
        
        var request = URLRequest.init(url: NSURL.init(string: url)! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request, completionHandler: {
            (data, response, error) -> Void in
            if (error != nil) {
                print(error!)
            } else {
                let httpResponse = response as? HTTPURLResponse
                print("Movie response", httpResponse!)
                
                do {
                    if let data = data,
                        let json = try JSONSerialization.jsonObject(with: data) as? Dictionary<String, AnyObject>,
                        let results = json["results"] as? [[String: Any]] {
                        for result in results {
                            if let movieDictionary = result as? Dictionary<String, AnyObject> {
                                let movie = Movies(dictionary: movieDictionary)
                                self.movies.insert(movie, at: 0)
                            }
                        }
                    }
                } catch {
                    print("Error deserializing JSON: \(error)")
                }
            }
        })
        
        dataTask.resume()
        
    }
    
    func setSearchController() {
        // Setup the Search Controller
        searchController.searchBar.delegate = self
        searchController.searchResultsUpdater = self
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false

        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.searchBarStyle = UISearchBarStyle.prominent
        searchController.view.backgroundColor = UIColor.clear
        searchController.searchBar.barTintColor = UIColor.clear
        searchController.searchBar.tintColor = UIColor.white
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
//        filterContentForSearchText(searchController.searchBar.text!, scope: scope)
    }
    
    func dismissKeyboard() {
        searchController.searchBar.resignFirstResponder()
    }

}


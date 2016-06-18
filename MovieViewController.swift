//
//  MovieViewController.swift
//  MovieViewer
//
//  Created by Mazen Raafat Ibrahim on 6/14/16.
//  Copyright © 2016 Mazen Raafat Ibrahim. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD


class MovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var movies: [NSDictionary]?
    var endpoint: String!
    
    var filteredMovies: [NSDictionary]?
    
    
    
    var selectedBackgroundView: UIView?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        searchBar.delegate = self
        
        
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
        tableView.delegate = self
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,                                                                completionHandler: { (dataOrNil, response, error) in
            
            self.tableView.reloadData()
            
            refreshControl.endRefreshing()
            
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            
            if let data = dataOrNil {                                                                                          if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(                                                                                data, options:[]) as? NSDictionary {                                                                                print("response: \(responseDictionary)")
            
            self.movies = responseDictionary["results"] as? [NSDictionary]
            self.tableView.reloadData()
            }
            }
        })
        task.resume()
        
        self.navigationItem.title = "Movies"
        if let navigationBar = navigationController?.navigationBar {
            navigationBar.tintColor = UIColor(red: 1.0, green: 0, blue: 0, alpha: 0.9)
            
            let shadow = NSShadow()
            shadow.shadowColor = UIColor.grayColor().colorWithAlphaComponent(0.8)
            shadow.shadowOffset = CGSizeMake(2, 2);
            shadow.shadowBlurRadius = 4;
            navigationBar.titleTextAttributes = [
                NSFontAttributeName : UIFont.boldSystemFontOfSize(22),
                NSForegroundColorAttributeName : UIColor(red: 0.8, green: 0.15, blue: 0.15, alpha: 0.8),
                NSShadowAttributeName : shadow
            ]
        }

        // Do any additional setup after loading the view.
        
        
    }
    
    
    
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        
        
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = NSURL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
        let request = NSURLRequest(
            URL: url!,
            cachePolicy: NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData,
            timeoutInterval: 10)
        
        let session = NSURLSession(
            configuration: NSURLSessionConfiguration.defaultSessionConfiguration(),
            delegate: nil,
            delegateQueue: NSOperationQueue.mainQueue()
        )
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        let task: NSURLSessionDataTask = session.dataTaskWithRequest(request,                                                                completionHandler: { (dataOrNil, response, error) in
            
            self.tableView.reloadData()
            
            refreshControl.endRefreshing()
            
            MBProgressHUD.hideHUDForView(self.view, animated: true)
            
            if let data = dataOrNil {  if let responseDictionary = try! NSJSONSerialization.JSONObjectWithData(                                                                                data, options:[]) as? NSDictionary {                                                                                print("response: \(responseDictionary)")
                
                self.movies = responseDictionary["results"] as? [NSDictionary]
                self.filteredMovies = self.movies
                self.tableView.reloadData()
                }
            }
        })
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let filteredMovies = filteredMovies {
            return filteredMovies.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! Movie_Cell
        
        
        let filteredMovie = filteredMovies![indexPath.row]
        let title = filteredMovie["title"] as! String
        let overview = filteredMovie["overview"] as! String
        let rating = filteredMovie["vote_average"] as! Double
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        cell.ratings.text = "\(rating)"
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.blackColor()
        cell.selectedBackgroundView = backgroundView
        
        
        let baseUrl = "http://image.tmdb.org/t/p/w500"
        
        if let posterPath = filteredMovie["poster_path"] as? String {
            
        let imageUrl = NSURL(string: baseUrl + posterPath)
        cell.posterView.setImageWithURL(imageUrl!)
            
        }
        
        
        return cell
        
    }
    
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        if searchText.isEmpty {
            filteredMovies = movies
        } else {
            filteredMovies = movies!.filter({(dataItem: NSDictionary) -> Bool in
                // your looking at a single movie dictionary
                // dig in and get out the title as a string
                let title = dataItem["title"] as! String
                
                
                if title.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil {
                    return true
                } else {
                    return false
                }
            })
        }
        tableView.reloadData()
    }

    
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)
        let movie = movies![indexPath!.row]
        
        
        let detailViewController = segue.destinationViewController as! DetailViewController
        detailViewController.movie = movie
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    

}

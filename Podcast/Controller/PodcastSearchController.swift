//
//  PodcastSearchController.swift
//  Podcast
//
//  Created by prog on 1/7/19.
//  Copyright © 2019 prog. All rights reserved.
//

import UIKit
import Alamofire

class PodcastSearchController : UITableViewController,UISearchBarDelegate{
    var podcasts  = [Podcast]()
    
    let cellID = "cellID"
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupSearchBar()
        searchBar(searchController.searchBar, textDidChange: "voong")
        
        
    }
    //MARK:- SETUP SEARCHCONTROLLER
    fileprivate func setupSearchBar(){
        self.definesPresentationContext = true
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        APIService.shared.fetchPodcast(searchText: searchText) { (podcastArray) in
            self.podcasts = podcastArray
            self.tableView.reloadData()
        }
       
    }
    
    //MARK:- SETUP TABLEVIEW
    fileprivate func setupTableView(){
//    tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        let nib = UINib(nibName: "PodcastCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "NO Results! Please enter a search term"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = .purple
        return label
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        // ternary operator
        return self.podcasts.isEmpty && searchController.searchBar.text?.isEmpty == true ? 250 : 0
    }
    
    var podcastSearchView = Bundle.main.loadNibNamed("PodcastsSearchingView", owner: self, options: nil)?.first as? UIView
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return podcastSearchView
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return podcasts.isEmpty && searchController.searchBar.text?.isEmpty == false ? 200 : 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let episodeController = EpisodesController()
         let podcast = podcasts[indexPath.row]
        episodeController.podcast = podcast
        self.navigationController?.pushViewController(episodeController, animated: true)
        
            
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PodcastCell
        
        let podcast = self.podcasts[indexPath.row]
        cell.podcast = podcast
       
//        cell.textLabel?.text = "\(podcast.trackName ?? "")\n\(podcast.artistName ?? "")"
//        cell.textLabel?.numberOfLines = -1
//
//        cell.imageView?.image = UIImage(named :"appicon")
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 132
    }
    
}

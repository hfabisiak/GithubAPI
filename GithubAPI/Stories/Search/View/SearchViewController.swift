//
//  SearchViewController.swift
//  GithubAPI
//
//  Created by Hubert Fabisiak on 29/04/2019.
//  Copyright © 2019 HubertFabisiak. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    var searchView: SearchView {
        return view as! SearchView
    }
    
    override func loadView() {
        view = SearchView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Repositories"
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    

}

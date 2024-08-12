//
//  WeatherSearchViewController.swift
//  WeatherApp
//
//  Created by Admin on 8/11/24.
//

import UIKit

class WeatherSearchViewController: UIViewController {
    
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var searchBar: UISearchBar!
    @IBOutlet weak private var activityIndicatorView: UIActivityIndicatorView!
    
    private let viewModel = WeatherSearchViewModel()
    
    private struct Constants {
        static let weatherCellIdentifier = "WeatherTableViewCell"
        static let titleText = "Weather Search"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupUI() {
        self.title = Constants.titleText
        
    }

}

extension WeatherSearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell", for: indexPath) as! WeatherTableViewCell
        let item = viewModel.data[indexPath.row]
                cell.configure(with: item.title, subtitle: item.subtitle)
                return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}


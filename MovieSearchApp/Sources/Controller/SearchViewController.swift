//
//  ViewController.swift
//  MovieSearchApp
//
//  Created by KEEN on 2022/04/15.
//

import UIKit
import Kingfisher

class SearchViewController: UIViewController {

  // MARK: Properties
  let searchView = SearchView()
  let apiService = APIService()
  
  var movieList: [Movie] = []
  
  // MARK: View Life-Cycle
  override func loadView() {
    self.view = searchView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()

    apiService.fetchLocationInfo(query: "스파이더맨") { code, data in
      self.movieList = data.items
      self.searchView.tableView.reloadData()
      print(self.movieList[0])
    }
  }
  
  // MARK: Configure
  func configure() {
    configureNavigationBar()
    configureSearchController()
    
    searchView.tableView.delegate = self
    searchView.tableView.dataSource = self
  }
  
  func configureNavigationBar() {
    title = "영화검색"
    self.navigationController?.navigationBar.prefersLargeTitles = true
    
    let rightBarButton = UIBarButtonItem(title: "즐겨찾기 목록", style: .done, target: self, action: #selector(onFavoriteList))
    self.navigationItem.rightBarButtonItem = rightBarButton
  }
  
  func configureSearchController() {
    let searchController = UISearchController(searchResultsController: nil)
    searchController.searchResultsUpdater = self
    searchController.searchBar.delegate = self
    navigationItem.hidesSearchBarWhenScrolling = false
    searchController.searchBar.placeholder = "영화명을 검색해보세요"
    navigationItem.searchController = searchController
  }
  
  
  @objc func onFavoriteList() {
    print(#function)
  }
  
}

// MARK: Extensions - UITableViewDelegate & UITableViewDataSource
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return movieList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
    let movie = movieList[indexPath.row]
    cell.posterImageView.kf.setImage(with: URL(string: movie.image))
    cell.titleLabel.text = movie.title
    cell.directorLabel.text = movie.director
    cell.actorLabel.text = movie.actor
    cell.rateLabel.text = movie.userRating
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 110 // test
  }
}

//MARK: Extensions - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    print(#function)
  }
  
  
}

//MARK: Extensions - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
  
}

//
//  ViewController.swift
//  MovieSearchApp
//
//  Created by KEEN on 2022/04/15.
//

import UIKit
import Kingfisher

// TODO: pagination 처리하기

class SearchViewController: UIViewController {

  // MARK: Properties
  let searchView = SearchView()
  let apiService = APIService()
  
  let perPage: Int = 15
  var queryText: String?
  var start: Int = 1
  var pageableCount: Int = 0
  var ispaging: Bool = true
  
  var movieList: [Movie] = []
  
  // MARK: View Life-Cycle
  override func loadView() {
    self.view = searchView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configure()
  }
  
  // MARK: Configure
  func configure() {
    configureNavigationBar()
    configureSearchController()
    
    searchView.tableView.delegate = self
    searchView.tableView.dataSource = self
    searchView.tableView.prefetchDataSource = self
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
  
  func fetchData(query: String, perPage: Int = 15, start: Int = 1) {
    self.apiService.fetchLocationInfo(query: query, display: perPage, start: start) { code, data in
      self.pageableCount = data.total
      self.movieList += data.items
      self.start += perPage
      
      self.searchView.tableView.reloadData()
    }
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
    cell.configure(movie: movie)
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 110
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    print(indexPath.row)
  }
}

// MARK: Extensions - UITableViewDataSourcePrefetching
extension SearchViewController: UITableViewDataSourcePrefetching {
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    for indexPath in indexPaths {
      if ispaging == true {
        if movieList.count - 1 == indexPath.row {
          guard let query = queryText else { return }
          
          if pageableCount > perPage + start {
            fetchData(query: query, start: perPage + start)
          } else {
            fetchData(query: query, start: perPage + start)
            ispaging = false
          }
        }
      }
    }
  }
}

//MARK: Extensions - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) { // 검색어에 따른 실시간 검색이 되도록 하기 위해 작성
    ispaging = true
    movieList = []
    queryText = searchController.searchBar.text
    fetchData(query: queryText!)
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    ispaging = true
    movieList = []
    queryText = searchBar.text
    fetchData(query: queryText!)
  }
}

//MARK: Extensions - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
  
}

//
//  ViewController.swift
//  MovieSearchApp
//
//  Created by KEEN on 2022/04/15.
//

import UIKit
import Kingfisher

// TODO: pagination 처리하기

class SearchViewController: BaseViewController {

  // MARK: Properties
  let searchView = MovieListView()
  let apiService = APIService()
  var repository: MovieRepository? = nil
  
  let perPage: Int = 15
  var queryText: String?
  var start: Int = 1
  var pageableCount: Int = 0
  var ispaging: Bool = true
  
  var movieList: [FavoriteMovie] = []
  
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
    searchController.searchBar.placeholder = "영화명을 검색해보세요"
    navigationItem.hidesSearchBarWhenScrolling = false
    navigationItem.searchController = searchController
  }
  
  func fetchData(query: String, perPage: Int = 15, start: Int = 1) {
    self.apiService.fetchMovieInfo(query: query, display: perPage, start: start) { code, data in
      let items = data.items.map { $0.toMovie().toFavoriteMovie() }
      
      self.pageableCount = data.total
      self.movieList += items
      self.start += perPage
      
      self.searchView.tableView.reloadData()
    }
  }
  
  func fetchNewData(query: String?) {
    ispaging = true
    movieList = []
    queryText = query
    fetchData(query: queryText!)
  }

  @objc func onFavoriteList() {
    let favoritesVC = FavoritesViewController()
    favoritesVC.repository = repository
    
    let nav = UINavigationController(rootViewController: favoritesVC)
    nav.modalPresentationStyle = .fullScreen
    
    self.present(nav, animated: true)
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
    cell.delegate = self
    cell.infoView.configure(movie: movie)
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Metric.cellHeight
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let detailVC = DetailViewController()
    let selectedMovie = movieList[indexPath.row]
    detailVC.movie = selectedMovie

    self.navigationController?.pushViewController(detailVC, animated: true)
  }
}

// MARK: Extensions - UITableViewDataSourcePrefetching
extension SearchViewController: UITableViewDataSourcePrefetching {
  // TODO: Pagination 좀 더 깔끔하게 구현해보기
  func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
    for indexPath in indexPaths {
      if ispaging == true, movieList.count - 1 == indexPath.row {
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

//MARK: Extensions - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    fetchNewData(query: searchController.searchBar.text)
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    fetchNewData(query: searchBar.text)
  }
}

// MARK: - SearchTableViewCellDelegate
extension SearchViewController: SearchTableViewCellDelegate {
  func starButtonClicked(searchTableViewCell: SearchTableViewCell) {
    guard let repo = repository else { return }
    guard let indexPath = searchView.tableView.indexPath(for: searchTableViewCell) else { return }
    
    let movieItem = movieList[indexPath.row]
    
    if !repo.isContain(item: movieItem) {
      searchTableViewCell.infoView.starButton.isSelected = true
      repo.add(item: movieItem)
    } else {
      searchTableViewCell.infoView.starButton.isSelected = false
      repo.remove(item: movieItem)
    }
  }
}

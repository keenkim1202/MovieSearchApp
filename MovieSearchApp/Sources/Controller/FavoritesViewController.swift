//
//  FavoritesViewController.swift
//  MovieSearchApp
//
//  Created by KEEN on 2022/04/15.
//

import UIKit

class FavoritesViewController: BaseViewController {
  
  // MARK: - Properties
  let favoritesView = MovieListView()
  var repository: MovieRepository? = nil
  var favoritesList: [FavoriteMovie] = []
  
  // MARK: - View Life-Cycle
  override func loadView() {
    view = favoritesView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    favoritesView.tableView.delegate = self
    favoritesView.tableView.dataSource = self
    fetchData()
    configureNagivationBar()
  }
  
  func fetchData() {
    guard let repo = repository else { return }
    favoritesList = repo.fetch()
  }
  
  private func configureNagivationBar() {
    title = "즐겨찾기 목록"
    
    let leftBarButton = UIBarButtonItem(image: UIImage(systemName: "multiply"), style: .done, target: self, action: #selector(onDone))
    self.navigationItem.leftBarButtonItem = leftBarButton
  }
  
  @objc func onDone() {
    self.dismiss(animated: true)
  }
  
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favoritesList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
    let favoriteMovie = favoritesList[indexPath.row]
    cell.infoView.configure(movie: favoriteMovie)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Metric.cellHeight
  }
  
}

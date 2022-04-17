//
//  FavoritesViewController.swift
//  MovieSearchApp
//
//  Created by KEEN on 2022/04/15.
//

import UIKit

class FavoritesViewController: BaseViewController {
  
  // MARK: - Properties
  let favoritesView = MovieInfoView()
  
  // MARK: - View Life-Cycle
  override func loadView() {
    view = favoritesView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    configureNagivationBar()
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

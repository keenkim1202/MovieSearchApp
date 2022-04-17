//
//  FavoritesView.swift
//  MovieSearchApp
//
//  Created by KEEN on 2022/04/18.
//

import UIKit
import SnapKit

class FavoritesView: UIView, ViewRepresentable {
  
  // MARK: - UI
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    createViews()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configure
  func createViews() {
    
  }
  
  func setConstraints() {
    
  }
  
}

//
//  SearchTableViewCell.swift
//  MovieSearchApp
//
//  Created by KEEN on 2022/04/15.
//

import UIKit
import SnapKit

class SearchTableViewCell: UITableViewCell, ViewRepresentable {
  
  static let identifier = String(describing: SearchTableViewCell.self)

  // MARK: - UI
  let infoView = MovieInfoView()
  
  // MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    createViews()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configure
  func createViews() {
    contentView.addSubview(infoView)
  }
  
  func setConstraints() {
    infoView.translatesAutoresizingMaskIntoConstraints = false

    let safeArea = contentView.safeAreaLayoutGuide
    
    infoView.snp.makeConstraints {
      $0.edges.equalTo(safeArea)
    }
  }
  
}

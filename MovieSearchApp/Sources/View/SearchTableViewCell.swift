//
//  SearchTableViewCell.swift
//  MovieSearchApp
//
//  Created by KEEN on 2022/04/15.
//

import UIKit
import SnapKit

protocol SearchTableViewCellDelegate: AnyObject {
  func starButtonClicked(searchTableViewCell: SearchTableViewCell)
}

class SearchTableViewCell: UITableViewCell, ViewRepresentable {
  
  weak var delegate: SearchTableViewCellDelegate?
  
  static let identifier = String(describing: SearchTableViewCell.self)

  // MARK: - UI
  let infoView = MovieInfoView()
  
  // MARK: - Init
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    infoView.starButton.addTarget(self, action: #selector(onStar), for: .touchUpInside)
    createViews()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  @objc func onStar() {
    delegate?.starButtonClicked(searchTableViewCell: self)
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

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
  let posterImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "square.slash")
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = .white
    imageView.tintColor = .mainOrangeColor
    return imageView
  }()
  
  let verticalStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = .vertical
    stackView.spacing = 5
    return stackView
  }()
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.text = "title"
    label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
    return label
  }()
  
  let directorLabel: UILabel = {
    let label = UILabel()
    label.text = "director"
    label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    return label
  }()
  
  let actorLabel: UILabel = {
    let label = UILabel()
    label.text = "actor"
    label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    return label
  }()
  
  let rateLabel: UILabel = {
    let label = UILabel()
    label.text = "rate"
    label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
    return label
  }()
  
  let starButton: UIButton = {
    let button = UIButton()
    button.setImage(UIImage(systemName: "star"), for: .normal)
    button.tintColor = .mainOrangeColor
    return button
  }()
  
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
    [titleLabel, directorLabel, actorLabel, rateLabel].forEach {
      verticalStackView.addArrangedSubview($0)
    }
    
    [posterImageView, verticalStackView, starButton].forEach {
      contentView.addSubview($0)
    }
  }
  
  func setConstraints() {
    [posterImageView, verticalStackView, starButton, titleLabel, directorLabel, actorLabel, rateLabel].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }

    let safeArea = contentView.safeAreaLayoutGuide
    let buttonWidth: CGFloat = 20
    
    posterImageView.snp.makeConstraints {
      $0.width.equalTo(posterImageView.snp.height).multipliedBy(0.7)
      $0.leading.equalTo(safeArea).offset(10)
      $0.top.equalTo(safeArea).offset(10)
      $0.bottom.equalTo(safeArea).offset(-10)
    }
    
    verticalStackView.snp.makeConstraints {
      $0.leading.equalTo(posterImageView.snp.trailing).offset(10)
      $0.top.equalTo(safeArea).offset(10)
      $0.bottom.equalTo(safeArea).offset(-10)
      $0.trailing.equalTo(safeArea).offset(-10)
    }
    
    starButton.snp.makeConstraints {
      $0.width.height.equalTo(buttonWidth)
      $0.trailing.equalTo(safeArea).offset(-10)
      $0.top.equalTo(safeArea).offset(10)
    }
  }
  
}

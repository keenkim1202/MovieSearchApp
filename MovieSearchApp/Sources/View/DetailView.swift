//
//  DetailView.swift
//  MovieSearchApp
//
//  Created by KEEN on 2022/04/18.
//

import UIKit
import WebKit
import SnapKit

class DetailView: UIView, ViewRepresentable {
  
  var topConstraint: Constraint? = nil
  
  // MARK: - UI
  let infoView = MovieInfoView()
  let webView = WKWebView()
  
  // MARK: - Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    webView.scrollView.delegate = self
    createViews()
    setConstraints()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Configure
  func createViews() {
    [infoView, webView].forEach {
      addSubview($0)
    }
  }
  
  func setConstraints() {
    [infoView, webView].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let safeArea = safeAreaLayoutGuide
    
    infoView.snp.makeConstraints {
      $0.leading.trailing.top.equalTo(safeArea)
      $0.height.equalTo(110)
      self.topConstraint = $0.top.equalTo(safeArea).constraint
    }
    
    webView.snp.makeConstraints {
      $0.leading.trailing.bottom.equalTo(safeArea)
      $0.top.equalTo(infoView.snp.bottom)
    }
  }
}

extension DetailView: UIScrollViewDelegate {
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    guard let topConstraint = topConstraint else { return }
    
    if scrollView.contentOffset.y > 0 {
      if scrollView.contentOffset.y < 110 {
        topConstraint.update(offset: -scrollView.contentOffset.y)
      } else {
        topConstraint.update(offset: -110)
      }
    } else {
      topConstraint.update(offset: 0)
    }
  }
}


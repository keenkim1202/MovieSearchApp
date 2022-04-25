# MovieSearchApp
네이버 영화 API를 활용한 영화 검색 앱 입니다.

- MVC 패턴으로 작성하였습니다.

## API
- [네이버 영화 API](https://developers.naver.com/docs/serviceapi/search/movie/movie.md#%EC%98%81%ED%99%94)

## 사용 라이브러리
- Alamofire
  - HTTP 통신 처리를 위해 사용하였습니다.
- Kingfisher
  - url로부터 이미지를 비동기적으로 처리하기 위해 사용하였습니다.
- Snapkit
  - AutoLayout을 가독성이 좋은 코드로 작성하기 위해 사용하였습니다.
- Realm
  - 즐겨찾기 영화 정보를 저장하기 위해 사용하였습니다.

## 구현 기능
- [x] custom UI 구성
  - [x] MovieListView
  - [x] DetailView
    - [x] 상단 InfoView 구현 (아래로 스크롤 시 사라지고, 위로 스크롤 시 보이도록)
  - [x] MovieInfoView
  - [x] SearchTableViewCell  
- [x] Model 생성
  - [x] Movie : 영화 정보 모델
  - [x] MovieInfo : Movie 리스트와 total(총 검색 결과 갯수) 정보 모델
- [x] API 통신 처리
  - [x] Movie 정보 가져오기
  - [x] 검색 키워드 변화에 따른 실시간 검색 구현
  - [ ] 통신 Error 처리하기
- [ ] 즐겨찾기 구현
  - [ ] 즐겨찾기된 영화의 경우 alert 띄우기

## 이슈 해결

<details>
 <summary> DetailVC(영화 상세화면) : 스크롤 시 사라지는 뷰 만드는 방법 </summary>
 
 - 상단의 작은 뷰와 웹뷰로 화면이 구성되어있음
 - 아래로 스크롤을 하면 안보이고, 다시 위로 스크롤하면 보이는 뷰를 넣고 싶었음
 - view의 상단 제약조건의 contentOffset을 빼주어 구현함. (함께 있는 뷰가 UIScrollView를 상속받고 있다면 아래의 방법으로 적용 가능)
 
  ```swift
 class SomeView: UIView {
    // 변수 선언
    var topConstraint: Constraint? = nil
    ...

    // 제약조건 설정

    func setConstraints() {
      infoView.snp.makeConstraints {
        $0.leading.trailing.top.equalTo(safeArea)
        $0.height.equalTo(110)
        self.topConstraint = $0.top.equalTo(safeArea).constraint
      }
    }
 }

  // 스크롤 될 때 뷰 올라가게 하기
  extension SomeView: UIScrollViewDelegate {
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
  ```

</details>
  
  
# 실행영상!
<img src="https://user-images.githubusercontent.com/59866819/165029353-861e8a3c-0ba7-456b-9374-31b23f276646.gif">

  

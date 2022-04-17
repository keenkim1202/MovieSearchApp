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
- Realm (사용 예정)
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
- [ ] 즐겨찾기 구현

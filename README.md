# 여행은 Trip

# 📱앱 주요 화면

## 주요 기능
- 여행 날짜와 지역 설정, 장소 검색, 장소 추가, 메모 작성
- 애플맵 연동, 날짜 별 경로 확인, 애플맵 경로 찾기
- 사진 일기 작성, 조회
## 개발 기간
2023.09.25 ~ 2023.10.23

# 🔨기술스택
- 최소 버전: iOS 15.0
- UIKit(Codebase UI), MVVM
- DiffableDataSource, CompositionalLayout
- MapKit
- RealmSwift
- Firebase Push Notifications


11월 12일 업데이트(1.0.1)
  - 사진일기 작성 뷰에서 키보드 올라온 상태에서 사진이 없을 때 작성버튼 누르면 뷰가 두번 내려가서 검은화면 보이는 현상 해결
  - 나라 검색 목록 처음 들어갔을 때 바로 목록으로 보여주기
  - 맵뷰에서 날짜 컬렉션뷰 선택 시 강조색상 추가
  - 여행지 검색 영역 부분 확대

24년 1월 2일 업데이트(1.0.2)
  - Push Notification 추가
  - Firebase Crashlytics 추가

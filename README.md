# Vapor_Todos

Todos Server with Swift Vapor

- [x] 아래 URL에서 이야기한 내용 적용해본다.
https://theswiftdev.com/a-generic-crud-solution-for-vapor-4/

- [ ] 다음은 아래 URL을 해보자
https://theswiftdev.com/get-started-with-the-fluent-orm-framework-in-vapor-4/

- [ ] 그 다음은 docker 아래 URL을 해보자
https://theswiftdev.com/server-side-swift-projects-inside-docker-using-vapor-4/

### 2020-06-30
- [x] 모든 회사의 고유정보 획득하기
    - [x] CORPCODE.xml - 일단 브라우저로 다운 받은 xml 파일을 로딩해서 db 에 입력했다.
        * Data(contentsOf:) 로 획득한 데이터는 encoding이 깨져있었다.
- 재무정보 획득하기
    - 획득할 값 목록을 정리하기
    - 획득한 값 DB 스킴 구성하기
    - SwiftSoup 으로 값 획득하기
    - 획득한 값 DB 저장하기
- rim분석
    - rim 분석이란.?

### 2020-06-29
- 모든 회사의 상세정보 획득하기
    - CORPCODE.xml
- 재무정보 획득하기
    - 획득할 값 목록을 정리하기
    - 획득한 값 DB 스킴 구성하기
    - SwiftSoup 으로 값 획득하기
    - 획득한 값 DB 저장하기
- rim분석
    - rim 분석이란.?
- [x] Company, ListItem, DB에 없을 때 Web 에서 조회하도록 함
- [x] DcmNo 값을 ListItem 획득시 함께 가져오도록 함
- [x] SwiftSoup 패키지 추가
- [x] DartClient
    - [x] JSONLoader: DartApi조회코드 보기좋게 + 조회 쿼터 넘지 않도록 조절
    - [x] Company, ReceptionList -> DocumentNo
- [x] Models
    - [x] Compony, ListItem

### 2020-05-09
- [x] 환경 구성 MacMini / Vapor, Docker 처음
  - [x] 빌드/ 실행 가능한 Vapor4 환경 구성
- Docker 구성


### 2020-05-06
- Git 구성

### 2020-05-05
- 프로젝트 생성
- 페이지에 나와 있는 데로 연습


##  TODOs Vapor4 app recap

### install vapor-beta for Vapor4 - Vapor4 is beta

    // https://docs.vapor.codes/3.0/install/macos/
    brew tap vapor/tap
    brew install vapor/tap/vapor
    brew install vapor/tap/vapor-beta

### create project with vapor

    vapor-beta new Todos
    vapor-beta xcode
    swift package generate-xcodeproj

### create local fluent store

    swift run Run migrate

### run

    swift run Run
    
### update swift packages

    swift package update
    swift package generate-xcodeproj

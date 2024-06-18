
![Project Logo](https://github.com/cmgjn1881/PlayFormation/blob/main/images/playformationIcon.jpeg?raw=true)

<div align="center">
2024 Ios Project<br>
An iOS app for setting up soccer & futsal formations.<br>
</div>

## 목차
 - [작품 개요](#작품-개요)
 - [주요 코드 설명](#주요-코드-설명)

## 작품 개요
* ...
* ...

## 주요 코드 설명
* [SportSelectionViewController](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/SportSelectionViewController.swift) : 앱 실행 시 표시되는 화면의 컨트롤러 코드입니다. soccer 버튼과 futsal 버튼 각각의 화면 전환 코드를 포함하고 있는 뷰 컨트롤러 입니다.
* [FootballSetupViewController](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FootballSetupViewController.swift) : 축구 포메이션을 설정하고 관리하는 화면의 뷰 컨트롤러입니다. 사용자는 축구 필드와 벤치에 선수들을 배치하고, 포메이션을 저장하거나 불러오며, 포메이션을 리셋할 수 있는 기능을 구현한 컨트롤러 입니다.
   - [필드 포메이션 설정](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FootballSetupViewController.swift#L37) = `setupFormation()`
   - [벤치 플레이어 설정](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FootballSetupViewController.swift#L83) = `setupBenchPlayers()`
   - [제스처 처리](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FootballSetupViewController.swift#L117) = `handlePan`
   - [선수 정보 수정](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FootballSetupViewController.swift#L151) = `handleTap`
   - [포메이션 저장](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FootballSetupViewController.swift#L185) = `@IBAction func SaveButton(_ sender: Any)`, `saveFormation(title: String)`
   - [포메이션 불러오기](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FootballSetupViewController.swift#L224) = `@IBAction func LoadButton(_ sender: Any)`, `loadSavedFormations()`, `loadFormation(title: String)`
   - [포메이션 리셋](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FootballSetupViewController.swift#L307) = `@IBAction func ResetButton(_ sender: Any)`
   - [포메이션 정보 표시](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FootballSetupViewController.swift#L323) = `@IBAction func Formation_InfButton(_ sender: Any)`, 포메이션 정보 버튼을 누르면 `FormationInfoViewController`를 표시하여 포메이션 정보를 보여줍니다.
   - [토스트 메시지 표시](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FootballSetupViewController.swift#L341) = `func showToast(message: String, duration: Double = 3.0)`
   - [PlayerViewDelegate 구현](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FootballSetupViewController.swift#L361) = `func handlePlayerSelection(_ selectedPlayer: PlayerView)`
 
* [FutsalSetupViewController](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FutsalSetupViewController.swift) : 풋살 포메이션을 설정하고 관리하는 화면의 뷰 컨트롤러입니다. 사용자는 풋살 필드와 벤치에 선수들을 배치하고, 포메이션을 저장하거나 불러오며, 포메이션을 리셋할 수 있는 기능을 구현한 뷰 컨트롤러 입니다.
   - [필드 포메이션 설정](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FutsalSetupViewController.swift#L33) = `setupFormation()`
   - [벤치 플레이어 설정](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FutsalSetupViewController.swift#L90) = `setupBenchPlayers()`
   - [제스처 처리](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FutsalSetupViewController.swift#L121) = `handlePan`
   - [선수 정보 수정](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FutsalSetupViewController.swift#L154) = `handleTap`
   - [포메이션 저장](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FutsalSetupViewController.swift#L188) = `@IBAction func SaveButton(_ sender: Any)`, `saveFormation(title: String)`
   - [포메이션 불러오기](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FutsalSetupViewController.swift#L228) = `@IBAction func LoadButton(_ sender: Any)`, `loadSavedFormations()`, `loadFormation(title: String)`
   - [포메이션 리셋 및 변경](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FutsalSetupViewController.swift#L311) = `@IBAction func ResetButton(_ sender: Any)`, `@IBAction func set4PButton(_ sender: Any)`, `@IBAction func set5PButton(_ sender: Any)`, `@IBAction func set6PButton(_ sender: Any)`
   - [PlayerViewDelegate 구현](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FutsalSetupViewController.swift#L373) = `handlePlayerSelection(_ selectedPlayer: PlayerView)`
     
* [FormationListViewController](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FormationListViewController.swift) : 테이블 뷰를 사용하여 저장된 포메이션 목록을 표시하고, 선택하거나 삭제할 수 있는 기능을 구현한 뷰 컨트롤러 입니다.
   - [테이블 뷰 설정](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FormationListViewController.swift#L17) = `setupTableView()`
   - [네비게이션 바 설정](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FormationListViewController.swift#L25) = `setupNavigationBar()`
   - [테이블 뷰 데이터 소스 및 델리게이트 메서드](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FormationListViewController.swift#L29) = `tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int`, `tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell`
   - [체크박스 선택/해제](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FormationListViewController.swift#L46) = `checkboxTapped(_ sender: UIButton)`
   - [포메이션 선택](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FormationListViewController.swift#L57) = `tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)`
   - [선택된 포메이션 삭제](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FormationListViewController.swift#L63) = `deleteSelectedFormations()`
     
* [FormationInfoViewController](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FormationInfoViewController.swift) : 저장된 포메이션 목록을 테이블 뷰로 표시하고 선택된 포메이션의 세부 정보를 다른 뷰 컨트롤러에서 보여주는 기능을 구현한 뷰 컨트롤러 입니다.
   - [numberOfRowsInSection](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FormationInfoViewController.swift#L20) = 섹션 내 행의 수를 반환
   - [cellForRowAt](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FormationInfoViewController.swift#L24) = 각 행에 표시할 셀을 반환
   - [didSelectRowAt](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FormationInfoViewController.swift#L) = 사용자가 특정 포메이션을 선택했을 때 호출, 선택된 포메이션 객체를 FormationDetailViewController에 전달하고, 해당 뷰 컨트롤러로 네비게이션
     
* [FormationDetailViewController](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FormationDetailViewController.swift) : 특정 포메이션의 세부 정보를 보여주는 뷰 컨트롤러 입니다.
   - [스크롤 뷰 설정](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FormationDetailViewController.swift#L32) = `setupScrollView()`
   - [레이블 설정](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FormationDetailViewController.swift#L52) = `setupLabels()`
   - [콘텐츠 구성](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FormationDetailViewController.swift#L60) = `setupContent()`
    
* [Player파일](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/Player.swift) : 이 구조체는 축구나 풋살 선수의 정보를 저장합니다.
  
* [PlayerView](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/PlayerView.swift) : 축구나 풋살의 선수 정보를 표시하고, 드래그 및 탭 제스처를 통해 사용자가 상호작용할 수 있게하는 커스텀 뷰 클래스 입니다.
   - [PlayerViewDelegate 프로토콜](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/PlayerView.swift#L3) = 선택된 선수를 처리하기 위한 델리게이트 메서드를 정의합니다.
   - [뷰 설정](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/PlayerView.swift#L34) = `setupView()`
   - [제스처 추가](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/PlayerView.swift#L81) = `addPanGesture()`, `addIconTapGesture()`
   - [제스처 핸들러](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/PlayerView.swift#L93) = `handlePan(gesture: UIPanGestureRecognizer)`드래그 제스처를 처리, `handleIconTap()`아이콘 탭 제스처를 처리
   - [선수 정보 설정](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/PlayerView.swift#L105) = `configure(playerName: String, playerNumber: String, playerPosition: String)`
  
* [FormationData](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FormationData.swift) : 다양한 축구 포메이션의 정보를 저장하는 구조체로 포메이션에는 이름, 장점, 단점, 적합한 팀, 예시 팀, 키 플레이어와 같은 세부 정보가 포함되어 있습니다.
  
* [CustomTableViewCell](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/CustomTableViewCell.swift) : 

  


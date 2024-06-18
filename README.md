
![Project Logo](https://github.com/cmgjn1881/PlayFormation/blob/main/images/playformationIcon.jpeg?raw=true)

<div align="center">
2024 Ios Project<br>
An iOS app for setting up football formations.<br>
</div>

## 목차
 - [작품 개요](#작품-개요)
 - [주요 코드 설명](#주요-코드-설명)

## 작품 개요
* ...
* ...

## 주요 코드 설명
* [SportSelectionViewController](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/SportSelectionViewController.swift) : 이 코드는 앱 실행 시 표시되는 화면의 컨트롤러 코드입니다. soccer 버튼과 futsal 버튼 각각의 화면 전환 코드를 포함하고 있습니다.
* [FootballSetupViewController](https://github.com/cmgjn1881/PlayFormation/blob/main/PlayFormation/FootballSetupViewController.swift) : 이 코드는 축구 포메이션을 설정하고 관리하는 화면의 뷰 컨트롤러입니다. 사용자는 축구 필드와 벤치에 선수들을 배치하고, 포메이션을 저장하거나 불러오며, 포메이션을 리셋할 수 있습니다.
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
 
* FutsalSetupViewController :
* FormationListViewController :
* FormationInfoViewController :
* FormationDetailViewController :
* Player파일 :
* PlayerView :
* FormationData :
* CustomTableViewCell : 

  


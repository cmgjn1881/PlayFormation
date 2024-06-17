//
//  FutsalSetupViewController.swift
//  PlayFormation PlayFormation PlayFormation
//
//  Created by cmgjnmac on 6/6/24.
//

import UIKit

class FutsalSetupViewController: UIViewController{
    @IBOutlet weak var futsalFieldImageView: UIImageView!
    @IBOutlet weak var benchImageView: UIImageView!
    
    var selectedPlayerView: PlayerView?
    var initialCenter: CGPoint?
    var playerViews: [PlayerView] = []
    let formationsKey = "savedFutsalFormations"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        futsalFieldImageView.isUserInteractionEnabled = true
        benchImageView.isUserInteractionEnabled = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupFormation(playerCount: 5)
        setupBenchPlayers()
        
    }
    
    private func setupFormation(playerCount: Int) {
        // 기존 플레이어 뷰 제거
        for playerView in playerViews {
            playerView.removeFromSuperview()
        }
        playerViews.removeAll()
        
        // 포메이션 설정
        let formationPositions: [(x: CGFloat, y: CGFloat, position: String)] = {
            switch playerCount {
            case 4:
                return [
                    (x: 0.5, y: 0.8, position: "GOLEIRO"),
                    (x: 0.5, y: 0.55, position: "FIXO"),
                    (x: 0.2, y: 0.35, position: "ALA"),
                    (x: 0.8, y: 0.35, position: "ALA")
                ]
            case 6:
                return [
                    (x: 0.5, y: 0.8, position: "GOLEIRO"),
                    (x: 0.5, y: 0.55, position: "FIXO"),
                    (x: 0.2, y: 0.35, position: "ALA"),
                    (x: 0.8, y: 0.35, position: "ALA"),
                    (x: 0.3, y: 0.15, position: "PIVO"),
                    (x: 0.7, y: 0.15, position: "PIVO")
                ]
            default:
                return [
                    (x: 0.5, y: 0.8, position: "GOLEIRO"),
                    (x: 0.5, y: 0.55, position: "FIXO"),
                    (x: 0.2, y: 0.35, position: "ALA"),
                    (x: 0.8, y: 0.35, position: "ALA"),
                    (x: 0.5, y: 0.15, position: "PIVO")
                ]
            }
        }()
        
        for (index, position) in formationPositions.enumerated() {
            let playerView = PlayerView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
            playerView.configure(playerName: "Player \(index + 1)", playerNumber: "\(index + 1)", playerPosition: position.position)
            playerView.center = CGPoint(x: futsalFieldImageView.bounds.width * position.x, y: futsalFieldImageView.bounds.height * position.y)
            playerView.isUserInteractionEnabled = true  // 유저 상호작용 활성화
            playerView.delegate = self  // PlayerView에 delegate 설정
            
            // UIPanGestureRecognizer 추가
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            playerView.addGestureRecognizer(panGesture)
            
            // UITapGestureRecognizer 추가 (선수 클릭 시 정보 입력)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            playerView.addGestureRecognizer(tapGesture)
            
            futsalFieldImageView.addSubview(playerView)
            playerViews.append(playerView)
        }
    }
    
    private func setupBenchPlayers() {
        
        // 벤치에 플레이어 추가
        let benchPlayerPositions: [(x: CGFloat, y: CGFloat)] = [
            (x: 0.09, y: 0.5),
            (x: 0.29, y: 0.5),
            (x: 0.49, y: 0.5),
            (x: 0.69, y: 0.5),
            (x: 0.89, y: 0.5)
        ]
        
        for (index, position) in benchPlayerPositions.enumerated() {
            let playerView = PlayerView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
            playerView.configure(playerName: "Bench \(index + 1)", playerNumber: "\(index + 1)", playerPosition: "SUB")
            playerView.center = CGPoint(x: benchImageView.bounds.width * position.x, y: benchImageView.bounds.height * position.y)
            playerView.isUserInteractionEnabled = true  // 유저 상호작용 활성화
            playerView.delegate = self  // PlayerView에 delegate 설정
            
            // UIPanGestureRecognizer 추가
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            playerView.addGestureRecognizer(panGesture)
            
            // UITapGestureRecognizer 추가 (선수 클릭 시 정보 입력)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            playerView.addGestureRecognizer(tapGesture)
            
            benchImageView.addSubview(playerView)
            playerViews.append(playerView)
        }
    }
    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let playerView = gesture.view as? PlayerView else { return }
        
        // benchImageView의 서브뷰인 경우 드래그 불가
        if playerView.superview == benchImageView {
            return
        }
        
        let translation = gesture.translation(in: view) // 전체 뷰에 대한 번역을 얻습니다.
        var newCenter = CGPoint(x: playerView.center.x + translation.x, y: playerView.center.y + translation.y)
        
        if playerView.superview == futsalFieldImageView {
            // 축구장 화면 밖으로 나가지 않도록 제약 추가
            let halfWidth = playerView.bounds.width / 2
            let halfHeight = playerView.bounds.height / 2
            
            // 축구장 경계 내에서만 움직이도록 제약 추가
            newCenter.x = max(halfWidth, min(futsalFieldImageView.bounds.width - halfWidth, newCenter.x))
            newCenter.y = max(halfHeight, min(futsalFieldImageView.bounds.height - halfHeight, newCenter.y))
        } else if playerView.superview == benchImageView {
            // 벤치 화면 밖으로 나가지 않도록 제약 추가
            let halfWidth = playerView.bounds.width / 2
            let halfHeight = playerView.bounds.height / 2
            
            // 벤치 경계 내에서만 움직이도록 제약 추가
            newCenter.x = max(halfWidth, min(benchImageView.bounds.width - halfWidth, newCenter.x))
            newCenter.y = max(halfHeight, min(benchImageView.bounds.height - halfHeight, newCenter.y))
        }
        
        playerView.center = newCenter
        gesture.setTranslation(.zero, in: view)
    }
    
    @objc private func handleTap(_ gesture: UITapGestureRecognizer) {
        guard let playerView = gesture.view as? PlayerView else { return }
        
        let alertController = UIAlertController(title: "선수 정보 수정", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { textField in
            textField.placeholder = "포지션: \(playerView.playerPosition)"
            textField.text = playerView.playerPosition
        }
        alertController.addTextField { textField in
            textField.placeholder = "등번호: \(playerView.playerNumber)"
            textField.text = playerView.playerNumber
            textField.keyboardType = .numberPad
        }
        alertController.addTextField { textField in
            textField.placeholder = "이름: \(playerView.playerName)"
            textField.text = playerView.playerName
        }
        
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            if let position = alertController.textFields?[0].text,
               let number = alertController.textFields?[1].text,
               let name = alertController.textFields?[2].text {
                playerView.configure(playerName: name, playerNumber: number, playerPosition: position)
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func SaveButton(_ sender: Any) {
        let alertController = UIAlertController(title: "포메이션 저장", message: nil, preferredStyle: .alert)
        alertController.addTextField { textField in
            textField.placeholder = "제목을 입력하세요"
        }
        
        let confirmAction = UIAlertAction(title: "확인", style: .default) { _ in
            if let title = alertController.textFields?.first?.text, !title.isEmpty {
                self.saveFormation(title: title)
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        
        alertController.addAction(confirmAction)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    private func saveFormation(title: String) {
        let formationData = playerViews.map { playerView -> [String: Any] in
            let superviewIdentifier = (playerView.superview == futsalFieldImageView) ? "futsalField" : "bench"
            return [
                "name": playerView.playerName,
                "number": playerView.playerNumber,
                "position": playerView.playerPosition,
                "center": ["x": playerView.center.x, "y": playerView.center.y],
                "superview": superviewIdentifier
            ]
        }
        var savedFormations = UserDefaults.standard.dictionary(forKey: formationsKey) ?? [String: Any]()
        savedFormations[title] = formationData
        UserDefaults.standard.set(savedFormations, forKey: formationsKey)
        
        print("포메이션 '\(title)'이(가) 저장되었습니다.")
        // Toast 메시지 표시
        showToast(message: "포메이션 '\(title)'이(가) 저장되었습니다.")
    }
    
    
    @IBAction func LoadButton(_ sender: Any) {
        let savedFormations = loadSavedFormations()
        
        let formationListVC = FormationListViewController()
        formationListVC.formations = savedFormations
        formationListVC.onFormationSelected = { [weak self] title in
            self?.loadFormation(title: title)
        }
        formationListVC.onFormationDeleted = { [weak self] title in
            self?.deleteFormation(title)
        }
        
        let navController = UINavigationController(rootViewController: formationListVC)
        
        if #available(iOS 15.0, *) {
            if let sheet = navController.sheetPresentationController {
                sheet.detents = [.medium(), .large()] // 화면의 절반 정도로 설정
                sheet.prefersGrabberVisible = true // 사용자가 손잡이를 이용해 뷰를 끌어올릴 수 있게 함
            }
        }
        
        present(navController, animated: true, completion: nil)
    }
    
    private func deleteFormation(_ title: String) {
        var savedFormations = UserDefaults.standard.dictionary(forKey: formationsKey) ?? [String: Any]()
        savedFormations.removeValue(forKey: title)
        UserDefaults.standard.set(savedFormations, forKey: formationsKey)
        
        // Toast 메시지 표시
        showToast(message: "포메이션 '\(title)'이(가) 삭제되었습니다.")
    }
    
    private func loadSavedFormations() -> [String] {
        let defaults = UserDefaults.standard
        let savedFormations = defaults.dictionary(forKey: formationsKey) ?? [:]
        return Array(savedFormations.keys)
    }
    
    private func loadFormation(title: String) {
        guard let savedFormations = UserDefaults.standard.dictionary(forKey: formationsKey),
              let formationData = savedFormations[title] as? [[String: Any]] else { return }
        
        // 기존 플레이어 뷰 제거
        for playerView in playerViews {
            playerView.removeFromSuperview()
        }
        playerViews.removeAll()
        
        // 새로운 포메이션 설정
        for data in formationData {
            if let name = data["name"] as? String,
               let number = data["number"] as? String,
               let position = data["position"] as? String,
               let centerDict = data["center"] as? [String: CGFloat],
               let centerX = centerDict["x"],
               let centerY = centerDict["y"],
               let superviewIdentifier = data["superview"] as? String {
                
                let playerView = PlayerView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
                playerView.configure(playerName: name, playerNumber: number, playerPosition: position)
                playerView.center = CGPoint(x: centerX, y: centerY)
                playerView.isUserInteractionEnabled = true  // 유저 상호작용 활성화
                playerView.delegate = self  // PlayerView에 delegate 설정
                
                // UIPanGestureRecognizer 추가
                let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
                playerView.addGestureRecognizer(panGesture)
                
                // UITapGestureRecognizer 추가 (선수 클릭 시 정보 입력)
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
                playerView.addGestureRecognizer(tapGesture)
                
                if superviewIdentifier == "futsalField" {
                    futsalFieldImageView.addSubview(playerView)
                } else if superviewIdentifier == "bench" {
                    benchImageView.addSubview(playerView)
                }
                playerViews.append(playerView)
            }
        }
    }
    
    @IBAction func ResetButton(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: "포메이션을 리셋하시겠습니까?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "예", style: .default) { [weak self] _ in
            self?.setupFormation(playerCount: 5)
            self?.setupBenchPlayers()
            self?.showToast(message: "포메이션이 리셋되었습니다.")
        }
        let noAction = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func set4PButton(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: "변경사항이 저장되지 않습니다.\n4인 포메이션으로 변경하시겠습니까?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "예", style: .default) { [weak self] _ in
            self?.setupFormation(playerCount: 4)
            self?.setupBenchPlayers()
            self?.showToast(message: "4인 포메이션으로 변경했습니다.")
        }
        let noAction = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func set5PButton(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: "변경사항이 저장되지 않습니다.\n5인 포메이션으로 변경하시겠습니까?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "예", style: .default) { [weak self] _ in
            self?.setupFormation(playerCount: 5)
            self?.setupBenchPlayers()
            self?.showToast(message: "5인 포메이션으로 변경했습니다.")
        }
        let noAction = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func set6PButton(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: "변경사항이 저장되지 않습니다.\n6인 포메이션으로 변경하시겠습니까?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "예", style: .default) { [weak self] _ in
            self?.setupFormation(playerCount: 6)
            self?.setupBenchPlayers()
            self?.showToast(message: "6인 포메이션으로 변경했습니다.")
        }
        let noAction = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

extension FutsalSetupViewController: PlayerViewDelegate {
    func handlePlayerSelection(_ selectedPlayer: PlayerView) {
        if let previousSelection = selectedPlayerView {
            if previousSelection.superview == selectedPlayer.superview {
                // 같은 이미지뷰 내에서의 교체
                UIView.animate(withDuration: 0.3) {
                    let tempCenter = previousSelection.center
                    previousSelection.center = selectedPlayer.center
                    selectedPlayer.center = tempCenter
                }
            } else {
                // 서로 다른 이미지뷰에 있는 선수들 간의 교체
                let tempName = previousSelection.playerName
                let tempNumber = previousSelection.playerNumber
                let tempPosition = previousSelection.playerPosition
                
                previousSelection.configure(playerName: selectedPlayer.playerName, playerNumber: selectedPlayer.playerNumber, playerPosition: selectedPlayer.playerPosition)
                selectedPlayer.configure(playerName: tempName, playerNumber: tempNumber, playerPosition: tempPosition)
            }
            
            // 선택 상태 해제
            previousSelection.layer.shadowColor = nil
            previousSelection.layer.shadowRadius = 0
            previousSelection.layer.shadowOpacity = 0
            previousSelection.layer.shadowOffset = CGSize(width: 0, height: 0)
            selectedPlayerView = nil
        } else {
            // 첫 번째 선수 선택
            selectedPlayerView = selectedPlayer
            selectedPlayer.layer.shadowColor = UIColor.blue.cgColor
            selectedPlayer.layer.shadowRadius = 5.0
            selectedPlayer.layer.shadowOpacity = 0.8
            selectedPlayer.layer.shadowOffset = CGSize(width: 0, height: 0)
        }
    }
}

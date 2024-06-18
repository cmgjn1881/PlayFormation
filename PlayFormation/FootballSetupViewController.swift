import UIKit

class FootballSetupViewController: UIViewController {
    @IBOutlet weak var soccerFieldImageView: UIImageView!
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    
    var selectedPlayerView: PlayerView?
    var initialCenter: CGPoint?
    var playerViews: [PlayerView] = []
    let formationsKey = "savedFootballFormations"

    override func viewDidLoad() {
        super.viewDidLoad()
        soccerFieldImageView.isUserInteractionEnabled = true // 유저 상호작용 활성화
        //benchImageView.isUserInteractionEnabled = true // 벤치 이미지뷰 유저 상호작용 활성화
        contentView.isUserInteractionEnabled = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupFormation() // 화면구성이 끝난 후 포메이션 정리
        setupBenchPlayers() // 벤치 플레이어 추가
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Content Size 설정
        let contentWidth = scrollView.bounds.width * 2.2  // Content View의 실제 너비를 Scroll View의 두 배로 설정
        scrollView.contentSize = CGSize(width: contentWidth, height: scrollView.bounds.height)
    }
    
    private func setupFormation() {
        // 기존 플레이어 뷰 제거
        for playerView in playerViews {
            playerView.removeFromSuperview()
        }
        playerViews.removeAll()
        
        // 포메이션 설정
        let formationPositions: [(x: CGFloat, y: CGFloat, position: String)] = [
            // Goalkeeper
            (x: 0.5, y: 0.85, position: "GK"),
            // Defenders
            (x: 0.16, y: 0.67, position: "LB"),
            (x: 0.38, y: 0.67, position: "LCB"),
            (x: 0.62, y: 0.67, position: "RCB"),
            (x: 0.84, y: 0.67, position: "RB"),
            // Midfielders
            (x: 0.3, y: 0.4, position: "LCM"),
            (x: 0.5, y: 0.45, position: "CDM"),
            (x: 0.7, y: 0.4, position: "RCM"),
            // Forwards
            (x: 0.2, y: 0.2, position: "LW"),
            (x: 0.5, y: 0.15, position: "ST"),
            (x: 0.8, y: 0.2, position: "RW")
        ]
        
        for (index, position) in formationPositions.enumerated() {
            let playerView = PlayerView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
            playerView.configure(playerName: "Player \(index + 1)", playerNumber: "\(index + 1)", playerPosition: position.position)
            playerView.center = CGPoint(x: soccerFieldImageView.bounds.width * position.x, y: soccerFieldImageView.bounds.height * position.y)
            playerView.isUserInteractionEnabled = true  // 유저 상호작용 활성화
            playerView.delegate = self  // PlayerView에 delegate 설정
            
            // UIPanGestureRecognizer 추가
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            playerView.addGestureRecognizer(panGesture)
            
            // UITapGestureRecognizer 추가 (선수 클릭 시 정보 입력)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            playerView.addGestureRecognizer(tapGesture)
            
            soccerFieldImageView.addSubview(playerView)
            playerViews.append(playerView)
        }
    }
    
    private func setupBenchPlayers() {
        
        // 벤치에 플레이어 추가
        let benchPlayerPositions: [(x: CGFloat, y: CGFloat)] = [
                (x: 0.1, y: 0.5),
                (x: 0.4, y: 0.5),
                (x: 0.7, y: 0.5),
                (x: 1.0, y: 0.5),
                (x: 1.3, y: 0.5),
                (x: 1.6, y: 0.5),
                (x: 1.9, y: 0.5)
            ]
        
        for (index, position) in benchPlayerPositions.enumerated() {
            let playerView = PlayerView(frame: CGRect(x: 0, y: 0, width: 60, height: 60))
            playerView.configure(playerName: "Bench \(index + 1)", playerNumber: "\(index + 1)", playerPosition: "SUB")
            playerView.center = CGPoint(x: contentView.bounds.width * position.x, y: contentView.bounds.height * position.y)
            playerView.isUserInteractionEnabled = true  // 유저 상호작용 활성화
            playerView.delegate = self  // PlayerView에 delegate 설정
            
            // UIPanGestureRecognizer 추가
            let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
            playerView.addGestureRecognizer(panGesture)
            
            // UITapGestureRecognizer 추가 (선수 클릭 시 정보 입력)
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            playerView.addGestureRecognizer(tapGesture)
            
            contentView.addSubview(playerView)
            playerViews.append(playerView)
        }
    }

    
    @objc private func handlePan(_ gesture: UIPanGestureRecognizer) {
        guard let playerView = gesture.view as? PlayerView else { return }
        
        // benchImageView의 서브뷰인 경우 드래그 불가
            if playerView.superview == contentView {
                return
            }
        
        let translation = gesture.translation(in: view) // 전체 뷰에 대한 번역을 얻습니다.
        var newCenter = CGPoint(x: playerView.center.x + translation.x, y: playerView.center.y + translation.y)
        
        if playerView.superview == soccerFieldImageView {
            // 축구장 화면 밖으로 나가지 않도록 제약 추가
            let halfWidth = playerView.bounds.width / 2
            let halfHeight = playerView.bounds.height / 2
            
            // 축구장 경계 내에서만 움직이도록 제약 추가
            newCenter.x = max(halfWidth, min(soccerFieldImageView.bounds.width - halfWidth, newCenter.x))
            newCenter.y = max(halfHeight, min(soccerFieldImageView.bounds.height - halfHeight, newCenter.y))
        } else if playerView.superview == contentView {
            // 벤치 화면 밖으로 나가지 않도록 제약 추가
            let halfWidth = playerView.bounds.width / 2
            let halfHeight = playerView.bounds.height / 2
            
            // 벤치 경계 내에서만 움직이도록 제약 추가
            newCenter.x = max(halfWidth, min(contentView.bounds.width - halfWidth, newCenter.x))
            newCenter.y = max(halfHeight, min(contentView.bounds.height - halfHeight, newCenter.y))
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
            let superviewIdentifier = (playerView.superview == soccerFieldImageView) ? "soccerField" : "bench"
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
                
                if superviewIdentifier == "soccerField" {
                    soccerFieldImageView.addSubview(playerView)
                } else if superviewIdentifier == "bench" {
                    contentView.addSubview(playerView)
                }
                playerViews.append(playerView)
            }
        }
    }
    
    @IBAction func ResetButton(_ sender: Any) {
        let alertController = UIAlertController(title: nil, message: "포메이션을 리셋하시겠습니까?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title: "예", style: .default) { [weak self] _ in
            self?.setupFormation()
            self?.setupBenchPlayers()
            self?.showToast(message: "포메이션이 리셋되었습니다.")
        }
        let noAction = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        
        alertController.addAction(yesAction)
        alertController.addAction(noAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    @IBAction func Formation_InfButton(_ sender: Any) {
        let formationInfoVC = FormationInfoViewController()
        formationInfoVC.formations = formations
                
        let navController = UINavigationController(rootViewController: formationInfoVC)
                
        if #available(iOS 15.0, *) {
            if let sheet = navController.sheetPresentationController {
                sheet.detents = [.medium(), .large()] // 화면의 절반 정도로 설정
                sheet.prefersGrabberVisible = true // 사용자가 손잡이를 이용해 뷰를 끌어올릴 수 있게 함
            }
        }
        present(navController, animated: true, completion: nil)
    }
    
}

extension UIViewController {
    func showToast(message: String, duration: Double = 3.0) {
        let toastLabel = UILabel(frame: CGRect(x: self.view.frame.size.width/2 - 150, y: self.view.frame.size.height-100, width: 300, height: 35))
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 14)
        toastLabel.text = message
        toastLabel.alpha = 1.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds  =  true
        self.view.addSubview(toastLabel)
        UIView.animate(withDuration: duration, delay: 0.1, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

extension FootballSetupViewController: PlayerViewDelegate {
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


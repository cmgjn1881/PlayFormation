import UIKit

protocol PlayerViewDelegate: AnyObject {
    func handlePlayerSelection(_ selectedPlayer: PlayerView)
}

class PlayerView: UIView {
    var playerName: String = ""
    var playerNumber: String = ""
    var playerPosition: String = ""
    
    private let nameLabel = UILabel()
    private let numberLabel = UILabel()
    private let positionLabel = UILabel()
    private let iconImageView = UIImageView()
    private var isHighlighted = false
    var isSelected = false // 선택 상태 추가
    weak var delegate: PlayerViewDelegate? // delegate를 약한 참조로 추가
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        addPanGesture()
        addIconTapGesture()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
        addPanGesture()
        addIconTapGesture()
    }
    
    private func setupView() {
        // 티셔츠 이미지 설정
        let tshirtImageView = UIImageView(image: UIImage(named: "tshirtIcon"))
        tshirtImageView.contentMode = .scaleAspectFit
        tshirtImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        // 기존 사각형 배경 제거
        self.backgroundColor = .clear
        self.layer.borderWidth = 0
        
        nameLabel.textAlignment = .center
        numberLabel.textAlignment = .center
        positionLabel.textAlignment = .center
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.clipsToBounds = false
        iconImageView.image = UIImage(named: "swapIcon")

        let stackView = UIStackView(arrangedSubviews: [positionLabel, numberLabel, nameLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 15 // 각 필드 사이의 여백 설정
        stackView.translatesAutoresizingMaskIntoConstraints = false

        self.addSubview(tshirtImageView)
        self.addSubview(stackView)
        self.addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            tshirtImageView.topAnchor.constraint(equalTo: self.topAnchor),
            tshirtImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tshirtImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tshirtImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            stackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            
            iconImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: -10),
            iconImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    private func addPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        self.addGestureRecognizer(panGesture)
        self.isUserInteractionEnabled = true
    }
    
    private func addIconTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleIconTap))
        iconImageView.addGestureRecognizer(tapGesture)
        iconImageView.isUserInteractionEnabled = true
    }
    
    @objc private func handlePan(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.superview)
        if let view = gesture.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
        }
        gesture.setTranslation(.zero, in: self.superview)
    }
    
    @objc private func handleIconTap() {
        delegate?.handlePlayerSelection(self)
    }
    
    func configure(playerName: String, playerNumber: String, playerPosition: String) {
        self.playerName = playerName
        self.playerNumber = playerNumber
        self.playerPosition = playerPosition
        nameLabel.text = playerName
        numberLabel.text = playerNumber
        positionLabel.text = playerPosition
    }
}

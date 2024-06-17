//
//  FormationDetailViewController.swift
//  PlayFormation
//
//  Created by cmgjnmac on 6/17/24.
//

import UIKit

class FormationDetailViewController: UIViewController {

    var formation: Formation?

    private let scrollView = UIScrollView()
    private let contentView = UIView()

    private let advantagesLabel = UILabel()
    private let disadvantagesLabel = UILabel()
    private let suitableTeamsLabel = UILabel()
    private let exampleTeamsLabel = UILabel()
    private let keyplayerLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = formation?.name
        view.backgroundColor = .white
        setupScrollView()
        setupLabels()
        setupContent()
    }

    private func setupScrollView() {
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    private func setupLabels() {
        [advantagesLabel, disadvantagesLabel, suitableTeamsLabel, exampleTeamsLabel, keyplayerLabel].forEach {
            contentView.addSubview($0)
            $0.numberOfLines = 0
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    private func setupContent() {
        guard let formation = formation else { return }

        advantagesLabel.text = "장점:\n\(formation.advantages)"
        disadvantagesLabel.text = "단점:\n\(formation.disadvantages)"
        suitableTeamsLabel.text = "추천 팀:\n\(formation.suitableTeams)"
        exampleTeamsLabel.text = "예시 팀:\n\(formation.exampleTeams)"
        keyplayerLabel.text = "키플레이어:\n\(formation.keyplayer)"

        NSLayoutConstraint.activate([
            advantagesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            advantagesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            advantagesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            disadvantagesLabel.topAnchor.constraint(equalTo: advantagesLabel.bottomAnchor, constant: 20),
            disadvantagesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            disadvantagesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            suitableTeamsLabel.topAnchor.constraint(equalTo: disadvantagesLabel.bottomAnchor, constant: 20),
            suitableTeamsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            suitableTeamsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            exampleTeamsLabel.topAnchor.constraint(equalTo: suitableTeamsLabel.bottomAnchor, constant: 20),
            exampleTeamsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            exampleTeamsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            keyplayerLabel.topAnchor.constraint(equalTo: exampleTeamsLabel.bottomAnchor, constant: 20),
            keyplayerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            keyplayerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            keyplayerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
}


//
//  SelectionTableViewController.swift
//  SelectionTableViewSample
//
//  Created by Владислав Сизонов on 21.02.2023.
//

import UIKit

class SelectionTableViewController: UIViewController {
    
    // MARK: Private properties
    
    private lazy var data = [
        CellsDataModel.selectable(.init(title: "Blackberry", image: "blackberry", isSelected: true, isSelectionModeOn: isSelectionModeOn)),
        CellsDataModel.selectable(.init(title: "Blueberry", image: "blueberry", isSelected: true, isSelectionModeOn: isSelectionModeOn)),
        CellsDataModel.selectable(.init(title: "Cowberry", image: "cowberry", isSelected: true, isSelectionModeOn: isSelectionModeOn)),
        CellsDataModel.selectable(.init(title: "Grape", image: "grapes", isSelected: true, isSelectionModeOn: isSelectionModeOn)),
        CellsDataModel.selectable(.init(title: "Strawberry with a very long title", image: "strawberry", isSelected: true, isSelectionModeOn: isSelectionModeOn))
    ]
    
    private var selectedData = [CellsDataModel]()
    private var isSelectionModeOn = false
    
    private let listTableView: UITableView = {
        let listTableView = UITableView()
        listTableView.register(SelectableCell.self)
        listTableView.register(EmptyCell.self)
        listTableView.translatesAutoresizingMaskIntoConstraints = false
        return listTableView
    }()
    
    private lazy var tableViewDataSource = SelectableTableViewDataSource().makeDataSource(for: listTableView)
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        selectedData = data
        listTableView.delegate = self
        
        setupViews()
        updateTableView()
    }
    
    // MARK: Private
    
    private func setupViews() {
        view.addSubview(listTableView)
        NSLayoutConstraint.activate([
            listTableView.topAnchor.constraint(equalTo: view.topAnchor),
            listTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            listTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            listTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        ])
    }
    
    private func updateTableView() {
        for index in 0...selectedData.count - 1 {
            switch selectedData[index] {
            case .selectable(let model):
                selectedData[index] = CellsDataModel.selectable(.init(
                    title: model.title,
                    image: model.image,
                    isSelected: model.isSelected,
                    isSelectionModeOn: isSelectionModeOn
                ))
                
            case .empty:
                break
            }
        }
        var snapshot = NSDiffableDataSourceSnapshot<Int, CellsDataModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(selectedData, toSection: 0)
        tableViewDataSource.apply(snapshot, animatingDifferences: false)
        
        updateNavigationController()
    }
    
    private func updateNavigationController() {
        var counter = 0
        for item in selectedData {
            switch item {
            case .selectable(let model):
                if model.isSelected {
                    counter += 1
                }
                
            case .empty:
                break
            }
        }
        title = "Berries: \(counter)"
        navigationController?.navigationBar.prefersLargeTitles = true
        let buttonTitle: String
        if isSelectionModeOn {
            buttonTitle = "Stop"
        } else {
            buttonTitle = "Select"
        }
        let navButton = UIBarButtonItem(title: buttonTitle, style: .plain, target: self, action:#selector(tapNavButton))
        navigationItem.rightBarButtonItem = navButton
    }
    
    @objc func tapNavButton() {
        isSelectionModeOn.toggle()
        updateTableView()
    }
}

extension SelectionTableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let item = tableViewDataSource.itemIdentifier(for: indexPath) else { return }
        guard isSelectionModeOn else { return }
        
        switch item {
        case .selectable(let model):
            let isSelected = model.isSelected
            selectedData[indexPath.row] = CellsDataModel.selectable(.init(
                title: model.title,
                image: model.image,
                isSelected: !isSelected,
                isSelectionModeOn: isSelectionModeOn
            ))
            
            updateTableView()
            
        case .empty:
            break
        }
    }
}

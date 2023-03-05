//
//  SelectableTableViewDataSource.swift
//  SelectionTableViewSample
//
//  Created by Владислав Сизонов on 21.02.2023.
//

import UIKit

final class SelectableTableViewDataSource {
    
    // MARK: Public
    
    func makeDataSource(for tableview: UITableView) -> UITableViewDiffableDataSource<Int, CellsDataModel> {
        let tableViewDataSource = UITableViewDiffableDataSource<Int, CellsDataModel>(tableView: tableview) { tableView, indexPath, cellType in
            switch cellType {
            case .selectable(let model):
                let cell = tableview.reuse(SelectableCell.self, indexPath)
                let displayData = SelectableCell.DisplayData(
                    title: model.title,
                    image: model.image,
                    isSelected: model.isSelected,
                    isSelectionModeOn: model.isSelectionModeOn
                )
                cell.configure(with: displayData)
                return cell
                
            case .empty(let model):
                let cell = tableview.reuse(EmptyCell.self, indexPath)
                let displayData = EmptyCell.DisplayData(
                    title: model.title,
                    subtitle: model.subtitle,
                    icon: model.icon
                )
                cell.configure(with: displayData)
                return cell
            }
        }

        return tableViewDataSource
    }
}

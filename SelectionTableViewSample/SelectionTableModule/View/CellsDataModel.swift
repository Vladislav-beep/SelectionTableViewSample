//
//  CellsDataModel.swift
//  SelectionTableViewSample
//
//  Created by Владислав Сизонов on 21.02.2023.
//

enum CellsDataModel: Hashable {
    case selectable(SelectableCellDataModel)
    case empty(EmptyCellDataModel)
}

struct SelectableCellDataModel: Hashable {
    let title: String
    let image: String
    let isSelected: Bool
    let isSelectionModeOn: Bool
}

struct EmptyCellDataModel: Hashable {
    let title: String
    let subtitle: String
    let icon: String
}

//
//  BaseTableView.swift
//  Stories
//
//  Created by Abdullah on 09/02/2022.
//

import UIKit

class BaseTableViewCell: UITableViewCell,
                              UITextFieldDelegate {
    
    open func setup(){
        selectionStyle = .none
    }
    public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

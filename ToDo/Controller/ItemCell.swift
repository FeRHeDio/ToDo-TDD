//
//  ItemCell.swift
//  ToDo
//
//  Created by Fernando Putallaz on 28/05/2020.
//  Copyright © 2020 myOwn. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter
    }()
    
    func configCell(with item: ToDoItem, checked: Bool = false) {
        if checked {
            let attributedString = NSAttributedString(string: item.title, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
            titleLabel.attributedText = attributedString
            locationLabel.text = nil
            dateLabel.text = nil
        } else {
            titleLabel.text = item.title
            locationLabel.text = item.location?.name ?? ""
            if let timeStamp = item.timestamp {
                let date = Date(timeIntervalSince1970: timeStamp)
                dateLabel.text = dateFormatter.string(from: date)
            }
        }
    }
}

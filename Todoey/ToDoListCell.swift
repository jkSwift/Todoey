//
//  ToDoListCell.swift
//  Todoey
//
//  Created by John Kine on 2018-09-15.
//  Copyright © 2018 John Kine. All rights reserved.
//

import UIKit

class ToDoListCell: UITableViewCell {

    @IBOutlet weak var toDoListCellLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  HistoryTableViewCell.swift
//  ToDoListApp
//
//  Created by İbrahim Türk on 18.09.2023.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    @IBOutlet weak var labelInfo: UILabel!
    @IBOutlet weak var buttonTicOutlet: UIButton!
    @IBOutlet weak var buttonTrashOutlet: UIButton!
    @IBOutlet weak var labelDocumentId: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}

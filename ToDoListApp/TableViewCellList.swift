//
//  TableViewCellList.swift
//  ToDoListApp
//
//  Created by İbrahim Türk on 14.09.2023.
//

import UIKit
import Firebase
class TableViewCellList: UITableViewCell {

    @IBOutlet weak var labelDocumentId: UILabel!
    @IBOutlet weak var buttonOutletSelect: UIButton!
    @IBOutlet weak var labelInfo: UILabel!
    
    @IBOutlet weak var labelPriority: UILabel!
    @IBOutlet weak var colorCircle: UIColorWell!
    var tic = false
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    @IBAction func buttonSelect(_ sender: Any) {
        
        

        
    }
}

//
//  ResultTableViewCell.swift
//  newYorkTime
//
//  Created by javi on 02/02/2020.
//  Copyright © 2020 javiochoa. All rights reserved.
//

import UIKit
import Kingfisher

class ResultTableViewCell: UITableViewCell {

    @IBOutlet weak var publicationImage: UIImageView!
    @IBOutlet weak var publicationTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var sectionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func fill(withImageURL imageURL:String?,
              title:String?,
              author:String?,
              section:String?,
              date:String?) {
        
        if let imageURLString:String = imageURL, let url:URL = URL(string: imageURLString) {
            self.publicationImage.kf.setImage(with: url)
        }
        self.publicationTitleLabel.text = title ?? ""
        self.authorLabel.text = author ?? ""
        self.sectionLabel.text = section ?? ""
        self.dateLabel.text = date ?? ""
    }

}

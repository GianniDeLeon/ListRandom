//
//  MealTableViewCell.swift
//  ListRandom
//
//  Created by Gianni De Leon on 16/2/24.
//

import UIKit
import SDWebImage

class MealTableViewCell: UITableViewCell {

	@IBOutlet weak var imageUIImage: UIImageView!
	@IBOutlet weak var titleUILabel: UILabel!
	@IBOutlet weak var descriptionUILabel: UILabel!
	@IBOutlet weak var linkUILabel: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	
	func setImage(strMealThumb:String){
		guard let url = URL(string: strMealThumb)else{
			return
		}
		imageUIImage.sd_setImage(with: url)
	}
    
}

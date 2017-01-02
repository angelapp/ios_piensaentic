import UIKit

class SurveySelectionViewCell: UITableViewCell {
    
    @IBOutlet var radioButton:UIButton!
    @IBOutlet var titleLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(text: String) {
        radioButton.setBackgroundImage(UIImage(named:"unchecked"), for: UIControlState.normal)
        radioButton.setBackgroundImage(UIImage(named:"checked"), for: UIControlState.highlighted)
        radioButton.setBackgroundImage(UIImage(named:"checked"), for: UIControlState.selected)
        
        titleLabel.text = text
    }

}

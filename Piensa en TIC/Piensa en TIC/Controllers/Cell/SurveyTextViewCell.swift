import UIKit

class SurveyTextViewCell: UITableViewCell {
    
    @IBOutlet var titleLabel:UILabel!
    @IBOutlet var textView:UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(text:String) {
        titleLabel.text = text
    }

}

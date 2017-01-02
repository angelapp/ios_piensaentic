import UIKit

struct ResultConstants {
    static var left = " cartera: "
    static var right = " teléfono: "
}

class ResultsViewCell: UITableViewCell {
    @IBOutlet var resultLeft:UILabel!
    @IBOutlet var resultRight:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(_ leftResult: String, rightResult: String){
        resultLeft.text = "".concatenate(ResultConstants.left,leftResult)
        resultRight.text = "".concatenate(ResultConstants.right, rightResult)
    }

}

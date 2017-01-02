import UIKit

struct Identifier {
    static let selectionIdentifier = "surveySelectionIdentifier"
    static let inputIdentifier = "surveyInputIdentifier"
    static let resultIdentifier = "resultCell"
}

struct SurveyConstants {
    static let heightTitle:CGFloat = 78.0
}
// "0 a 5","Más de 5","Más de 20","Más de 100"
enum SurveyOptions: String {
    case first = "0 a 5"
    case second = "Más de 5"
    case third = "Más de 20"
    case fourth = "Más de 100"
}

class SurveyViewController: GeneralViewController {
    
    @IBOutlet var heightLabelConstraint:NSLayoutConstraint!
    @IBOutlet var titleLabel:UILabel!
    @IBOutlet var tableView:UITableView!
    @IBOutlet var topImage:UIImageView!
    var content:[[String:AnyObject]]!
    var results:[[Bool]]!
    var indexSelected:[IndexPath?]!
    var isWallet:Bool = true

    override func viewDidLoad() {
        super.viewDidLoad()

        indexSelected = [IndexPath!]()
        indexSelected.append(nil)
        indexSelected.append(nil)
        indexSelected.append(nil)
        indexSelected.append(nil)
        indexSelected.append(nil)
        results = [[Bool]]()
        content = [[String:AnyObject]]()
        
        
        if let image = self.info["top_image_name"] {
            topImage.image = UIImage(named:image)
        }
        
        if let title = self.info["title"] {
            heightLabelConstraint.constant = SurveyConstants.heightTitle
            titleLabel.text = title
            isWallet = false
        } else {
            heightLabelConstraint.constant = 0
        }
        
        appendWalletInformation()
        fillWithData()
    }
    
    func appendWalletInformation(){
        content.append(["section":"Fotografías de mis amigos" as AnyObject, "options":["0 a 5","Más de 5","Más de 20","Más de 100"] as AnyObject])
        results.append([true,false,false,false])
//        updateState(indexPath: IndexPath(row:0,section:0), value: true)
        content.append(["section":"Mis fotografías" as AnyObject, "options":["0 a 5","Más de 5","Más de 20","Más de 100"] as AnyObject])
        results.append([true,false,false,false])
//        updateState(indexPath: IndexPath(row:0,section:1), value: true)
        content.append(["section":"Datos de identificación" as AnyObject, "options":["0 a 5","Más de 5","Más de 20","Más de 100"] as AnyObject])
        results.append([true,false,false,false])
//        updateState(indexPath: IndexPath(row:0,section:2), value: true)
        content.append(["section":"Teléfonos y datos de contacto de familia y amigos" as AnyObject, "options":["0 a 5","Más de 5","Más de 20","Más de 100"] as AnyObject])
        results.append([true,false,false,false])
//        updateState(indexPath: IndexPath(row:0,section:3), value: true)
        content.append(["section":"Dinero o tarjetas de banco (miles de pesos)" as AnyObject, "options":["0 a 5","Más de 5","Más de 20","Más de 100"] as AnyObject])
        results.append([true,false,false,false])
//        updateState(indexPath: IndexPath(row:0,section:4), value: true)
        content.append(["section":"¿Qué más tienes?" as AnyObject, "text":true as AnyObject])
    }
    
    func fillWithData() {
        
        for section in 0..<content.count {
            let dic = content[section]
            
            guard let sectionContent = dic as [String:Any]! else { continue}
            if let _ = sectionContent["options"] as! [String]! {
                let key = "".concatenate(sectionContent["section"] as! String!, (isWallet ? "Cartera":"Telefono"))
                guard let result = storage.getStringFromKey(key: key) else {continue}
                var index = 0
                switch result {
                    case SurveyOptions.first.rawValue:
                        index = 0
                        break
                    case SurveyOptions.second.rawValue:
                        index = 1
                        break
                    case SurveyOptions.third.rawValue:
                        index = 2
                        break
                    case SurveyOptions.fourth.rawValue:
                        index = 3
                        break
                    default: break
                }
                resetAllResults(index: section)
                updateState(indexPath: IndexPath(row: index, section: section), value: true)
            }
        }
        
        tableView.reloadData()
    }
    
    func resetAllResults(index: Int) {
        for idx in 0..<results[index].count {
            results[index][idx] = false
        }
    }
    
    func changeValue(section:Int, index: Int){
        results[section][index] = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension SurveyViewController: UITableViewDelegate {
    func updateState(indexPath:IndexPath, value:Bool){
        indexSelected[indexPath.section] = indexPath
        results[indexPath.section][indexPath.row] = value
        guard let sectionContent = content[indexPath.section] as [String:Any]! else { tableView.reloadData(); return}
        if let options = sectionContent["options"] as! [String]! {
            let key = "".concatenate(sectionContent["section"] as! String!, (isWallet ? "Cartera":"Telefono"))
            storage.saveOptionChosen(key: key, value: options[indexPath.row])
        } else {
            guard let userInput = getInformationFromTextView(indexPath: indexPath) else { tableView.reloadData(); return}
            let key = "".concatenate(sectionContent["section"] as! String!, (isWallet ? "Cartera":"Telefono"))
            storage.saveOptionChosen(key: key, value: userInput)
        }
        tableView.reloadData()
    }
    
    func getInformationFromTextView(indexPath:IndexPath) -> String! {
        guard let cell = tableView.cellForRow(at: indexPath) as! SurveyTextViewCell! else { return nil}
        return cell.textView.text
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexSelected[indexPath.section] != nil {
            updateState(indexPath: indexSelected[indexPath.section]!, value:false)
        }
        
        updateState(indexPath: indexPath, value:true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == content.count - 1{
            return 140.0
        }
        
        return 50.0
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame:CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height: 40.0))
        let title = UILabel(frame: CGRect(x: 20, y: 0, width: header.frame.size.width-20, height: 40))
        let sectionContent = content[section]
        guard let text = sectionContent["section"] as! String! else{
            return header
        }
        
        title.font = UIFont(name: "HelveticaNeue-Medium", size: 15.0)
        title.text = text
        title.textColor = UIColor.white
        header.backgroundColor = UIColor.clear
        title.backgroundColor = UIColor.clear
        header.addSubview(title)
        
        return header
    }
}

extension SurveyViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == content.count - 1{
            return 1
        }
        let sectionContent = content[section]
        if let options = sectionContent["options"] as! [String]!  {
            return options.count
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == content.count - 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.inputIdentifier, for: indexPath) as! SurveyTextViewCell
            
            guard let sectionContent = content[indexPath.section] as [String:Any]! else { return cell}
            let key = "".concatenate(sectionContent["section"] as! String!, (isWallet ? "Cartera":"Telefono"))
            let result = storage.getStringFromKey(key: key)
            cell.textView.text = result
            cell.textView.delegate = self
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.selectionIdentifier, for: indexPath) as! SurveySelectionViewCell
        guard let sectionContent = content[indexPath.section] as [String:Any]! else { return cell}
        
        guard let options = sectionContent["options"] as! [String]! else {
            return cell
        }
        
        cell.configureCell(text: options[indexPath.row])
        cell.radioButton.isSelected = results[indexPath.section][indexPath.row]
        
        return cell
    }
}

extension SurveyViewController: UITextViewDelegate {
    func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        let section = content.count - 1
        guard let sectionContent = content[section] as [String:Any]! else { return true}
        let key = "".concatenate(sectionContent["section"] as! String!, (isWallet ? "Cartera":"Telefono"))
        storage.saveOptionChosen(key: key, value: textView.text)
        return true
    }
}

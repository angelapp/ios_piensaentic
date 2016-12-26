import UIKit

class ResultsSurveyViewController: GeneralViewController {
    @IBOutlet var topImage:UIImageView!
    @IBOutlet var tableView:UITableView!
    var content:[[String:Any]]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let image = self.info["top_image_name"] {
            topImage.image = UIImage(named:image)
        }
        fillWithInformation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fillWithInformation(){
        content = [[String:Any]]()
        let sectionTitle1 = "Fotografías de mis amigos"
        content.append(["section":sectionTitle1 as AnyObject, "left": storage.getStringFromKey(key: "".concatenate(sectionTitle1,"Cartera")), "right":storage.getStringFromKey(key: "".concatenate(sectionTitle1,"Telefono"))])
        
        let sectionTitle2 = "Mis fotografías"
        content.append(["section":sectionTitle2 as AnyObject, "left": storage.getStringFromKey(key: "".concatenate(sectionTitle2,"Cartera")), "right":storage.getStringFromKey(key: "".concatenate(sectionTitle2,"Telefono"))])
        
        let sectionTitle3 = "Datos de identificación"
        content.append(["section":sectionTitle3 as AnyObject, "left": storage.getStringFromKey(key: "".concatenate(sectionTitle3,"Cartera")), "right":storage.getStringFromKey(key: "".concatenate(sectionTitle3,"Telefono"))])
        
        let sectionTitle4 = "Teléfonos y datos de contacto de familia y amigos"
        content.append(["section":sectionTitle4 as AnyObject, "left": storage.getStringFromKey(key: "".concatenate(sectionTitle4,"Cartera")), "right":storage.getStringFromKey(key: "".concatenate(sectionTitle4,"Telefono"))])
        
        let sectionTitle5 = "Dinero o tarjetas de banco (miles de pesos)"
        content.append(["section":sectionTitle5 as AnyObject, "left": storage.getStringFromKey(key: "".concatenate(sectionTitle5,"Cartera")), "right":storage.getStringFromKey(key: "".concatenate(sectionTitle5,"Telefono"))])
        
        tableView.reloadData()
    }
}

extension ResultsSurveyViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55.0
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.resultIdentifier, for: indexPath) as! ResultsViewCell
        
        guard let sectionContent = content[indexPath.section] as [String:Any]! else { return cell}
        
        cell.configureCell(sectionContent["left"] as! String, rightResult: sectionContent["right"] as! String)
        
        return cell
    }
}


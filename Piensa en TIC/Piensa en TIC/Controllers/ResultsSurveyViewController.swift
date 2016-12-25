import UIKit

class ResultsSurveyViewController: GeneralViewController {
    
    @IBOutlet var tableView:UITableView!
    var content:[[String:Any]]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fillWithInformation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fillWithInformation(){
        content = [[String:Any]]()
        
        content.append(["section":"Fotografías de mis amigos" as AnyObject, "left": storage.getStringFromKey(key: "".concatenate("Fotografías de mis amigos","Cartera")), "right":storage.getStringFromKey(key: "".concatenate("Fotografías de mis amigos","Cartera"))])
        
        
        content.append(["section":"Mis fotografías" as AnyObject, "left": storage.getStringFromKey(key: "".concatenate("Fotografías de mis amigos","Cartera")), "right":storage.getStringFromKey(key: "".concatenate("Fotografías de mis amigos","Cartera"))])
        
        content.append(["section":"Datos de identificación" as AnyObject, "left": storage.getStringFromKey(key: "".concatenate("Fotografías de mis amigos","Cartera")), "right":storage.getStringFromKey(key: "".concatenate("Fotografías de mis amigos","Cartera"))])
        
        content.append(["section":"Teléfonos y datos de contacto de familia y amigos" as AnyObject, "left": storage.getStringFromKey(key: "".concatenate("Fotografías de mis amigos","Cartera")), "right":storage.getStringFromKey(key: "".concatenate("Fotografías de mis amigos","Cartera"))])
        
        content.append(["section":"Dinero o tarjetas de banco (miles de pesos)" as AnyObject, "left": storage.getStringFromKey(key: "".concatenate("Fotografías de mis amigos","Cartera")), "right":storage.getStringFromKey(key: "".concatenate("Fotografías de mis amigos","Cartera"))])
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


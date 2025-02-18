//
//  historyViewController.swift
//  Talk Time Saver V3-B2
//
//  Created by user941142 on 2/14/25.
//

class historyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    private let timeSaver = TimeSaver();

    @IBOutlet weak var menu_bttn: UIBarButtonItem!
    var history_from_defaults = [String]()
    var ids_from_default = [String]()
    
    
    @IBOutlet weak var history_table: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return history_from_defaults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = history_table.dequeueReusableCell(withIdentifier: "cell2")!
        let row = indexPath.row
        cell.textLabel?.text = history_from_defaults[row].replacingOccurrences(of: " +0000", with: "")
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard!.instantiateViewController(withIdentifier: "timeHistory") as! historydetailViewController
        let nc = UINavigationController(rootViewController: vc)
        vc.key = UserDefaults.standard.string(forKey:  ids_from_default[indexPath.row])!
    
        self.present(nc, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu_clicked_class()
        var savedRecords = timeSaver.loadTimeRecords()
        for record in savedRecords {
            history_from_defaults.append("\(record.savedDate) - \(record.combinedTime) - \(record.id)")
            ids_from_default.append(record.id)
        }
        
        
        
        self.history_table.dataSource = self
        self.history_table.delegate = self
   
    }
    
    
    func menu_clicked_class() {
        menu_bttn.target = revealViewController()
        menu_bttn.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
}

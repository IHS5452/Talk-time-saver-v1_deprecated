//
//  historydetailViewController.swift
//  Talk Time Saver V3-B2
//
//  Created by user941142 on 2/14/25.
//

class historydetailViewController: UIViewController {

    private let timeSaver = TimeSaver();
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var total: UILabel!
    var key = ""
    
    var combindedTimes = [String]()
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var records = timeSaver.loadTimeRecord(by: key)!
        
       
        total.text = records.combinedTime
        
        let formatter1 = DateFormatter()
        formatter1.dateStyle = .short
        date.text = formatter1.string(from: records.savedDate)
        
        
        for r in records.times {
            combindedTimes.append(r)
        }
   
        
    }
}

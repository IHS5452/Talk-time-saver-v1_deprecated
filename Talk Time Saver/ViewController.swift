//
//  ViewController.swift
//  Talk Time
//
//  Created by Ian Schrauth on 9/26/20.
//

import UIKit
import GoogleMobileAds

extension UIViewController
{
    func setupToHideKeyboardOnTapOnView()
    {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(UIViewController.dismissKeyboard))

        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard()
    {
        view.endEditing(true)
    }
}


class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate,  UITextFieldDelegate, GADBannerViewDelegate {
    
    var bannerView: GADBannerView!

    
    @IBOutlet weak var startTimer: UIButton!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var hoursTXTField: UITextField!
    @IBOutlet weak var minTXTField: UITextField!
    @IBOutlet weak var secTXTField: UITextField!
    
    @IBOutlet weak var time_label: UILabel!
    @IBOutlet weak var regsiter: UIBarButtonItem!
    @IBOutlet weak var showHistory: UIBarButtonItem!
 
    var output_string = ""

    

    var totalString = ""


    
    
    let date = Date()
    let formatter = DateFormatter()

    var counter = 0.0
    var timer = Timer()
    var isPlaying = false
    var start_stop_indicator = "Start"
    
    @IBAction func start_stop_timer(_ sender: UIButton) {
        if (start_stop_indicator == "Start") {
            start_timer()
            start_stop_indicator = "Stop"
            print(start_stop_indicator)
        } else if (start_stop_indicator == "Stop"){
       

            
            
            pauseTimer()

            saveTimeToOutput()
            resetTimer()
            start_stop_indicator = "Start"
            print(start_stop_indicator)

        }
        
    }
    
     func start_timer() {
        if(isPlaying) {
            return
        }
     
            
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(UpdateTimer), userInfo: nil, repeats: true)
        isPlaying = true
    }
        
     func pauseTimer() {
    
            
        timer.invalidate()
         
        isPlaying = false
    }

     func resetTimer() {
      
            
        timer.invalidate()
        isPlaying = false
        counter = 0.0
        time_label.text = String(counter)
    }
    
    @objc func UpdateTimer() {
        counter = counter + 0.1
        time_label.text = SecToFullTime(seconds: Int(counter))
    }
    
    
    func saveTimeToOutput() {
        
        
        
        let tm = time()
        let timeActions = actions()
        

        
        
        timeActions.saveToArray(h_m_s: "h")
        timeActions.saveToArray(h_m_s: "m")
        timeActions.saveToArray(h_m_s: "s")


         totalTimeLabel.text = "\(String(format: "%02d", tm.getHour())):\(String(format: "%02d", tm.getMin())):\(String(format: "%02d", tm.getSec()))"

        self.table.reloadData()
        
        
   
        
        
    }
    
    
    
    
    
//    @IBAction func testing_button(_ sender: UIButton) {
//
//
//        savetoOutput(hour: 0, min: 11, sec: 11)
//
//
//
//
//
//    }
//
    
    

    
    
    
func SecToFullTime (seconds : Int) -> String {
    
    let hour = seconds / 3600
    let min = seconds % 3600 / 60
    let sec = seconds % 3600 % 60
    let tm = time()
    
    tm.setHour(input: hour)
    tm.setMin(input: min)
    tm.setSec(input: sec)
    
    
    print("\(tm.getHour()):\(tm.getMin()):\(tm.getSec())")
    return "\(tm.getHour()):\(tm.getMin()):\(tm.getSec())"
    
}
    
    
    
    
    
//    func returnTimeFromString(inputTime: String, partOfArray: Int)  -> Int {
//        var split_input = inputTime.split(separator: ":")
//        print("time from array: \(split_input[partOfArray])")
//        return Int(split_input[partOfArray])!
//
//
//    }
    
  
    
    
    func hourFromBigString(bigString: String) -> Int {
        let split_input = bigString.split(separator: ":")
               print("time from array: \(split_input[0])")
        return Int(split_input[0])!
    }
   
    
    func minFromBigString(bigString: String) -> Int {
        let split_input = bigString.split(separator: ":")
       print("time from array: \(split_input[1])")
       return Int(split_input[1])!
    }
    
    func secFromBigString(bigString: String)  -> Int {
        let split_input = bigString.split(separator: ":")
       print("time from array: \(split_input[2])")
       return Int(split_input[2])!
    }
    
    
    
    
    @IBAction func saveAllTimes(_ sender: UIButton) {
       
        do {
            
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "MM-dd-yyyy"
            let todaysDate = formatter.string(from: date)
            let calendar = Calendar.current

            let hour = calendar.component(.hour, from: date)
            let minutes = calendar.component(.minute, from: date)
            let seconds = calendar.component(.second, from: date)
            
            
            print(todaysDate)
            
            
            var tm = time()
            var fileClass = file()
            let defaults = UserDefaults.standard
            let auth_token = defaults.string(forKey: "authd")
            let ID = defaults.string(forKey: "pin_user_created")

            var filename = "\(ID!) - \(todaysDate) at \(hour)-\(minutes)"
            
            
            if (auth_token == "false") {
               //NOTE: Show Authenticate Pop up
                showAuthPopup()
                
                
            } else {
            
                if (tm.getHourArray().count <= 0) {
                    let alert = UIAlertController(title: "Error", message: "Something went wrong! Please try again!", preferredStyle: .alert)
                           alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                       
                           self.present(alert, animated: true)
                } else {
                    var i = 0
                    for i in 0...tm.getHourArray().count-1{
                            output_string += "\(tm.getHourArrayAt(atPosition: i)):\(tm.getMinArrayAt(atPosition: i)):\(tm.getSecArrayAt(atPosition: i)),"
                    }
                    
                   
                    fileClass.write(fileName: filename, content: output_string)
                    fileClass.read(fileName: filename)
                   
                    
                    let alert = UIAlertController(title: "Complete", message:"Times saved!", preferredStyle: .alert)
                           alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                       
                           self.present(alert, animated: true)
                    clear()
                }
                        
              

       }
        } catch  {
            let alert = UIAlertController(title: "Error", message: "Something went wrong! Please try again!", preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
               
                   self.present(alert, animated: true)
        }
        
        
     
    }
    func clear() {
        var t = time()
        t.clearHourArray()
        t.clearMinArray()
        t.clearSecArray()
        self.table.reloadData()
    }
        

    @IBAction func change_PIN(_ sender: UIBarButtonItem) {
        
        showCreateAPINPopup()
        
        
    }
    
    
    
    



    @IBAction func showHistory(_ sender: UIBarButtonItem) {
        
        _ = easySwiftAPI()
        
        let defaults = UserDefaults.standard
        let emailToken = defaults.string(forKey: "authd")
        
        if (emailToken == "false") {
            //NOTE: Show Authenticate Pop up
            showAuthPopup()
        } else {
            
            let vc = self.storyboard!.instantiateViewController(withIdentifier: "SPH") as! ShowPastRecordsViewController
            let nc = UINavigationController(rootViewController: vc)
            self.present(nc, animated: true, completion: nil)
        }
        
        
    }
    


    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var tm = time()
        return time.hoursWorked.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tm = time()
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let text = "\(time.hoursWorked[indexPath.row]):\(time.minWorked[indexPath.row]):\(time.secWorked[indexPath.row])"
        
        cell.textLabel?.text = text
        
      
        return cell
    }

    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var tm = time()
                var timeActions = actions()
            time.hoursWorked.remove(at: indexPath.row)
            time.minWorked.remove(at: indexPath.row)
            time.secWorked.remove(at: indexPath.row)
            
            
          
            timeActions.getTotalTime(array: time.hoursWorked, timeType: "h")
            timeActions.getTotalTime(array: time.minWorked, timeType: "m")
            timeActions.getTotalTime(array: time.secWorked, timeType: "s")
 

           
            totalTimeLabel.text = "\(String(format: "%02d", tm.getHour())):\(String(format: "%02d", tm.getMin())):\(String(format: "%02d", tm.getSec()))"

            self.table.reloadData()


            
        } else if editingStyle == .insert {

        }
    }


    
    


    
    @objc func loadList(notification: NSNotification){
        var timeActions = actions()
        var tm = time()

        timeActions.getTotalTime(array: time.hoursWorked, timeType: "h")
        timeActions.getTotalTime(array: time.minWorked, timeType: "m")
        timeActions.getTotalTime(array: time.secWorked, timeType: "s")


       
        totalTimeLabel.text = "\(String(format: "%02d", tm.getHour())):\(String(format: "%02d", tm.getMin())):\(String(format: "%02d", tm.getSec()))"

        self.table.reloadData()
    }
     



    
    
    


override func viewDidLoad() {
    super.viewDidLoad()
    var _: UINavigationController!
    var _: ViewController!
    // In this case, we instantiate the banner with desired ad size.
       bannerView = GADBannerView(adSize: kGADAdSizeBanner)

       addBannerViewToView(bannerView)
     

     func addBannerViewToView(_ bannerView: GADBannerView) {
       bannerView.translatesAutoresizingMaskIntoConstraints = false
       view.addSubview(bannerView)
       view.addConstraints(
         [NSLayoutConstraint(item: bannerView,
                             attribute: .bottom,
                             relatedBy: .equal,
                             toItem: bottomLayoutGuide,
                             attribute: .top,
                             multiplier: 1,
                             constant: 0),
          NSLayoutConstraint(item: bannerView,
                             attribute: .centerX,
                             relatedBy: .equal,
                             toItem: view,
                             attribute: .centerX,
                             multiplier: 1,
                             constant: 0)
         ])
      }
    
    
    bannerView.adUnitID = "ca-app-pub-9400593844053407/9273987078"
      bannerView.rootViewController = self
    bannerView.load(GADRequest())
    bannerView.delegate = self


    NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
 
  
  

    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))

    view.addGestureRecognizer(tap)
    
    let defaults = UserDefaults.standard
    var authented = defaults.string(forKey: "authd")
    let did_create_pin = defaults.string(forKey: "did_create_pin")
    
    
    
    
    print()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
        if did_create_pin == "false" {
            print("Showing create a pin pop-up")
            self.showCreateAPINPopup()
        } else if authented == "false" {
            self.showAuthPopup()
        }
//
//        if emailToken == "false" {
//            print("Showing pop-up")
//            self.showAuthPopup()
//        }
}
    
    func relodaTableview() {
        self.table.reloadData()
    }
    
    


    
}

  
    @objc override func dismissKeyboard() {
     //Causes the view (or one of its embedded text fields) to resign the first responder status.
     view.endEditing(true)
    }
    

    @IBAction func enter_cust_time_clicked(_ sender: UIBarButtonItem) {
        showCustumTimesView()
        
    }

    @objc func showAuthPopup() {
        let slideVC = OverlayView()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
    
    @objc func showCustumTimesView() {
        let slideVC = ECTView()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
    
    @objc func showCreateAPINPopup() {
        let slideVC = CAPView()
        slideVC.modalPresentationStyle = .custom
        slideVC.transitioningDelegate = self
        self.present(slideVC, animated: true, completion: nil)
    }
    
    
 }

extension ViewController: UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        PresentationController(presentedViewController: presented, presenting: presenting)
    }

}



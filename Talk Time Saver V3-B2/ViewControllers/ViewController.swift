//
//  ViewController.swift
//  Talk Time Saver V3-B2
//
//  Created by user941142 on 2/14/25.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var times_table: UITableView!
    
    var times = [String()]
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return times.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = times_table.dequeueReusableCell(withIdentifier: "cell") as! UITableViewCell
        let row = indexPath.row
        cell.textLabel?.text = times[row]
        
        return cell
    }
    
    @IBAction func menu_clicked(_ sender: Any) {
        
        menu_clicked_class()

    }
    @IBAction func save_history(_ sender: UIButton) {
        timeSaver.saveTimeRecord(times: times, combinedTime: total_time.text!)
        times = []
        self.times_table.reloadData()
        total_time.text = "00:00"
        
        
        
        
        
    }
    
    
    @IBOutlet weak var timerLbl: UILabel!

    @IBOutlet weak var start_stop_bttn: UIButton!
    
    @IBOutlet weak var menu_bttn: UIBarButtonItem!
    @IBOutlet weak var total_time: UILabel!
    private let timeSaver = TimeSaver()
    private let timerManager = TimerManager()
       
       override func viewDidLoad() {
           super.viewDidLoad()
           menu_clicked_class()
           
           self.times_table.dataSource = self
           self.times_table.delegate = self
           
           timerManager.timeUpdateHandler = { [weak self] time in
               self?.timerLbl.text = time
           }
       }
       
        
    @IBAction func start_stop_bttn(_ sender: UIButton) {
        
        if (start_stop_bttn.titleLabel!.text == "Start") {
            timerManager.startTimer()
            start_stop_bttn.setTitle("Stop and Record", for: .normal)
        } else if (start_stop_bttn.titleLabel!.text == "Stop and Record") {
            times.append(timerLbl.text!)
            self.times_table.reloadData()
            timerManager.stopTimer();
            total_time.text = totalTime(from: times)

            start_stop_bttn.setTitle("Start", for: .normal)
        }
       
        

        
    }
    
    
    
    
    
       @IBAction func startButtonTapped(_ sender: UIButton) {
           timerManager.startTimer()
       }
       
       @IBAction func pauseButtonTapped(_ sender: UIButton) {
           timerManager.pauseTimer()
       }
       
       @IBAction func stopButtonTapped(_ sender: UIButton) {
           timerManager.stopTimer()
       }
       
       @IBAction func resetButtonTapped(_ sender: UIButton) {
           timerManager.resetTimer()
       }
    private func formatTime(_ totalSeconds: Int) -> String {
           let minutes = totalSeconds / 60
           let seconds = totalSeconds % 60
           return String(format: "%02d:%02d", minutes, seconds)
       }
    
    func totalTime(from timeArray: [String]) -> String {
            var totalSeconds = 0
            
            for time in timeArray {
                let components = time.split(separator: ":")
                if components.count == 2,
                   let minutes = Int(components[0]),
                   let seconds = Int(components[1]) {
                    totalSeconds += (minutes * 60) + seconds
                }
            }
            
            return formatTime(totalSeconds)
        }
    
    func menu_clicked_class() {
        menu_bttn.target = revealViewController()
        menu_bttn.action = #selector(SWRevealViewController.revealToggle(_:))
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
   }

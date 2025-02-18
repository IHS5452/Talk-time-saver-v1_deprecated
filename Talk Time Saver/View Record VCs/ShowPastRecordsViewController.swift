//
//  ViewController.swift
//  Talk Time
//
//  Created by Ian Schrauth on 9/26/20.
//

import UIKit



class ShowPastRecordsViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    

    var retrevedHoursWorked = [String]()
    
    @IBOutlet weak var table: UITableView!
    
    
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        
        let documentDirectoryPath:String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let myFilesPath = "\(documentDirectoryPath)"
        let filemanager = FileManager.default
        let files = filemanager.enumerator(atPath: myFilesPath)
        while let file = files?.nextObject() {
            var file2 = (file as! String).replacingOccurrences(of: ".txt", with: "")
            self.retrevedHoursWorked.append(file2)
            
        }
        
        
        
        
//        var ref = Database.database().reference()
//        let defaults = UserDefaults.standard
//        let emailToken = defaults.string(forKey: "email")
//        var emailReplacementChars1 = emailToken!.replacingOccurrences(of: "@", with: "(at)")
//        var emailReplacementChars2 = emailReplacementChars1.replacingOccurrences(of: ".", with: "(dot)")
//
//        ref.child("users").child(emailReplacementChars2).child("datesEnt").observeSingleEvent(of: .value, with: { (snapshot) in
//            let value = snapshot.value as? NSDictionary
//
//            for child in snapshot.children {
////                    let snap = child as! DataSnapshot
////                    let song = snap.key
//                self.retrevedHoursWorked.append((child as AnyObject).key)
//            }
//
//            self.table.reloadData()
//            print("Aray has this in it: \(self.retrevedHoursWorked)")
//
//        })

    }
    static func fileNames(nameDirectory: String, extensionWanted: String) -> String {

        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let Path = documentURL.appendingPathComponent(nameDirectory).absoluteURL

        do {
            try FileManager.default.createDirectory(atPath: Path.relativePath, withIntermediateDirectories: true)
            // Get the directory contents urls (including subfolders urls)
            let directoryContents = try FileManager.default.contentsOfDirectory(at: Path, includingPropertiesForKeys: nil, options: [])

            // if you want to filter the directory contents you can do like this:
            let FilesPath = directoryContents.filter{ $0.pathExtension == extensionWanted }
            let FileNames = FilesPath.map{ $0.deletingPathExtension().lastPathComponent }

            return "\(FileNames)"
        } catch {
            print(error.localizedDescription)
        }
        return ""

    }
    
    
    
    
    @objc override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return retrevedHoursWorked.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let text = retrevedHoursWorked[indexPath.row]
        
        cell.textLabel?.text = text
        
      
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        let vc = storyboard!.instantiateViewController(withIdentifier: "shiftHistory") as! historyViewController
        let nc = UINavigationController(rootViewController: vc)
        vc.date = retrevedHoursWorked[indexPath.row]
        self.present(nc, animated: true, completion: nil)


    }
    
}


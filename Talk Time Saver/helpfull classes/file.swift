//
//  saving.swift
//  Talk Time Saver
//
//  Created by Ian Schrauth on 7/4/21.
//

import Foundation


class file {
    
    public func write(fileName: String, content: String){
        let file = "\(fileName).txt" //this is the file. we will write to and read from it

        let text = content //just a text

        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

            let fileURL = dir.appendingPathComponent(file)

            //writing
            do {
                try text.write(to: fileURL, atomically: false, encoding: .utf8)
                print("Write sucesfull. Wrote to \(fileURL)")
            }
            catch {
            print("Error writing file.")
            }

            //reading
//            do {
//                let text2 = try String(contentsOf: fileURL, encoding: .utf8)
//            }
//            catch {/* error handling here */}
        }
    }
    
    public func read(fileName: String) -> String{
        let file = "\(fileName).txt" //this is the file. we will write to and read from it


        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {

            let fileURL = dir.appendingPathComponent(file)

     

            //reading
            do {
                let text2 = try String(contentsOf: fileURL, encoding: .utf8)
                print("read sucesfull. here is the tect: \n\n \(text2)")
                return text2
            }
            catch {
                print("Error reading file.")

            }
        }
        return "Error Reading file"
    }
    

}

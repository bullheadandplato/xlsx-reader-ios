//
//  DataHandler.swift
//  IosGoogling
//
//  Created by Osama Bin Omar on 9/23/17.
//  Copyright © 2017 Osama Bin Omar. All rights reserved.
//

import Foundation
class DataHandler {
    public static func loadData(completion:@escaping ([String])->()){
        let url=NSURL.init(string: CommonConstants.URL);
        if let dir=FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
        
            let outPath=dir.appendingPathComponent(CommonConstants.FILENAME);
           
            // delete file if exists
            if(FileManager.default.fileExists(atPath: outPath.path)){
                do {
                    try FileManager.default.removeItem(atPath: outPath.path)
                }catch{
                    print("unable to delete file.")
                }
            }
            //download file
            Downloader.load(url: url! as URL, to: outPath, completion: {
                let spreadsheet: BRAOfficeDocumentPackage = BRAOfficeDocumentPackage.open(outPath.path)
                let workSheet : BRAWorksheet=spreadsheet.workbook.worksheets?[0] as! BRAWorksheet;
                var temp:[String]=[String()];
                
                for row in workSheet.rows as! [BRARow]{
                    let cell:BRACell=row.cells?[0] as! BRACell
                    if(cell.stringValue()=="C"){
                        let cell1:BRACell=row.cells?[1] as! BRACell
                        temp+=[cell1.stringValue()]
                        
                    }
                }
                temp.remove(at: 0)
                completion(temp)
                
            })
        }
    }
    
    //load data for second screen
    public static func loadDetailData(title:String,completion:([String:String])->()){
        if let dir=FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            
            let outPath=dir.appendingPathComponent(CommonConstants.FILENAME);
            let spreadsheet: BRAOfficeDocumentPackage = BRAOfficeDocumentPackage.open(outPath.path)
            let workSheet : BRAWorksheet=spreadsheet.workbook.worksheets?[0] as! BRAWorksheet;
            var temp:[String:String]=[String():String()];
            var innerCalled=false
            for row in workSheet.rows as! [BRARow]{
                let capability:BRACell=row.cells?[1] as! BRACell
                let val=capability.stringValue()!
           
                if (val==title){
                    let rowIndex=capability.rowIndex()
                    for i in rowIndex...workSheet.rows.count{
                        let innerRow=workSheet.rows?[i] as! BRARow
                        let typeCell=innerRow.cells?[0] as! BRACell
                        innerCalled=true
                        if(typeCell.stringValue()=="C"){
                            break
                        }else{
                            let nameCell=innerRow.cells?[1] as! BRACell
                            let e3=innerRow.cells?[2] as! BRACell
                            let e5=innerRow.cells?[3] as! BRACell
                            var description=""
                            if(e3.stringValue() != nil){
                                description=e3.stringValue()+" and "+e5.stringValue()
                            }else{
                                description=e5.stringValue()
                            }
                            temp.updateValue(description, forKey: nameCell.stringValue()!)
                        }
                    }
                    if(innerCalled){
                        completion(temp)
                        break
                    }
                }
             
            }
        }
    }
    
    

class Downloader {
    class func load(url: URL, to localUrl: URL, completion: @escaping () -> ()) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = try! URLRequest(url: url)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let tempLocalUrl = tempLocalUrl, error == nil {
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Success: \(statusCode)")
                }
                
                do {
                   
                    try FileManager.default.copyItem(at: tempLocalUrl, to: localUrl)
                    completion()
                } catch (let writeError) {
                    print("error writing file \(localUrl) : \(writeError)")
                }
                
            } else {
                print("Failure: %@", error?.localizedDescription ?? "Error occured");
            }
        }
        task.resume()
    }
    }
}

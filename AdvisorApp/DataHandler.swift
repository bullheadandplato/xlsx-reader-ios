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
    public static func loadDetailData(title:String,completion:([CellModel])->()){
        if let dir=FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first{
            
            let outPath=dir.appendingPathComponent(CommonConstants.FILENAME);
            let spreadsheet: BRAOfficeDocumentPackage = BRAOfficeDocumentPackage.open(outPath.path)
            let workSheet : BRAWorksheet=spreadsheet.workbook.worksheets?[0] as! BRAWorksheet;
            var data:Array<CellModel>=Array()
            

            var innerCalled=false
            for row in workSheet.rows as! [BRARow]{
                let capability:BRACell=row.cells?[1] as! BRACell
                let val=capability.stringValue()!
           
                if (val==title){
                    let rowIndex=capability.rowIndex()
                    var count=0;
                    print("row index: \(rowIndex)")
                    for i in rowIndex...workSheet.rows.count-1{
                        print("row in loop")
                        let innerRow=workSheet.rows?[i] as! BRARow
                        let typeCell=innerRow.cells?[0] as! BRACell
                        innerCalled=true
                        if(typeCell.stringValue()=="C" && count != 0){
                            break
                        }else{
                           print("row adding something")
                            count=count+1
                            let name=workSheet.cell(forCellReference: "B\(i+1)").stringValue()!
                            var url=""
                            var e3=""
                            var e5=""
                            var description="no description provided."
                            if(workSheet.cell(forCellReference: "J\(i+1)") != nil){
                                url=workSheet.cell(forCellReference: "J\(i+1)").stringValue()
                            }
                            if(workSheet.cell(forCellReference: "C\(i+1)") != nil){
                                e3=workSheet.cell(forCellReference: "C\(i+1)").stringValue()
                            }
                            if(workSheet.cell(forCellReference: "D\(i+1)") != nil){
                                e5=workSheet.cell(forCellReference: "D\(i+1)").stringValue()!
                            }
                            if(workSheet.cell(forCellReference: "E\(i+1)") != nil){
                                description=workSheet.cell(forCellReference: "E\(i+1)").stringValue()!
                            }
                            var ees=""
                            if(e3 != ""){
                                ees=e3+" and "+e5;
                            }else{
                                ees=e5
                            }
                            let cellModel=CellModel.init(title: name, url:url , description: description, ees: ees)
                        
                            data.insert(cellModel, at: data.count)
                        }
                    }
                    if(innerCalled){
                       // data.remove(at: 0)
                        completion(data)
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

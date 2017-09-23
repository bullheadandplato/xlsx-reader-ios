//
//  DataHandler.swift
//  IosGoogling
//
//  Created by Osama Bin Omar on 9/23/17.
//  Copyright © 2017 Osama Bin Omar. All rights reserved.
//

import Foundation
class DataHandler {
    public static func loadData(){
        let url=NSURL.init(string:"https://onedrive.live.com/view.aspx?resid=F04A84FECFFF888B!84898&ithint=file%2cxlsx&app=Excel&authkey=!ALqZklZ00KuGO8A");
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
            
                do{
                    let text=try String.init(contentsOf: outPath)
                    var spreadsheet: BRAOfficeDocumentPackage = BRAOfficeDocumentPackage.open(outPath.path)
                
                    print(text)
                }catch{
                    print("Fucked!!!!")
                }
            })
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

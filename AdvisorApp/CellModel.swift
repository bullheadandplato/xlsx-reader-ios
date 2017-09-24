//
//  CellModel.swift
//  AdvisorApp
//
//  Created by Osama Bin Omar on 9/24/17.
//  Copyright © 2017 Osama Bin Omar. All rights reserved.
//

import Foundation
class CellModel {
    private var title:String?;
    private var url:String?;
    private var description:String?;
    private var ees:String;
    
    public func getTitle()->String{
        return title!;
    }
    public func getUrl()->String{
        return url!
    }
    public func getDescription()->String{
        return description!
    }
    public func getEes()->String{
        return ees;
    }
    public init(title:String,url:String,description:String,ees:String){
        self.description=description
        self.title=title
        self.ees=ees
        self.url=url
    }
    
}

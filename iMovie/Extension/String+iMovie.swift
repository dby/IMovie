//
//  String+iMovie.swift
//  iMovie
//
//  Created by sys on 2016/12/14.
//  Copyright © 2016年 sys. All rights reserved.
//

import UIKit
import Mustache

extension String {

    func HtmlWithData(data: NSDictionary, templateName: String) -> String {
        
        do {
            
            let templatePath: String  = Bundle.main.path(forResource: templateName, ofType: "html", inDirectory: "html")!
            let tempContent: NSString = try NSString(contentsOfFile: templatePath, encoding: String.Encoding.utf8.rawValue)
            let template: Template = try Template.init(string: tempContent as String)
            let rendering = try template.render(data)
            
            return rendering
            
        } catch {
            print("ERROR: \(error)")
        }

        return ""
    }
}

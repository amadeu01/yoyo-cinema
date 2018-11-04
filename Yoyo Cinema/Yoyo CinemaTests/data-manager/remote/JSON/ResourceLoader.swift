//
//  JsonTestHelper.swift
//  Yoyo CinemaTests
//
//  Created by Amadeu Cavalcante Filho on 02/11/18.
//  Copyright © 2018 Amadeu Cavalcante Filho. All rights reserved.
//

import Foundation

final public class ResourceLoader {
    
    public func loadJsonFile(_ name: String) -> Data {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: name, ofType: "json")
        
        return try! Data(contentsOf: URL(fileURLWithPath: path!), options: .mappedIfSafe)
    }
}

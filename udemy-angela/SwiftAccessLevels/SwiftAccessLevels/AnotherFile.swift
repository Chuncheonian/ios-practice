//
//  AnotherFile.swift
//  SwiftAccessLevels
//
//  Created by Angela Yu on 14/09/2018.
//  Copyright © 2018 London App Brewery. All rights reserved.
//

import Foundation

class AnotherClassInAnotherFile {
    
    init() {
        let aClass = AClass()
        
        //Step 8. Try to print aFilePrivateProperty Here
//        print("\(aClass.aFilePrivateProperty) printed from init() in AnotherClassInTheSameFile")
        
        //Step 10. Try to print anInternalProperty Here
        print("\(aClass.anInternalProperty) printed from init() in AnotherClassInTheSameFile")
        
    }
    
}

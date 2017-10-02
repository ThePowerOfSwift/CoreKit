//
//  ViewController.swift
//  Example
//
//  Created by Tibor Bödecs on 2017. 09. 29..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

import UIKit.UIViewController
import CoreKit


class Alma: NSObject {
    override init() {
        super.init()
    }
}

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: CollectionView!
    
    //@objc(ViewController_Korte)
    class Korte: NSObject {
        override init() {
            super.init()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let grid = Grid(view: self.collectionView)
        let source = CollectionViewSource(grid: grid)
        let section = CollectionViewSection()

        for i in stride(from: 0, to: 300, by: 1) {
            let data = StringData("item \(i)")

            section.items.append(data)
        }

        source.sections.append(section)

        self.collectionView.source = source
        
        self.collectionView.reloadData()
    }

    func test() {
        testAlma()
        print("------")
        testKorte()
    }
    
    func testAlma() {
        let classVar = Alma.self;
        let classObj = Alma()
        
        print("Unique Identifier: \(classVar.uniqueIdentifier)")
        print("Namespace: \(classVar.objectNamespace ?? "-")")
        print("Object Name: \(classVar.objectName)")
        print("Object Name Identifier: \(classVar.objectNameIdentifier)")
        print("-")
        print("Unique Identifier: \(classObj.uniqueIdentifier)")
        print("Namespace: \(classObj.objectNamespace ?? "-")")
        print("Object Name: \(classObj.objectName)")
        print("Object Name Identifier: \(classObj.objectNameIdentifier)")
    }
    
    func testKorte() {
        let classVar = Korte.self;
        let classObj = Korte()
        
        print("Unique Identifier: \(classVar.uniqueIdentifier)")
        print("Namespace: \(classVar.objectNamespace ?? "-")")
        print("Object Name: \(classVar.objectName)")
        print("Object Name Identifier: \(classVar.objectNameIdentifier)")
        print("-")
        print("Unique Identifier: \(classObj.uniqueIdentifier)")
        print("Namespace: \(classObj.objectNamespace ?? "-")")
        print("Object Name: \(classObj.objectName)")
        print("Object Name Identifier: \(classObj.objectNameIdentifier)")
    }
}


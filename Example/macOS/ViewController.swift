//
//  ViewController.swift
//  Example
//
//  Created by Tibor Bodecs on 2016. 10. 18..
//  Copyright © 2016. Tibor Bodecs. All rights reserved.
//

import Cocoa
import CoreKit


class ViewController: NSViewController {

    @IBOutlet weak var collectionView: CollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        return
        
//        self.collectionView.backgroundColor = .yellow
        
        let grid    = Grid(view: self.collectionView)
        grid.columns = 1
        let source  = CollectionViewDataSource(grid: grid)
        
        source.callback = { item, indexPath in
            print("source callback")
        }
        
        
        for i in stride(from: 0, to: 100, by: 1) {
            
            var section = CollectionViewDataSourceSection() { item, indexPath in
                print("alternative section callback")
            }
            
            let header = CollectionViewData<Section, String>(item: "Header \(i).",
                config: { cell, item, indexPath, grid in
//                    cell.backgroundColor = .red
//                    cell.textLabel.text = item
                    cell.myField.stringValue = "fffff"
            },
                size: { item, indexPath, grid in
                    return grid.size(height: 64)
            })
            section.header = header
            
            let footer = CollectionViewData<Section, String>(item: "Footer \(i).",
                config: { cell, item, indexPath, grid in
//                    cell.backgroundColor = .lightGray
//                    cell.textLabel.text = item
            },
                size: { item, indexPath, grid in
                    return grid.size(height: 32)
            })
            section.footer = footer
            
            for i in stride(from: 0, to: 10, by: 1) {
                let item = CollectionViewData<CollectionViewItem, String>(item: "Cell \(i).",
                    config: { cell, item, indexPath, grid in
//                        cell.backgroundColor = .red
//                        cell.textLabel.text = item
                        
                        cell.textField?.stringValue = item
                },
                    size: { item, indexPath, grid in
                        return grid.size(height: 64, columns: 3)
                })
                //                                { item, indexPath in
                //                                    print("alternate item callback")
                //                                }
                
                if i == 0 {
                    item.callback = { item, indexPath in
                        print("item callback")
                    }
                }
                
                if i == 1 {
                    section.callback = { item, indexPath in
                        print("section callback")
                    }
                }
                
                if i == 2 {
                    section.callback = { item, indexPath in
                        print("section callback")
                    }
                    item.callback = { item, indexPath in
                        print("item callback")
                    }
                }
                
                section.items.append(item)
            }
            
            source.sections.append(section)
        }
        
        self.collectionView.source = source
        self.collectionView.reloadData()
        
    }

    override func viewDidAppear() {
        super.viewDidAppear()
    }

    override var representedObject: Any? {
        didSet {

        }
    }


}


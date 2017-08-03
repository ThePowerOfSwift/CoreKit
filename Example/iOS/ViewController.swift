//
//  ViewController.swift
//  iOS
//
//  Created by Tibor Bodecs on 2016. 10. 18..
//  Copyright © 2016. Tibor Bodecs. All rights reserved.
//

import UIKit
import CoreKit


class ViewController: CollectionViewController
{
    
    public func loadData() {

//        self.testDataTask()
        self.testDownloadTask()
    }

    func testDownloadTask() {

        Servers.dummy.user = "hello"
        Servers.dummy.logRequests = true
        
        Servers.dummy.query = [URLQueryItem(name: "q", value: "heh áe")]

        let apiCall = Servers.dummy.request(Kittens.image, log: true)
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .progress() { report in
                print("report...\(report)..")
        }

        apiCall.start()
        .flatMap { _ -> Promise<Response.Result> in
            Servers.dummy.user = "userke"
            let apiCall = Servers.dummy.request(Kittens.image)
    
            return apiCall.start()
        }
        .success { result in
//            Console.log(result.urlResponse)
//            Console.log(result.location)

            
        }
        .success(on: .main) { result in
            Console.log("----------- :):):)---------")
        }
        .failure { error in
            Console.log(error)
        }
        
//        apiCall.cancel()

//        apiCall.cancel { data in
//            Servers.dummy.request(Kittens.image, log: true)
//            .resume(data)
//            .success { result in
//                print(result)
//            }
//            .failure { error in
//                print(error)
//            }
//        }
    }


    func testDataTask() {

        let apiCall = Servers.json.request(Kittens.list("meow"))
        .validate(statusCode: 200..<300)
        .validate(contentType: ["application/json"])
        .progress() { report in

        }

        
        apiCall.start()
        .map { try $0.data?.toJsonArray() }
        .success { json in
            Console.log(json)
        }
        .success { json in
            Console.log(json)
        }
        .failure { error in
            Console.log(error)
        }
        
        //apiCall.cancel()
    }




    public override func loadView() {
        super.loadView()

        let collectionView  = CollectionView(layout: CollectionViewFlowLayout())
        self.collectionView = collectionView
        self.view.addSubview(self.collectionView)

        NSLayoutConstraint.activate([
            self.collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0),
            self.collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0),
            self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0),
        ])
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

        if self.isViewLoaded && self.view.window == nil {
            self.collectionView = nil
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadData()

        self.collectionView.backgroundColor = .yellow
        (self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionHeadersPinToVisibleBounds = true
        (self.collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionFootersPinToVisibleBounds = true

        let grid    = Grid(view: self.collectionView, traitCollection: self.traitCollection)
        grid.columns = 2
        let source  = CollectionViewDataSource(grid: grid)

        source.callback = { item, indexPath in
            print("source callback")
        }


        for i in stride(from: 0, to: 100, by: 1) {

            var section = CollectionViewDataSourceSection() { item, indexPath in
                print("alternative section callback")
            }

            let header = CollectionViewData<TextCell, String>(item: "Header \(i).",
                config: { cell, item, indexPath, grid in
                    cell.backgroundColor = .white
                    cell.textLabel.text = item
                },
                size: { item, indexPath, grid in
                    return grid.size(height: 64)
            })
            section.header = header

            let footer = CollectionViewData<TextCell, String>(item: "Footer \(i).",
                config: { cell, item, indexPath, grid in
                    cell.backgroundColor = .lightGray
                    cell.textLabel.text = item
                },
                size: { item, indexPath, grid in
                    return grid.size(height: 32)
            })
            section.footer = footer

            for i in stride(from: 0, to: 10, by: 1) {
                let item = CollectionViewData<TextCell, String>(item: "Cell \(i).",
                    config: { cell, item, indexPath, grid in
                        cell.backgroundColor = .red
                        cell.textLabel.text = item
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

}

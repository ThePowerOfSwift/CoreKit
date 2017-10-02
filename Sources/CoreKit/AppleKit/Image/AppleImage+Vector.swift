//
//  AppleImage+Vector.swift
//  CoreKit
//
//  Created by Tibor Bödecs on 2017. 09. 27..
//  Copyright © 2017. Tibor Bödecs. All rights reserved.
//

#if os(iOS) || os(tvOS)

import CoreGraphics.CGGeometry
import UIKit.UIGraphics


public extension AppleImage {

    public static func vectorImage(named: String, _ scale: Int = 32) -> AppleImage? {
        return AppleImage.vectorImage(named: named, size: CGSize(width: scale, height: scale))
    }

    public static func vectorImage(named: String, size: CGSize = CGSize(width: 32, height: 32)) -> AppleImage? {
        guard
            let url = AppleBundle.main.url(forResource: named, withExtension: "pdf"),
            let pdf = CGPDFDocument(url as CFURL)
        else
        {
            return nil
        }
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let page = pdf.page(at: 1)
        page?.drawContextIn(rect: CGRect(origin: .zero, size: size))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
}
#endif














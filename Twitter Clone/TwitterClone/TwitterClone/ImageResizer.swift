//
//  ImageResizer.swift
//  TwitterClone
//
//  Created by Edrease Peshtaz on 8/8/15.
//  Copyright (c) 2015 MysterioGroupSoftware. All rights reserved.
//

import UIKit

class ImageResizer {
  class func resizeImage(image: UIImage, size: CGSize) -> UIImage {
    
   UIGraphicsBeginImageContext(size)
   image.drawInRect(CGRect(x: 0, y: 0, width: size.width, height: size.height))
   let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
   return resizedImage
  }
}

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
  
  class func switchImageSize (imageToResize: UIImage) -> CGSize {
    var size: CGSize
    switch UIScreen.mainScreen().scale {
    case 2:
      size = CGSize(width: 80, height: 80)
    case 3:
      size = CGSize(width: 120, height: 120)
    default:
      size = CGSize(width: 40, height: 40)
    }
    return size
  }
}

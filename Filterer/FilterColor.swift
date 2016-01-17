//
//  FilterColor.swift
//  Filterer
//
//  Created by Aaron Marquez on 15/01/16.
//  Copyright © 2016 UofT. All rights reserved.
//

import UIKit

public class imageFilters{
    
    
    public init(){
        
    }
    

    
    public func filterRed(image : UIImage, red: Float) -> UIImage{
        let rgbaImage = RGBAImage(image: image)!
        
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                
                let index = y * rgbaImage.width + x
                var pix: Pixel = (rgbaImage.pixels[index])
                let red: Float = Float(pix.red) * red
                let green: Float = 0
                let blue: Float = 0
                
                pix.red = UInt8(red)
                pix.green = UInt8(green)
                pix.blue = UInt8(blue)
                
                rgbaImage.pixels[index] = pix;
            }
        }
        
        let result = rgbaImage.toUIImage()!
        return result
    }

    
    
    public func filterBlue(image : UIImage, blue: Float) -> UIImage{
        let rgbaImage = RGBAImage(image: image)!
        
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                var pix: Pixel = (rgbaImage.pixels[index])
                let red: Float = 0
                let green: Float = 0
                let blue: Float = Float(pix.blue) * blue
                
                pix.red = UInt8(red)
                pix.green = UInt8(green)
                pix.blue = UInt8(blue)
                
                rgbaImage.pixels[index] = pix;
            }
        }
        
        let result = rgbaImage.toUIImage()!
        return result
    }

    
    func filterGreen(image : UIImage, green:Float) -> UIImage{
        let rgbaImage = RGBAImage(image: image)!
        
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                var pix: Pixel = (rgbaImage.pixels[index])
                let red: Float = 0
                let green: Float = Float(pix.green) * green
                let blue: Float = 0
                
                pix.red = UInt8(red)
                pix.green = UInt8(green)
                pix.blue = UInt8(blue)
                
                rgbaImage.pixels[index]=pix
            }
        }
        
        let result = rgbaImage.toUIImage()!
        return result
    }
    
    
    
    /*
    public func filterYellow( image : UIImage, green : Float, red : Float ) -> UIImage{
        let rgbaImage = RGBAImage(image: image)!
        
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                
                
                let index = y * rgbaImage.width + x
                var pixel = rgbaImage.pixels[index]
                
                if(pixel.green > 100){
                    pixel.green = UInt8(max(0, min(255, Float(pixel.green) + green)))
                    
                }
                if(pixel.red > 100){
                    pixel.red = UInt8(max(0, min(255, Float(pixel.red) + red)))
                    
                }
                rgbaImage.pixels[index]=pixel

            }
        }
        let newImage = rgbaImage.toUIImage()!
        return newImage
    }*/
    
    
    /*
    public func filterPurple( image : UIImage, x : Float, y : Float ) -> UIImage{
        let rgbaImage = RGBAImage(image: image)!
        
        for y in 0..<rgbaImage.height {
            for x in 0..<rgbaImage.width {
                let index = y * rgbaImage.width + x
                var pixel = rgbaImage.pixels[index]
                
                if(pixel.green > 100){
                    pixel.green = UInt8(max(0, min(255, Int(pixel.green) - x)))
                    
                }
                
                if(pixel.red > 150 ){
                    pixel.red = UInt8(max(0, min(255, Int(pixel.red) - y)))
                    
                }
                if(pixel.red < 100 ){
                    pixel.red = UInt8(max(0, min(255, Int(pixel.red) + y)))
                    
                }
                
                if(pixel.blue > 150 ){
                    pixel.blue = UInt8(max(0, min(255, Int(pixel.blue) - y)))
                    
                }
                if(pixel.blue < 100 ){
                    pixel.blue = UInt8(max(0, min(255, Int(pixel.blue) + y)))
                    
                }
                
                rgbaImage.pixels[index]=pixel
            }
        }
        let newImage = rgbaImage.toUIImage()!
        return newImage
    }
*/
    
    
}

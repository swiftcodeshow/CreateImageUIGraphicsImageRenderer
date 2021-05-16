//
//  ContentView.swift
//  CreateImageUIGraphicsImageRenderer
//
//  Created by 米国梁 on 2021/4/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        VStack {
            
            Text("UIGraphicsImageRenderer Results:")
            Image(uiImage: composeUIGraphicsImageRenderer())
                .border(Color.black, width: 1)
            
            if let image = composeCoreGraphics() {
                Text("CoreGraphics Results: (not clear)")
                Image(uiImage: image)
                    .border(Color.black, width: 1)
            }
        }
    }
    
    // - MARK: Create images by UIGraphicsImageRenderer
    
    func image1() -> UIImage {
        // Create a 100x100 image
        UIGraphicsImageRenderer(size: CGSize(width: 100, height: 100)).image { ctx in
            // Fill a red 50x50 rectangle at the bottom-right
            ctx.cgContext.setFillColor(UIColor.red.cgColor)
            ctx.fill(CGRect(x: 50, y: 50, width: 50, height: 50))
            // Stroke a red 100x100 rectangle for the final image
            ctx.cgContext.setStrokeColor(UIColor.red.cgColor)
            ctx.stroke(CGRect(x: 0, y: 0, width: 100, height: 100))
        }
    }
    
    func image2() -> UIImage {
        // Create a 50x50 image
        UIGraphicsImageRenderer(size: CGSize(width: 50, height: 50)).image { ctx in
            // Fill a green 25x25 rectangle at the top-left
            ctx.cgContext.setFillColor(UIColor.green.cgColor)
            ctx.fill(CGRect(x: 0, y: 0, width: 25, height: 25))
            // Stroke a green border for the final image
            ctx.cgContext.setStrokeColor(UIColor.green.cgColor)
            ctx.stroke(CGRect(x: 0, y: 0, width: 50, height: 50))
        }
    }
    
    func composeUIGraphicsImageRenderer() -> UIImage {
        
        let img1 = image1()
        let img2 = image2()
        
        return UIGraphicsImageRenderer(size: CGSize(width: 200, height: 200)).image { ctx in
            img1.draw(at: CGPoint(x: (200 - img1.size.width) / 2,
                                  y: (200 - img1.size.height) / 2))
            img2.draw(at: CGPoint(x: (200 - img2.size.width) / 2,
                                  y: (200 - img2.size.height) / 2))
        }
    }
    
    // - MARK: Create images by Core Graphics Low-Level APIs
    
    func image3() -> UIImage? {
        
        let drawSize = CGSize(width: 100, height: 100)
        UIGraphicsBeginImageContextWithOptions(drawSize, false, 0)
        // Release the image context when the function returns
        defer { UIGraphicsEndImageContext() }
        // Get current image context, and care about exceptions
        guard let ctx = UIGraphicsGetCurrentContext() else {
            fatalError("Failed to get current context...")
        }
        
        // The same logics as `image1`...
        ctx.setFillColor(UIColor.red.cgColor)
        ctx.fill(CGRect(x: 50, y: 50, width: 50, height: 50))
        ctx.setStrokeColor(UIColor.red.cgColor)
        ctx.stroke(CGRect(x: 0, y: 0, width: 100, height: 100))
        
        // Return the final image, but the result is optional...
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func image4() -> UIImage? {
        
        let drawSize = CGSize(width: 50, height: 50)
        UIGraphicsBeginImageContextWithOptions(drawSize, false, 0)
        // Release the image context when the function returns
        defer { UIGraphicsEndImageContext() }
        // Get current image context, and care about exceptions
        guard let ctx = UIGraphicsGetCurrentContext() else {
            fatalError("Failed to get current context...")
        }
        
        // The same logics as `image4`...
        ctx.setFillColor(UIColor.green.cgColor)
        ctx.fill(CGRect(x: 0, y: 0, width: 25, height: 25))
        ctx.setStrokeColor(UIColor.green.cgColor)
        ctx.stroke(CGRect(x: 0, y: 0, width: 50, height: 50))
        
        // Return the final image, but the result is optional...
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    func composeCoreGraphics() -> UIImage? {
        
        let drawSize = CGSize(width: 200, height: 200)
        UIGraphicsBeginImageContextWithOptions(drawSize, false, 0)
        // Release the image context when the function returns
        defer { UIGraphicsEndImageContext() }
        
        if let img1 = image3(), let img2 = image4() {
            
            img1.draw(at: CGPoint(x: (200 - img1.size.width) / 2,
                                  y: (200 - img1.size.height) / 2))
            img2.draw(at: CGPoint(x: (200 - img2.size.width) / 2,
                                  y: (200 - img2.size.height) / 2))
        }
        
        // Return the final image, but the result is optional...
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

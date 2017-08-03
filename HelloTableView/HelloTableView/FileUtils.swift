//
//  FileUtils.swift
//  HelloTableView
//
//  Created by Treinamento on 01/08/17.
//  Copyright © 2017 Treinamento. All rights reserved.
//

import UIKit

class FileUtils  {
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    func save(image: UIImage) -> String? {
        let currentDate = NSDate()
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let convertedDate = dateFormatter.string(from: currentDate as Date)
        
        let fileURL = documentsUrl.appendingPathComponent(convertedDate)
        if let imageData = UIImageJPEGRepresentation(image, 1.0) {
            try? imageData.write(to: fileURL, options: .atomic)
            return convertedDate
        }
        
        return nil
    }
    
    func load(fileName: String) -> UIImage? {
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        do {
            let imageData = try Data(contentsOf: fileURL)
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }
}

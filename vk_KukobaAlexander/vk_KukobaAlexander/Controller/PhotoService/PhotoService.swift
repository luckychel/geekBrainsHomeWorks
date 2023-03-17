//
//  PhotoService.swift
//  vk_KukobaAlexander
//
//  Created by Александр Кукоба on 17.03.2023.
//

import UIKit
import Foundation
import Alamofire

class PhotoService {
    
    private static let pathName: String = {
        
        let pathName = "images"
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return pathName
        }
        
        let url = cachesDirectory.appendingPathComponent(pathName, isDirectory: true)
        
        if !FileManager.default.fileExists(atPath: url.path) {
            try? FileManager.default.createDirectory(at: url, withIntermediateDirectories: true, attributes: nil)
        }
        
        return pathName
    }()
    
    private let cachesLifeTime: TimeInterval = 30 * 24 * 60 * 60
    private var images = [String: UIImage]()
    private let container: DataReloadable
    
    init(container: UITableView) {
        self.container = Table(table: container)
    }
    
    init(container: UICollectionView) {
        self.container = Collection(collection: container)
    }
    
    func photo(atIndexpath indexPath: IndexPath, byUrl url: String) -> UIImage? {
        
        var image: UIImage?
        
        //print(url)
        
        if let photo = images[url] {
            image = photo
            print("Строка \(indexPath.row) взята из RAM")
        } else if let photo = getImageFromCache(url: url) {
            image = photo
            print("Строка \(indexPath.row) взята из CACHE")
        } else {
            loadPhoto(atIndexpath: indexPath, byUrl: url)
            print("Строка \(indexPath.row) взята из WEB")
        }
        
        return image
    }
    
    private func getImageFromCache(url: String) -> UIImage? {
        
        guard
            let fileName = getFilePath(url: url),
            let info = try? FileManager.default.attributesOfItem(atPath: fileName),
            let modificationDate = info[FileAttributeKey.modificationDate] as? Date
        else { return nil }
        
        let lifeTime = Date().timeIntervalSince(modificationDate)
        
        guard
            lifeTime <= cachesLifeTime,
            let image = UIImage(contentsOfFile: fileName)
        else { return nil }
        
        DispatchQueue.main.async {
            self.images[url] = image
        }
        
        return image
    }
    
    private func getFilePath(url: String) -> String? {
        
        guard let cachesDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else {
            return nil
        }
        
        let hashName = url.split(separator: "/").last ?? "default"
        
        return cachesDirectory.appendingPathComponent(PhotoService.pathName + "/" + hashName).path
    }
    
    private func loadPhoto(atIndexpath indexPath: IndexPath, byUrl url: String) {
        AF.request(url).responseData(queue: DispatchQueue.global()) { [weak self] response in
            guard
                let data = response.data,
                let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self?.images[url] = image
            }
            
            self?.saveImageToCache(url: url, image: image)
            
            DispatchQueue.main.async {
                self?.container.reloadRow(atIndexpath: indexPath)
            }
        }
    }
    
    private func saveImageToCache(url: String, image: UIImage) {
        
        guard let fileName = getFilePath(url: url),
              let data = image.pngData() else { return }
        
        print(fileName)
        
        FileManager.default.createFile(atPath: fileName, contents: data, attributes: nil)
    }
}

fileprivate protocol DataReloadable {
    func reloadRow(atIndexpath indexPath: IndexPath)
}

extension PhotoService {
    
    private class Table: DataReloadable {
        
        let table: UITableView
        
        init(table: UITableView) {
            self.table = table
        }
        
        func reloadRow(atIndexpath indexPath: IndexPath) {
            table.reloadRows(at: [indexPath], with: .none)
        }
        
    }
    
    private class Collection: DataReloadable {

        let collection: UICollectionView
        
        init(collection: UICollectionView) {
            self.collection = collection
        }
        
        func reloadRow(atIndexpath indexPath: IndexPath) {
            collection.reloadItems(at: [indexPath])
        }
        
    }
}

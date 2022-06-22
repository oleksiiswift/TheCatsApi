//
//  CFileManager.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 20.06.2022.
//

import Foundation
import UIKit

enum AppFilesDirectories: String {
	case cache = "ImageCacheDirrectory"
	case temp = "tmp"
}

enum FileType: String {
	case jpeg = "jpeg"
	case png = "png"
}

class CFileManager {
	
	private let fileManager: FileManager
	
	init() {
		self.fileManager = FileManager.default
	}
	
	public func clearDirectory(of type: AppFilesDirectories) {
		
		let directoryURL = self.getDirrectoryURL(type)
		self.clearDirectory(at: directoryURL)
	}
	
	private func clearDirectory(at url: URL?) {
		
		guard let url = url else { return }
		
		do {
			let cacheURLS = try fileManager.contentsOfDirectory(at: url, includingPropertiesForKeys: nil, options: .skipsHiddenFiles)
			try cacheURLS.forEach {
				try fileManager.removeItem(at: $0)
			}
		} catch  {
			debugPrint(error.localizedDescription)
		}
	}
	 
	public func moveFileCacheDirrectory(from source: URL, with name: String, file type: FileType) -> URL? {
		
		guard let cacheDirectory = self.getDirrectoryURL(.cache) else { return nil}
		
		let destinationURL = URL(fileURLWithPath: cacheDirectory.path).appendingPathComponent(name).appendingPathExtension(type.rawValue)
		do {
			if fileExists(atPath: destinationURL) {
				return destinationURL
			}
			try fileManager.moveItem(at: source, to: destinationURL)
			return destinationURL
		} catch {
			debugPrint(error.localizedDescription)
		}
		return nil
	}
	
	public func getImageFromCache(with id: String) -> UIImage? {
		
		let (isExist, cacheURL) = self.isCacheFileExist(with: id)
		
		if isExist, let url = cacheURL {
			do {
				let data = try Data(contentsOf: url)
				return UIImage(data: data)
			} catch {
				debugPrint(error.localizedDescription)
			}
		}
		return nil
	}
	
	public func isCacheFileExist(with id: String) -> (Bool, URL?) {
		
		guard let cacheDirectory = self.getDirrectoryURL(.cache) else { return (false, nil)}
		let destinationURL = URL(fileURLWithPath: cacheDirectory.path).appendingPathComponent(id).appendingPathExtension(FileType.jpeg.rawValue)
		
		if fileExists(atPath: destinationURL) {
			return (true, destinationURL)
		} else {
			return (false, nil)
		}
	}
	
	public func removeIdsFromCache(ids: [String]) {
		
		ids.forEach {
			self.clearCacheFiles(with: $0)
		}
	}
	
	public func clearCacheFiles(with id: String) {
		
		let (isExist, url) = self.isCacheFileExist(with: id)
		if isExist, let url = url {
			do {
				try fileManager.removeItem(atPath: url.path)
				debugPrint("file removed")
			} catch {
				debugPrint(error.localizedDescription)
			}
		}
	}
	
	private func fileExists(atPath: URL) -> Bool {
		return fileManager.fileExists(atPath: atPath.path)
	}
		
	private func getDirrectoryURL(_ directory: AppFilesDirectories) -> URL? {
		
		var directoryURL: URL {
			switch directory {
				case .cache:
					let path = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
					return path.appendingPathComponent(directory.rawValue)
				case .temp:
					return fileManager.temporaryDirectory
			}
		}

		var isDirectory: ObjCBool = true
		
		if !fileManager.fileExists(atPath: directoryURL.path, isDirectory: &isDirectory) {
			do {
				try fileManager.createDirectory(atPath: directoryURL.path, withIntermediateDirectories: false, attributes: nil)
				return directoryURL
			} catch {
				debugPrint(error.localizedDescription)
			}
		}
		return directoryURL
	}
}

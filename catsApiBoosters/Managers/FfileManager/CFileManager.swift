//
//  CFileManager.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 20.06.2022.
//

import Foundation

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
			try fileManager.moveItem(at: source, to: destinationURL)
			return destinationURL
		} catch {
			debugPrint(error.localizedDescription)
		}
		return nil
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

//
//  ImageDonwloadActor.swift
//  catsApiBoosters
//
//  Created by alexey sorochan on 20.06.2022.
//

import UIKit

actor ImageDownloadActor {
	
	private enum CacheHandler {
		case progressState(Task<URL?, Error>)
		case completeState(URL)
		case failed
	}
	
	private var fileManager = CFileManager()
	private var imageCache: [String: CacheHandler] = [:]
			
	public func getImage(from url: URL?, with id: String) async throws -> UIImage {
		
		if let cachedImage = imageCache[id] {
			switch cachedImage {
				case .completeState(let url):
					if let image = try self.getCachedImage(from: url) {
						return image
					}
				case .progressState(let task):
					let url = try await task.value
					if let image = try self.getCachedImage(from: url) {
						return image
					}
				case .failed:
					throw ErrorHandler.ImageLoadError.chacheIDError
			}
		}
		
		let donwloadTask: Task<URL?, Error> = Task.detached {
			
			guard let url = url else { throw ErrorHandler.ImageLoadError.urlError }
			
			return try await self.downloadImage(from: url, cached: id)
		}
		
		imageCache[id] = .progressState(donwloadTask)

		do {
			let result = try await donwloadTask.value
			self.cacheImage(result, id: id)
			return try await self.getImage(from: result, with: id)
		} catch {
			self.imageCache[id] = .failed
			throw ErrorHandler.ImageLoadError.error
		}
	}
	
	private func cacheImage(_ tempURL: URL?, id key: String) {
		if let url = tempURL {
			debugPrint("chache image \(url)")
			self.imageCache[key] = .completeState(url)
		}
	}
	
	private func getCachedImage(from url: URL?) throws -> UIImage? {
		
		guard let url = url else { return nil }
		
		let data = try Data(contentsOf: url)
		return UIImage(data: data)
	}
	
	private func downloadImage(from url: URL, cached id: String) async throws -> URL? {
		
		let (isExist, cacheURL) = fileManager.isCacheFileExist(with: id)
		
		if isExist {
			if let cacheURL = cacheURL {
				debugPrint("cache url is exist: \(cacheURL)")
				return cacheURL
			}
		}
		
		let (sourceURL, responce) = try await URLSession.shared.download(from: url)
		
		guard let httpResponse = responce as? HTTPURLResponse, (200..<400).contains(httpResponse.statusCode) else { throw ErrorHandler.NetworkingError.badServerResponse }
		
		return self.fileManager.moveFileCacheDirrectory(from: sourceURL, with: id, file: .jpeg)
	}
}

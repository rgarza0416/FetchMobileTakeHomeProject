//
//  DataCaching.swift
//  FetchMobileTakeHomeProjectTests
//
//  Created by Ricardo Garza on 2/14/25.
//

import XCTest
@testable import FetchMobileTakeHomeProject

class PhotoCacheViewModelTests: XCTestCase {
    
    var photoCache: PhotoCacheViewModel!
    
    override func setUp() async throws {
        photoCache = PhotoCacheViewModel()
    }
    
    override func tearDown() async throws {
        photoCache = nil
    }
    
    func testCachingImage() async {
        let testKey = "testKey"
        let testImage = UIImage(systemName: "person.fill")
        
        await photoCache.setImage(testImage!, forKey: testKey)
        let cachedImage = await photoCache.image(forKey: testKey)
        
        XCTAssertNotNil(cachedImage, "Image should be cached")
        XCTAssertEqual(cachedImage?.pngData(), testImage?.pngData(), "Cached image should match the original image")
    }
}


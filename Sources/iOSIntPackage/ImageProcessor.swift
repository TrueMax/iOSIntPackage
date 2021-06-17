//
//  ImageProcessor.swift
//  
//
//  Created by Maxim Abakumov on 2020. 10. 12.
//

import UIKit

// MARK: - ImageProcessor

public struct ImageProcessor {
    
    // MARK: - Interface
    
    public init() {}
    
    // применение фильтра к изображению в главном потоке, не требует явного вызова DispatchQueue.main при работе с UI
    public func processImage(
        sourceImage: UIImage,
        filter: ColorFilter,
        completion: (UIImage?) -> Void
    ) {
        applyFilter(
            filter: filter,
            image: sourceImage,
            handler: completion)
    }
    
    // применение фильтра к изображению в параллельном потоке, требует явного вызова DispatchQueue.main при работе с UI
    public func processImageAsync(
        sourceImage: UIImage,
        filter: ColorFilter,
        completion: @escaping (CGImage?) -> Void
    ) {
        applyFilterAsync(
            filter: filter,
            image: sourceImage,
            handler: completion)
    }
    
    // MARK: - Internal interface
    
    public func processImagesOnThread(
        sourceImages: [UIImage],
        filter: ColorFilter,
        qos: QualityOfService,
        completion: @escaping ([CGImage?]) -> Void
    ) {
        let thread = ImageThread(qos: qos) {
            applyFilterOnThread(
                sourceImages: sourceImages,
                filter: filter,
                completion: completion
            )
        }
        thread.start()
    }
    
    // MARK: - Private func
    
    private func applyFilter(
        filter: ColorFilter,
        image: UIImage,
        handler: (UIImage?) -> Void
    ) {
        let context = CIContext()
        guard let source = CIImage(image: image) else { fatalError("Error creating source image") }
        var params = filter.parameters
        params[ColorFilter.imageKey] = source
        guard let filter = CIFilter(
            name: filter.filterName,
            parameters: params
        ) else { fatalError("Error creating filter") }
        
        guard let filteredImage = filter.outputImage else { fatalError("Error filtering image") }
        
        guard let outputImage = context.createCGImage(
            filteredImage,
            from: filteredImage.extent
        ) else { fatalError("Error creating output image") }
        handler(UIImage(cgImage: outputImage))
    }
    
    private func applyFilterAsync(
        filter: ColorFilter,
        image: UIImage,
        handler: @escaping (CGImage?) -> Void
    ) {
        DispatchQueue.global(qos: .userInitiated).async {
            let context = CIContext()
            guard let source = CIImage(image: image) else { fatalError("Error creating source image") }
            var params = filter.parameters
            params[ColorFilter.imageKey] = source
            guard let filter = CIFilter(
                name: filter.filterName,
                parameters: params
            ) else { fatalError("Error creating filter") }
            
            guard let filteredImage = filter.outputImage else { fatalError("Error filtering image") }
            
            guard let outputImage = context.createCGImage(
                filteredImage,
                from: filteredImage.extent
            ) else { fatalError("Error creating output image") }
            handler(outputImage)
        }
    }
    
    private func applyFilterOnThread(
        sourceImages: [UIImage],
        filter: ColorFilter,
        completion: @escaping ([CGImage?]) -> Void
    ) {
        let context = CIContext()
        let output = sourceImages.map { image -> CGImage in
            guard let source = CIImage(image: image) else { fatalError("Error creating source image") }
            var params = filter.parameters
            params[ColorFilter.imageKey] = source
            guard let filter = CIFilter(
                name: filter.filterName,
                parameters: params
            ) else { fatalError("Error creating filter") }
            
            guard let filteredImage = filter.outputImage else { fatalError("Error filtering image") }
            
            guard let outputImage = context.createCGImage(
                filteredImage,
                from: filteredImage.extent
            ) else { fatalError("Error creating output image") }
            return outputImage
        }
        completion(output)
    }
}

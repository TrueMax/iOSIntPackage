//
// File.swift
// 
// 
// Created by Maxim Abakumov on 2021. 06. 01.
//
// Copyright © 2020, Maxim Abakumov. MIT License.
//

import UIKit

final public class ImagePublisherFacade {
    
    public typealias RepeatCount = Int
    
    private let publisher = ImagePublisher()
    
    public init() {}
    
    // добавляет подписчика
    
    public func subscribe(_ subscriber: ImageLibrarySubscriber) {
        publisher.add(subscriber: subscriber)
    }
    
    // удаляет подписчика
    
    public func removeSubscription(for subscriber: ImageLibrarySubscriber) {
        publisher.remove { _ in
            return true
        }
    }
    
    /// По таймеру добавляет новые случайные UIImage в библиотеку ImagePublisher
    /// Поскольку изображений в библиотеке немного, можно добавлять свои картинки
    
    @available(iOS 10.0, *)
    public func addImagesWithTimer(
        time interval: TimeInterval,
        repeat times: RepeatCount,
        userImages: [UIImage]? = nil
    ) {
        var count = 0
        Timer.scheduledTimer(
            withTimeInterval: interval,
            repeats: true
        ) { [weak self] timer in
            count += 1
            
            if let images = userImages {
                guard let randomImage = images.randomElement() else { return }
                self?.publisher.add(image: randomImage)
            } else {
                guard let imageCase = Images.allCases.randomElement() else { return }
                let libraryImage = imageCase.image(name: imageCase)
                self?.publisher.add(image: libraryImage)
            }
            
            if count == times {
                timer.invalidate()
            }
        }
    }
    
    // метод обнуляет библиотеку изображений
    
    public func rechargeImageLibrary() {
        publisher.removeAll()
    }
}

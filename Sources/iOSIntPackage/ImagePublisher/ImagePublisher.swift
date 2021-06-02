//
// ImagePublisher.swift
// 
// 
// Created by Maxim Abakumov on 2021. 06. 01.
//
// Copyright © 2020, Maxim Abakumov. MIT License.
//

import UIKit

public protocol ImageLibrarySubscriber {
    
    func receive(images: [UIImage])
}

final class ImagePublisher {
    
    private var subscribers: [ImageLibrarySubscriber] = []
    private var images: [UIImage] = []
    
    func add(image: UIImage) {
        images.append(image)
        notifySubscribers()
    }
    
    func remove(image: UIImage) {
        guard let index = images.firstIndex(where: { $0 == image }) else { return }
        images.remove(at: index)
        notifySubscribers()
    }
    
    func removeAll() {
        if !images.isEmpty {
            images = []
        }
        notifySubscribers()
    }
    
    func add(subscriber: ImageLibrarySubscriber) {
        subscribers.append(subscriber)
    }
    
    func remove(subscriber filter: (ImageLibrarySubscriber) -> Bool) {
        guard let index = subscribers.firstIndex(where: filter) else { return }
        subscribers.remove(at: index)
    }
    
    private func notifySubscribers() {
        subscribers.forEach {
            $0.receive(images: images)
        }
    }
}


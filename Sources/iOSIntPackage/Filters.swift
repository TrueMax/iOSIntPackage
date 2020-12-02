//
// Filters.swift
// 
// 
// Created by Maxim Abakumov on 2020. 12. 02.
//
// Copyright © 2020, Maxim Abakumov. MIT License.
//

import UIKit

public enum ColorFilter {
    
    static let imageKey = kCIInputImageKey
    static let radiusKey = kCIInputRadiusKey
    static let intensityKey = kCIInputIntensityKey
    static let colorKey = kCIInputColorKey
    
    case posterize
    case colorInvert
    case transfer
    case noir
    case tonal
    case process
    case chrome
    case fade
    case gaussianBlur(radius: Double)
    case motionBlur(radius: Double)
    case monochrome(color: CIColor, intensity: Double)
    case sepia(intensity: Double)
    case crystallize(radius: Double)
    case bloom(intensity: Double)
    case vignette(intensity: Double, radius: Double)
    
    var parameters: [String: Any] {
        switch self {
        case .posterize,
             .colorInvert,
             .transfer,
             .noir,
             .tonal,
             .process,
             .chrome,
             .fade:
            return [:]
        case .gaussianBlur(radius: let radius):
            return [ ColorFilter.radiusKey: radius ]
        case .motionBlur(radius: let radius):
            return [ ColorFilter.radiusKey: radius ]
        case .monochrome(color: let color, intensity: let intensity):
            return [
                ColorFilter.colorKey: color,
                ColorFilter.intensityKey: intensity
            ]
        case .sepia(intensity: let intensity):
            return [ ColorFilter.intensityKey: intensity ]
        case .crystallize(radius: let radius):
            return [ ColorFilter.radiusKey: radius ]
        case .bloom(intensity: let intensity):
            return [ ColorFilter.intensityKey: intensity ]
        case .vignette(intensity: let intensity, radius: let radius):
            return [
                ColorFilter.intensityKey: intensity,
                ColorFilter.radiusKey: radius
            ]
        }
    }
    
    var filterName: String {
        switch self {
        
        case .gaussianBlur:
            return "CIGaussianBlur"
        case .motionBlur:
            return "CIMotionBlur"
        case .monochrome:
            return "CIColorMonochrome"
        case .posterize:
            return "CIColorPosterize"
        case .colorInvert:
            return "CIColorInvert"
        case .sepia:
            return "CISepiaTone"
        case .transfer:
            return "CIPhotoEffectTransfer"
        case .noir:
            return "CIPhotoEffectNoir"
        case .tonal:
            return "CIPhotoEffectTonal"
        case .process:
            return "CIPhotoEffectProcess"
        case .chrome:
            return "CIPhotoEffectChrome"
        case .fade:
            return "CIPhotoEffectFade"
        case .crystallize:
            return "CICrystallize"
        case .bloom:
            return "CIBloom"
        case .vignette:
            return "CIVignetteEffect"
        }
    }
}

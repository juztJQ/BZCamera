//
//  MediaFileCaptureProtocol.swift
//  BZCamera
//
//  Created by Juanelo on 7/25/19.
//  Copyright © 2019 Juanelo. All rights reserved.
//

import Foundation
protocol MediaFileCaptureProtocol: NSObjectProtocol {
    func didFinishCapturingPhoto(image: UIImage?)
    func didFinishCapturingVideo(videoUrl: URL?, thumbnail: UIImage?)
    func didReceivePhotoError(error: Error?)
    func didReceiveVideoError(error: Error?)
}

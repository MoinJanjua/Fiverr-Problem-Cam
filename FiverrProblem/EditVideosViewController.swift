//
//  EditVideosViewController.swift
//  FiverrProblem
//
//  Created by Moin Janjua on 29/07/2019.
//  Copyright © 2019 Joshua Mirecki. All rights reserved.
//

import Foundation
import AVFoundation
import AssetsLibrary
import UIKit


class EditVideosViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    let imagePickerController = UIImagePickerController()
    var videoURL: NSURL?
    
    @IBAction func selectImageFromPhotoLibrary(sender: UIBarButtonItem) {

    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        videoURL = info["UIImagePickerControllerReferenceURL"] as? NSURL
        print(videoURL as Any)
        imagePickerController.dismiss(animated: true, completion: nil)
        let minDuration : CMTime = CMTimeMake(0, 1)
        let maxDuration : CMTime = CMTimeMake(5, 1)
        VideoUltilities.init().trimVideov2(sourceURL: videoURL!, startTime: minDuration, endTime: maxDuration, withAudio: true) { (url, error) in
            self.videoURL = url
        }
        print("ok")
    }
    

    
    
    @IBAction func TrimVideosBtn(_ sender: Any) {
        print("ok")

        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePickerController.mediaTypes = ["public.image", "public.movie"]
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
    
    
//    let session = AVCaptureSession()
//    for device in AVCaptureDevice.devices() {
//    
//    if let device = device as? AVCaptureDevice , device.position == AVCaptureDevicePosition.back {
//    
//    self.device = device
//    }
//    }
//    
//    for device in AVCaptureDevice.devices(withMediaType: AVMediaTypeAudio) {
//    let device = device as? AVCaptureDevice
//    let audioInput = try! AVCaptureDeviceInput(device: device)
//    session?.addInput(audioInput)
//    }
//    
//    do {
//    
//    if let session = session {
//    videoInput = try AVCaptureDeviceInput(device: device)
//    
//    session.addInput(videoInput)
//    
//    videoOutput = AVCaptureMovieFileOutput()
//    let totalSeconds = 60.0 //Total Seconds of capture time
//    let timeScale: Int32 = 30 //FPS
//    
//    let maxDuration = CMTimeMakeWithSeconds(totalSeconds, timeScale)
//    
//    
//    videoOutput?.maxRecordedDuration = maxDuration
//    videoOutput?.minFreeDiskSpaceLimit = 1024 * 1024//SET MIN FREE SPACE IN BYTES FOR RECORDING TO CONTINUE ON A VOLUME
//    
//    if session.canAddOutput(videoOutput) {
//    session.addOutput(videoOutput)
//    }
//    
//    
//    let videoLayer = AVCaptureVideoPreviewLayer(session: session)
//    videoLayer?.frame = self.videoPreview.bounds
//    
//    videoLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
//    
//    self.videoPreview.layer.addSublayer(videoLayer!)
//    
//    session.startRunning()
//    
//    
//    }
//    }
//    
//    func cropVideo( _ outputFileUrl: URL, callback: @escaping ( _ newUrl: URL ) -> () )
//    {
//        // Get input clip
//        let videoAsset: AVAsset = AVAsset( url: outputFileUrl )
//        let clipVideoTrack = videoAsset.tracks( withMediaType: AVMediaType.video ).first! as AVAssetTrack
//        
//        // Make video to square
//        let videoComposition = AVMutableVideoComposition()
//        videoComposition.renderSize = CGSize( width: clipVideoTrack.naturalSize.height, height: clipVideoTrack.naturalSize.height )
//        videoComposition.frameDuration =  CMTimeMake( 1, 20)
//        
//        // Rotate to portrait
//        let transformer = AVMutableVideoCompositionLayerInstruction( assetTrack: clipVideoTrack )
//        let transform1 = CGAffineTransform( translationX: clipVideoTrack.naturalSize.height, y: -( clipVideoTrack.naturalSize.width - clipVideoTrack.naturalSize.height ) / 2 )
//        let transform2 = transform1.rotated(by: CGFloat(Double.pi/2 ) )
//        transformer.setTransform( transform2, at: kCMTimeZero)
//        
//        let instruction = AVMutableVideoCompositionInstruction()
//        instruction.timeRange = CMTimeRangeMake(kCMTimeZero, CMTimeMakeWithSeconds(self.intendedVideoLength, self.framesPerSecond ) )
//        
//        instruction.layerInstructions = [transformer]
//        videoComposition.instructions = [instruction]
//        
//        // Export
//        let croppedOutputFileUrl = URL( fileURLWithPath: FileManager.getOutputPath( String.random() ) )
//        let exporter = AVAssetExportSession(asset: videoAsset, presetName: AVAssetExportPresetHighestQuality)!
//        exporter.videoComposition = videoComposition
//        exporter.outputURL = croppedOutputFileUrl
//        exporter.outputFileType = AVFileType.mov
//        
//        exporter.exportAsynchronously( completionHandler: { () -> Void in
//            DispatchQueue.main.async(execute: {
//                callback( croppedOutputFileUrl )
//            })
//        })
//    }
//    
//    
//    func getOutputPath( _ name: String ) -> String
//    {
//        let documentPath = NSSearchPathForDirectoriesInDomains(  .documentDirectory, .userDomainMask, true )[ 0 ] as NSString
//        let outputPath = "\(documentPath)/\(name).mov"
//        return outputPath
//    }
    
}

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
import AVKit
import MobileCoreServices


class EditVideosViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    
    @IBOutlet weak var VideoView: UIImageView!
    @IBOutlet weak var CollectioView: UICollectionView!
    var thumbnails = [UIImage]()

    
    var videoClips:[NSURL] = [NSURL]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self

    }
    
    
    
    let imagePickerController = UIImagePickerController()
    var videoURL: NSURL?
    
    @IBAction func selectImageFromPhotoLibrary(sender: UIBarButtonItem) {

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let urlval = info[UIImagePickerControllerMediaURL] as? NSURL
        print(videoURL as Any)
        imagePickerController.dismiss(animated: true, completion: nil)
        do {
            let asset = AVURLAsset(url: urlval! as URL , options: nil)
            let imgGenerator = AVAssetImageGenerator(asset: asset)
            imgGenerator.appliesPreferredTrackTransform = true
            let cgImage = try imgGenerator.copyCGImage(at: CMTimeMake(0, 1), actualTime: nil)
            let thumbnail = UIImage(cgImage: cgImage)
            VideoView.image = thumbnail
        } catch let error {
            print("*** Error generating thumbnail: \(error.localizedDescription)")
        }
        let minDuration : CMTime = CMTimeMake(0, 1)
        let maxDuration : CMTime = CMTimeMake(5, 1)
        VideoUltilities.init().cropVideo(sourceURL: urlval! as URL, startTime: 0.5, endTime: 1.10, completion: { (url) in
            self.videoURL = url as NSURL
            
            let player = AVPlayer(url: url as URL)
            let vcPlayer = AVPlayerViewController()
            vcPlayer.player = player
            self.present(vcPlayer, animated: true, completion: nil)
        })
        //trimVideov2(sourceURL: videoURL!, startTime: minDuration, endTime: maxDuration, withAudio: true)
        //        { (url, error) in
        //            self.videoURL = url
        //
        //            let player = AVPlayer(url: url! as URL)
        //            let vcPlayer = AVPlayerViewController()
        //            vcPlayer.player = player
        //            self.present(vcPlayer, animated: true, completion: nil)
        //        }
    }
    

    
    
    @IBAction func TrimVideosBtn(_ sender: Any) {


        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.mediaTypes = ["public.video", "public.movie"]
        
        present(imagePickerController, animated: true, completion: nil)
    }
    
    
//    func trimVideov3(sourceURL: NSURL, startTime: CMTime, endTime: CMTime, withAudio: Bool, completion:@escaping (NSURL?, NSError?) -> Void) -> Void {
//        
//        let fileManager = FileManager.default
//        
//        let sourcePathURL = NSURL(fileURLWithPath: (sourceURL.absoluteString ?? ""))
//        
//        // let asset = AVURLAsset(url: sourcePathURL as URL)
//        let asset: AVAsset = AVAsset(url: sourcePathURL as URL) as AVAsset
//        
//        let composition = AVMutableComposition()
//        
//        let videoCompTrack = composition.addMutableTrack(withMediaType: AVMediaType.video, preferredTrackID: kCMPersistentTrackID_Invalid)
//        let audioCompTrack = composition.addMutableTrack(withMediaType: AVMediaType.audio, preferredTrackID: kCMPersistentTrackID_Invalid)
//        
//        let assetVideoTrack = asset.tracks(withMediaType: AVMediaType.video)[0]
//        let assetAudioTrack = asset.tracks(withMediaType: AVMediaType.audio)[0]
//        
//        var accumulatedTime = kCMTimeZero
//        
//        let durationOfCurrentSlice = CMTimeSubtract(endTime, startTime)
//        let timeRangeForCurrentSlice = CMTimeRangeMake(startTime, durationOfCurrentSlice)
//        
//        do {
//            try videoCompTrack?.insertTimeRange(timeRangeForCurrentSlice, of: assetVideoTrack, at: accumulatedTime)
//            try audioCompTrack?.insertTimeRange(timeRangeForCurrentSlice, of: assetAudioTrack, at: accumulatedTime)
//        }
//        catch let error {
//            print("Error insert time range \(error)")
//        }
//        
//        accumulatedTime = CMTimeAdd(accumulatedTime, durationOfCurrentSlice)
//        
//        print("Trimv2 \(CMTimeGetSeconds(accumulatedTime))")
//        
//        let destinationPath = String(format: "%@%@", NSTemporaryDirectory(),"trim.mp4")
//        let destinationPathURL = NSURL(fileURLWithPath: destinationPath)
//        
//        if fileManager.fileExists(atPath: destinationPath) {
//            // remove if exists
//            do {
//                try fileManager.removeItem(at: destinationPathURL as URL)
//            }
//            catch let error {
//                print("Could not remove file at path \(destinationPath) with error \(error)")
//            }
//        }
//        
//        let exportSession = AVAssetExportSession(asset: composition, presetName: AVAssetExportPresetHighestQuality)
//        exportSession?.outputURL = destinationPathURL as URL
//        exportSession?.outputFileType = AVFileType.mp4
//        exportSession?.shouldOptimizeForNetworkUse = true
//        
//        exportSession!.exportAsynchronously(completionHandler: { () -> Void in
////            dispatch_async(dispatch_get_main_queue(), {
////                self.handleExportCompletion(exportSession)
////            }
//            DispatchQueue.main.async {
//                self.handleExportCompletion(session: exportSession!)
//            }
//            
//        })
//        
////        exportSession?.exportAsynchronously(completionHandler: {
////            switch exportSession!.status {
////            case .completed :
////                completion(NSURL(string: destinationPath),nil)
////            default :
////                print("Error export")
////            }
////        })
//        
//    }
//    
//    
//    func handleExportCompletion(session: AVAssetExportSession) {
//        let library = ALAssetsLibrary()
//        let thumbnail =  self.getThumbnail(outputFileURL: session.outputURL! as NSURL)
//        videoClips.append(session.outputURL! as NSURL)
//        
//        thumbnails.append(thumbnail)
//        self.CollectioView.reloadData()
//        let indexPath = NSIndexPath(item: thumbnails.count - 1, section: 0)
//        self.CollectioView.scrollToItem(at: indexPath as IndexPath, at: UICollectionViewScrollPosition.right, animated: true)
//    }
//    
//    func getThumbnail(outputFileURL:NSURL) -> UIImage {
//        
//        let clip = AVURLAsset(url: outputFileURL as URL)
//        let imgGenerator = AVAssetImageGenerator(asset: clip)
//        let cgImage = try! imgGenerator.copyCGImage(
//            at: CMTimeMake(0, 1), actualTime: nil)
//        let uiImage = UIImage(cgImage: cgImage)
//        return uiImage
//        
//    }
// 
    
    
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

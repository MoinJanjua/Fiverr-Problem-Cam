//
//  CameraViewController.swift
//  InstagramClone
//
//  Created by The Zero2Launch Team on 12/4/16.
//  Copyright © 2016 The Zero2Launch Team. All rights reserved.
//

import UIKit
import AVFoundation
import SCRecorder


 @objc class CameraViewController: UIViewController {
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var captionTextView: UITextView!
    @IBOutlet weak var removeButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var DareText: SkyFloatingLabelTextField!
    var selectedImage: UIImage?
    @objc public var yumfun = SCFilter()
       @objc public var recordSession = SCRecordSession()
    @objc public var myValue = String()
    @objc public var exportSessions = SCAssetExportSession()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         let UrlCamera = URL(fileURLWithPath: myValue)
     
        print(yumfun)
    }
    
    
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "create" {
            
            let secondViewController = segue.destination as! iPhoneXDare
            secondViewController.exportSessions = self.exportSessions
            secondViewController.yumfun = self.yumfun
            secondViewController.Daretext = self.DareText.text!
            
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @IBAction func shareButton_TouchUpInside(_ sender: Any) {
        let timestamp = NSNumber(value: Int(Date().timeIntervalSince1970))
        let oofff = timestamp.stringValue
     let UrlCamera = URL(fileURLWithPath: myValue)
//       let toURL = URL(fileURLWithPath: UrlCamera)
        
        let fun = recordSession.outputUrl
        view.endEditing(true)
        print(UrlCamera)
       print("ganggang")
      
        
        
        exportSessions.exportAsynchronously {
            if self.exportSessions.error == nil {
                
    
                    func thumbnailImageForFileUrl(_ fileUrl: URL) -> UIImage? {
                        let asset = AVAsset(url: self.exportSessions.outputUrl!)
                        let imageGenerator = AVAssetImageGenerator(asset: asset)
                        imageGenerator.appliesPreferredTrackTransform = true
                        
                        do {
                            let thumbnailCGImage = try imageGenerator.copyCGImage(at: CMTimeMake(value: 7, timescale: 1), actualTime: nil)
                            return UIImage(cgImage: thumbnailCGImage)
                        } catch let err {
                            print(err)
                        }
                        
                        return nil
                    }
                    
                if var videoUrl = self.exportSessions.outputUrl {
                        if let thumnailImage = thumbnailImageForFileUrl(videoUrl) {
                            self.selectedImage = thumnailImage
                            self.photo.image = thumnailImage
                            print("reggfd")
                        }
                        
                    }
                   
        
        
              
            }else {
                print(self.exportSessions.error?.localizedDescription)
            }
        }
        
        }
    
   
   
    func clean() {
        self.captionTextView.text = ""
       
        self.selectedImage = nil
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        
        return false
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, with: event)
    }
    
}





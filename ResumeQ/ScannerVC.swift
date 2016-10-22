//
//  FirstViewController.swift
//  ResumeQ
//
//  Created by Ben Cootner on 10/21/16.
//  Copyright © 2016 Ben Cootner. All rights reserved.
//

import UIKit
import AVFoundation

class ScannerVC: UIViewController {

    var captureSession:AVCaptureSession?
    var videoPrviewLayer: AVCaptureVideoPreviewLayer?
    var QRCodeFrameView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //Instance of the AVCaptureDevice
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: "AVMediaTypeVideo")
        //Get Instance of AVCaptureDeviceInput
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice) as AVCaptureDeviceInput
            
            //Initialize the captureSession object
            captureSession = AVCaptureSession()
            //Set the input device on the cpature session
            captureSession?.addInput(input as AVCaptureInput)
            
            //Initialize a AVCaptureMetadataOutput 
            let captureMetadataOutput = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadataOutput)
            captureMetadataOutput.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            captureMetadataOutput.metadataObjectTypes = [AVMetadataObjectTypeQRCode]
            
            //Initialize the video preview layer and add it as a sublayer 
            videoPrviewLayer AVCaptureVideoPreviewLayer(session: captureSession)    
            
        }
        catch let error as NSError {
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

//MARK: ACaptrueMetadata Delegates and DataSource
extension ScannerVC: AVCaptureMetadataOutputObjectsDelegate {
    
}


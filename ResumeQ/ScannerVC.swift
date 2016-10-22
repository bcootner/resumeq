//
//  FirstViewController.swift
//  ResumeQ
//
//  Created by Ben Cootner on 10/21/16.
//  Copyright © 2016 Ben Cootner. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class ScannerVC: UIViewController {

    var captureSession:AVCaptureSession?
    var videoLayer: AVCaptureVideoPreviewLayer?
    var QRCodeFrameView: UIView?
    var scanPending = false
    var player : AVAudioPlayer?
    
    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        scanPending = false
        
        //Instance of the AVCaptureDevice
        let captureDevice = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo)
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
            videoLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            if let videoLayer = videoLayer {
                videoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
                videoLayer.frame = view.layer.bounds
                self.view.layer.addSublayer(videoLayer)
            } else {
                print("unable to unwrape videoLayer")
            }
            
            //Start video capture 
            captureSession?.startRunning()
            
            //Initialize QQR Code Frame highlighting 
            QRCodeFrameView = UIView()
            if let QRCodeFrameView = QRCodeFrameView {
                QRCodeFrameView.layer.borderColor = UIColor.green.cgColor
                QRCodeFrameView.layer.borderWidth = 2
                view.addSubview(QRCodeFrameView)
                view.bringSubview(toFront: QRCodeFrameView)
            
            }
            
        }
        catch let error as NSError {
            print(error)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func playSound() {
        if let url = Bundle.main.url(forResource: "Ping", withExtension: ".aiff")
        {
            do {
                player = try AVAudioPlayer(contentsOf: url)
                if let player = player {
                    AudioServicesPlayAlertSound(kSystemSoundID_Vibrate)
                    player.prepareToPlay()
                    player.play()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
}

//MARK: ACaptrueMetadata Delegate function for recognizing QR Code
extension ScannerVC: AVCaptureMetadataOutputObjectsDelegate {
    func captureOutput(_ captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [Any]!, from connection: AVCaptureConnection!) {
        
        //Check if the metadataObject array is nil or emptu
        if metadataObjects == nil || metadataObjects.count == 0 {
            QRCodeFrameView?.frame = CGRect.zero
            return
        }
        
        //Get metadata object 
        if let mdObject = metadataObjects[0] as? AVMetadataMachineReadableCodeObject, mdObject.type == AVMetadataObjectTypeQRCode {
            //If metadata found
            if let barCodeObject = videoLayer?.transformedMetadataObject(for: mdObject as AVMetadataMachineReadableCodeObject) {
                QRCodeFrameView?.frame = barCodeObject.bounds
                if mdObject.stringValue != nil {
                    if scanPending == false {
                        videoLayer?.isHidden = true 
                        scanPending = true
                        let newScan = Resume(qrId: mdObject.stringValue)
                        newScan.sendRequest(completion: { (success, output) in
                            self.playSound()
                            if(success == false) {
                                print("error with alamorequest")
                            } else {
                                if let output = output {
                                    self.webView.scalesPageToFit = true
                                    let request = URLRequest(url: output)
                                    self.webView.loadRequest(request)
                                    self.view.addSubview(self.webView)
                                }
                            }
                        })
                    }
                }
            }
        }
    }
    
}


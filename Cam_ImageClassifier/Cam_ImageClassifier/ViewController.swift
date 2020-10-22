//
//  ViewController.swift
//  Cam_ImageClassifier
//
//  Created by QingZhang on 22.10.20.
//

import UIKit
import AVKit
import Vision


class ViewController: UIViewController, AVCaptureVideoDataOutputSampleBufferDelegate {
    
    // MARK: - UI Properties
    @IBOutlet weak var videoPreview: UIView!
    @IBOutlet weak var labelLabel: UILabel!
    @IBOutlet weak var confidenceLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let captureSession = AVCaptureSession()
        // crap the preview as phote
        //captureSession.sessionPreset = .photo
        
        // add input to the captureSession
        // add captureDevice (muss be unwrapped)
        guard let captureDevice = AVCaptureDevice.default(for: .video) else { return }
        // add input
        guard let input = try? AVCaptureDeviceInput(device: captureDevice) else { return }
        captureSession.addInput(input)
        
        // start captureSession
        captureSession.startRunning()
        
        // define camera output -- camera preview
        let previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        //view.layer.addSublayer(previewLayer)
        
        self.videoPreview.layer.addSublayer(previewLayer)
        
        
        // add frame to the preview layer
        //previewLayer.frame = view.frame
        previewLayer.frame = videoPreview.frame
        
        // access to the image frame
        let dataOutput = AVCaptureVideoDataOutput()
        // set sample buffer delegate to the image frame
        dataOutput.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        captureSession.addOutput(dataOutput)
    
    }
    
    // this func will be called every time when the image frame is captured
    // acturally use this function to access the frame captured
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        //print("Camera captured a image frame:", Date())
        
        // turn sampleBuffer to CVPixelBuffer (unwrapped)
        guard let pixelBuffer: CVPixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        
        // analyse the image on preview layer
        // define ML model (in the form of VNCoreMLModel)
        guard let model = try? VNCoreMLModel(for: Resnet50().model) else { return }
        
        // define request from CoreML model
        let request = VNCoreMLRequest(model: model) { (finishedRequest, err) in
            
            // cast the .results into array to display the result
            guard let results = finishedRequest.results as? [VNClassificationObservation] else { return }
            
            guard let firstObservation = results.first else { return }
            
            //print(firstObservation.identifier, firstObservation.confidence)
            DispatchQueue.main.sync {
                self.labelLabel.text = firstObservation.identifier
                self.confidenceLabel.text = "\(round(firstObservation.confidence * 100)) %"
            }
        }
        
        try? VNImageRequestHandler(cvPixelBuffer: pixelBuffer, options: [:]).perform([request])
    }
    
    
}


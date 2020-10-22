# ImageClassification-IOS-Camera using CoreML -- Resnet50

![platform-ios](https://img.shields.io/badge/platform-ios-lightgreen.svg)
![swift-version](https://img.shields.io/badge/swift-5-lightgreen.svg)
![lisence](https://img.shields.io/badge/license-MIT-lightgreen.svg)

![DEMO-CoreML](https://github.com/QZhang-Ing/IOS/blob/master/Cam_ImageClassifier/resource/demo.GIF?raw=true)

## Requirements

- Xcode 12+
- iOS 12.0+
- Swift 5

## Model

**Resnet50**  
**Size:** 102,6MB  
**Link:** [Apple Developer - Core ML Models](https://developer.apple.com/machine-learning/models/)


## Implementation Notes 

1. Import ML model by draging *.mlmodel* file into Project Navigator. After importing the model, xcode will generate helper class of the ML model.
2. Usage permission to access the camera should be added to the `info.plist`
3. define ML model   

```swift
// define ML model (in the form of VNCoreMLModel)
guard let model = try? VNCoreMLModel(for: Resnet50().model) else { return }
```

4. Update Label to display the result  

```swift
DispatchQueue.main.sync {
                self.labelLabel.text = /** result **/
                self.confidenceLabel.text = /** confidence **/ 
}
```
# ImageClassification-CoreML

![platform-ios](https://img.shields.io/badge/platform-ios-lightgrey.svg)
![swift-version](https://img.shields.io/badge/swift-4-red.svg)
![lisence](https://img.shields.io/badge/license-MIT-black.svg)

![DEMO-CoreML](https://github.com/tucan9389/MobileNetApp-CoreML/raw/master/resource/MobileNet-CoreML-DEMO.gif?raw=true)

## Requirements

- Xcode 12+
- iOS 12.0+
- Swift 5

## Model

**Resnet50**  
**Size:** 102,6MB  
[Apple Developer - Core ML Models](https://developer.apple.com/machine-learning/models/)


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
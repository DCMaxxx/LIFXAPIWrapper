# LIFXAPIWrapper

[![Version](https://img.shields.io/cocoapods/v/LIFXAPIWrapper.svg?style=flat)](http://cocoapods.org/pods/LIFXAPIWrapper)
[![License](https://img.shields.io/cocoapods/l/LIFXAPIWrapper.svg?style=flat)](http://cocoapods.org/pods/LIFXAPIWrapper)
[![Platform](https://img.shields.io/cocoapods/p/LIFXAPIWrapper.svg?style=flat)](http://cocoapods.org/pods/LIFXAPIWrapper)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Here's a quickie :
```obj-c
- (void)doSomeStuffWithTheLIFXAPI
{
LIFXAPIWrapper *APIWrapper = [LIFXAPIWrapper sharedAPIWrapper];
[APIWrapper setOAuthToken:@"Your-OAuth-Token"]; // See below how to generate one

[APIWrapper getAllLightsWithCompletion:^(NSArray *lights) {
NSLog(@"Fetched all lights: %@", lights);

LIFXLight *light = lights.firstObject;
LIFXTargetOperationUpdate *brightnessUpdate = [LIFXTargetOperationUpdate updateWithBrightness:.5];
[APIWrapper applyUpdate:brightnessUpdate toTarget:light onCompletion:^(NSArray *results) {
NSLog(@"Brightness update result : %@", results);

} onFailure:^(NSError *error) {
NSLog(@"Couldn't appy update: %@", error); 
}];

} onFailure:^(NSError *error) {
NSLog(@"Couldn't fetch lights: %@", error); 
];
}
```

All the classes, methods and property are documented, so you should be able understand it quite easily.

## Authentication
The LIFX HTTP API authenticates using an OAuthToken, generate yours [on your LIFX Clour settings page](https://cloud.lifx.com/settings).  
Unfortunately, username/password combination is **NOT** supported yet.    
All the informations you might need are available [on LIFX's documentation page](http://developer.lifx.com).

## Installation

LIFXAPIWrapper is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "LIFXAPIWrapper"
```

## Author

Maxime de Chalendar, maxime.dechalendar@me.com

## License

LIFXAPIWrapper is available under the MIT license. See the LICENSE file for more info.

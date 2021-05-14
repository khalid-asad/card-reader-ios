![iOS](https://img.shields.io/badge/platform-Linux%20%7C%20OS%20X%20%7C%20iOS%20%7C%20tvOS%20%7C%20watchOS-orange.svg)
[![SPM compatible](https://img.shields.io/badge/SPM-compatible-4BC51D.svg?style=flat)](https://github.com/apple/swift-package-manager)
![License](https://img.shields.io/cocoapods/l/SwiftSoup.svg?style=flat)
![Swift 5.0](https://img.shields.io/badge/swift-5.0-orange.svg)

## card-reader-ios

A credit card reader and parser for iOS Using Native Vision/VisionKit

https://user-images.githubusercontent.com/37077623/118222340-71396380-b44d-11eb-9e81-573b00fddc97.mp4

## Instructions

*   Hold camera up to a card and stay still until it gets recoginized and a picture gets taken.
*   Hit Save, and the results should get processed.

## Usage as Framework

### There are 2 options to present:


### Simply navigate to or present CardResultsView as a sheet or View:

```swift
var body: some View {
	CardFormView(colors: [.green, .blue, .black], completion: { cardDetails in 
        print("Card Number:\n\(cardDetails.number ?? "")")
        print("Expiry Date:\n\(cardDetails.expiryDate ?? "")")
        print("Name:\n\(cardDetails.name ?? "")")
        print("Name:\n\(cardDetails.cvcNumber ?? "")")
        print("Card Type:\n\(cardDetails.type.rawValue)")
        print("Card Industry:\n\(cardDetails.industry.rawValue)")
    })
}
```


### Only the card reader view:

Add this code in your SwiftUI Main View underneath your main StackView/ScrollView/NavigationView:

```swift
.sheet(isPresented: $isShowingSheet) {
    CardReaderView() { cardDetails in
        self.cardDetails = cardDetails
        isShowingSheet.toggle()
    }
    .edgesIgnoringSafeArea(.all)
}
```

Create two state variables to handle sheet presentation and to hold the card details result from the closure:

```swift
@State private var isShowingSheet = false
@State private var cardDetails: CardDetails?
```

Add the UI Presentation logic of the CardDetails however you see fit:

```swift
if let cardDetails = cardDetails {
    Text("Card Number:\n\(cardDetails.number ?? "")")
    Text("Expiry Date:\n\(cardDetails.expiryDate ?? "")")
    Text("Name:\n\(cardDetails.name ?? "")")
    Text("Card Type:\n\(cardDetails.type.rawValue)")
    Text("Card Industry:\n\(cardDetails.industry.rawValue)")
}
```

Finally, present the CardReaderView by toggling the sheet (preferably from the closure of a button action):

```swift
Button { isShowingSheet.toggle() } label: { Text("Tap to Start Credit Card reading!") } 
```

## Notes

*   I will continue to maintain this repo and keep adding new features.
*   If you see a bug or have an idea for a new feature, please raise an issue or pull request :)

## License

CardReader is available under the MIT license. See the LICENSE file for more info.
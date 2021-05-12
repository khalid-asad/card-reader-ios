# card-reader-ios
A credit card reader and parser for iOS Using Native Vision/VisionKit

https://user-images.githubusercontent.com/37077623/118050836-06553300-b34e-11eb-922e-94dcf6f8d905.mp4

# Instructions
- Hold camera up to a card and stay still until it gets recoginized and a picture gets taken.
- Hit Save, and the results should get processed.

# Usage as Framework
There are 2 options to present:

1. Simply navigate to or present CardResultsView as a sheet or View:

`var body: some View {
	CardFormView()
}`


2. Just the card reader view:

Add this code in your SwiftUI Main View underneath your main StackView/ScrollView/NavigationView:

`.sheet(isPresented: $isShowingSheet) {
    CardReaderView() { cardDetails in
        self.cardDetails = cardDetails
        isShowingSheet.toggle()
    }
    .edgesIgnoringSafeArea(.all)
}`

Create two state variables to handle sheet presentation and to hold the card details result from the closure:

`@State private var isShowingSheet = false
@State private var cardDetails: CardDetails?`

Add the UI Presentation logic of the CardDetails however you see fit:

`if let cardDetails = cardDetails {
    Text("Card Number:\n\(cardDetails.number ?? "")")
    Text("Expiry Date:\n\(cardDetails.expiryDate ?? "")")
    Text("Name:\n\(cardDetails.name ?? "")")
    Text("Card Type:\n\(cardDetails.type.rawValue)")
    Text("Card Industry:\n\(cardDetails.industry.rawValue)")
}`

Finally, present the CardReaderView by toggling the sheet (preferably from the closure of a button action):

`Button { isShowingSheet.toggle() } label: { Text("Tap to Start Credit Card reading!") } `


# Notes
- I will continue to maintain this repo and keep adding new features.
- If you see a bug or have an idea for a new feature, please raise an issue or pull request :)
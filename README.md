# Toast

View Modifier (with View extension) that will enable you to easily present toast, with predefined or custom cunfigurations.
Some code example:

```
struct ToastExampleView: View {

    @ObservedObject var viewModel: ToastExampleViewModel

    var body: some View {
        VStack {
            Text("Demo View for toast")
            Spacer()

            Button(action: self.handleShowToast) {

                Text("Click here to see toast")
                    .padding(.vertical, 16)
                    .padding(.horizontal, 24)
            }
        }

        // use the modifier directly. in the ViewBuilder closure you can pass any kind of View, see buildToast() for example. see screenshot
        .modifier(ToastModifier(isPresented: $viewModel.showToast,
                                toastConfiguration: ToastConfiguration.defaultBottomConfiguration, {
                                    buildToast()
                                }))

        // use toast View extension, it will call the modifier. you can pass it any configuration (manual or predefined). in this example we use the default top configuration - toast will appear from top. presenting here buildToast() View
        .toast(isPresented: $viewModel.showToast,
               configuration: ToastConfiguration.defaultTopConfiguration, {
            buildToast()
            
        })

        // use predefined View presenting text with "text for toast" from bottom
        .bottomTextToast(isPresented: $viewModel.showToast, text: "text for toast")

        // use predefined View presenting text with "text for toast" from top
        .topTextToast(isPresented: $viewModel.showToast, text: "Very long text for toast that will overlap to the second line")

        // same as bottomTextToast and topTextToast, but here you can also pass configuration (default or custom)
        .textToast(
            isPresented: $viewModel.showToast,
            configuration: customConfiguration,
            text: "custom configured toast")
    }

    var customConfiguration = ToastConfiguration(
        duration: 5,
        dragToDismiss: true,
        direction: .fromTop(padding: 50),
        animationIn: Animation.interactiveSpring().speed(0.3),
        animationOut: Animation.linear(duration: 2),
        transition: .move(edge: .leading))

    func buildToast() -> some View {
        HStack {
            HStack {
                Image("CheckCircleSeafoamBlue")
                    .padding(.leading, 13)
                    .frame(width: 24, height: 24)

                Text("Link copied to clipboard")
                    .multilineTextAlignment(.leading)
                    .foregroundColor(Color(red: 224 / 255, green: 224 / 255, blue: 224 / 255))
                    .font(Font.robotoRegular16)
                    .padding(.leading, 10)
                    .padding(.trailing, 13)
                    .padding(.vertical, 18)
                //                    .frame(maxWidth: .infinity)

                Spacer()
            }
            .frame(maxWidth: .infinity)
            .background(
                GeometryReader { geometry in
                    Color.black.opacity(0.8)
                        .cornerRadius(geometry.size.height / 2.0)
                }
            )
            .padding(.horizontal, 8)
        }
        .background(Color.clear)
        .frame(idealHeight: 50)
        //        .frame(height: 50)
        .frame(maxWidth: .infinity)
    }
    
    private func handleShowToast() {
        self.viewModel.showToast = true
    }
}
```

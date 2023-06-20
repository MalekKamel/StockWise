//
// Created by Kamel on 04/03/2023.
//

import SwiftUI
import SwiftUINavigator

struct ListSheet: View {
    @EnvironmentObject private var navigator: Navigator

    private let description: String
    private let items: [ListItem]
    private let withDismissButton: Bool
    @State private var selectedItem: ListItem? = nil
    private let onItemSelected: (ListItem) -> Void

    init(description: String,
         items: [ListItem],
         withDismissButton: Bool = true,
         onItemSelected: @escaping (ListItem) -> ()
    ) {
        self.description = description
        self.items = items
        self.withDismissButton = withDismissButton
        self.onItemSelected = onItemSelected
    }

    var body: some View {
        AppSheet(withDismissButton: withDismissButton) {
            ContentView()
        }
    }

    private func ContentView() -> some View {
        VStack {
            Spacer().frame(height: 16)
            DescriptionView()
            Spacer().frame(height: 16)
            ItemsView()
                    .infiniteSize()
        }
                .padding(.horizontal, 16)
                .background(Color.white)
    }

    private func DescriptionView() -> some View {
        Text(description)
                .multilineTextAlignment(.center)
                .appFont(size: 16)
                .infiniteWidth()
    }

    private func ItemsView() -> some View {
        PlainList(items) { item in
            ItemView(item: item)
                    .onTapGesture {
                        onItemSelected(item)
                        navigator.dismissSheet()
                    }
        }
    }

    private func ItemView(item: ListItem) -> some View {
        VStack {
            Text(item.name)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .appFont(size: 16)
        }
                .padding(16)
                .background(AppColor.gray2)
                .clipShape(Capsule())
                .padding(.vertical, 4)
    }

}

struct ListSheet_Previews: PreviewProvider {
    static var previews: some View {
        ListSheet(
                description: "Description",
                items: Fake.shared.listItems) { item in
        }
    }
}

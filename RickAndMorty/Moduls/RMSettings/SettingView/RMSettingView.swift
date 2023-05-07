//
//  RMSettingView.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 5.05.2023.
//

import SwiftUI

struct RMSettingView: View {
    let viewModel: RMSettingViewVM
    init(viewModel: RMSettingViewVM) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        List(viewModel.cellViewVM) { viewModel in
            HStack {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .renderingMode(.template)
                        .foregroundColor(Color(uiColor: UIColor(named: "BlackColor") ?? .white))
                        .aspectRatio(contentMode: .fit)
                        .frame( width: 35, height: 35)
                        .background(Color(viewModel.iconContainerColor))
                        .cornerRadius(8)
                        .padding(6)
                }
                Text(viewModel.title)
                    .padding(.leading)
            }
            .padding(0.6)
            .listRowBackground(Color(uiColor: (UIColor(named: "DarkGrey")?.withAlphaComponent(0.5))!))
            .onTapGesture {
                viewModel.onTapHandler(viewModel.type)
            }
        }
    }
}

struct RMSettingView_Previews: PreviewProvider {
    static var previews: some View {
        RMSettingView(viewModel: .init(cellViewVM: RMSettingsOption.allCases.compactMap({
            return RMSettingsTVCellVM(type: $0) { option in
                
            }
        })))
    }
}

//
//  SearchInputView.swift
//  RickAndMorty
//
//  Created by Mehmet Can Şimşek on 21.05.2023.
//

import UIKit

protocol SearchInputViewDelegate: AnyObject {
    func searchInputView(_ inputView: SearchInputView,
                         didSelectOptions option: SearchInputViewVM.DynamicOptions
    )
}


final class SearchInputView: UIView {
    weak var delegate: SearchInputViewDelegate?
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.barTintColor = UIColor(named: "Background")
        return searchBar
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private var viewModel: SearchInputViewVM? {
        didSet {
            guard let viewModel = viewModel, viewModel.hasDynamicOptions else { return }
            let options = viewModel.options
            createOptionsSelectionViews(options: options)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        addSubViews(searchBar, stackView)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor),
            searchBar.leftAnchor.constraint(equalTo: leftAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 55),
            
            stackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            stackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
        ])
    }
    
    public func configure(with viewModel: SearchInputViewVM) {
        self.viewModel = viewModel
        searchBar.placeholder = viewModel.searchPlaceholdeerText
    }
    
    private func createOptionsSelectionViews(options: [SearchInputViewVM.DynamicOptions]) {
        for x in 0..<options.count {
            let option = options[x]
            createOptionButton(option.rawValue, x)
        }
    }
    
    public func presentKeyboard() {
        searchBar.becomeFirstResponder()
    }
    
    private func createOptionButton(_ option: String, _ tag: Int) {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: option, attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium)]), for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = UIColor(named: "DarkGrey")?.withAlphaComponent(0.5)
        button.setTitleColor(UIColor(named: "BlackColor"), for: .normal)
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        button.tag = tag
        stackView.addArrangedSubview(button)
    }
    
    @objc private func didTapButton(_ sender: UIButton) {
        guard let options = viewModel?.options else { return }
        let tag = sender.tag
        let selected = options[tag]
        delegate?.searchInputView(self, didSelectOptions: selected)
    }
    
    public func update(option: SearchInputViewVM.DynamicOptions, value: String) {
        guard let buttons = stackView.arrangedSubviews as? [UIButton],
              let allOptions = viewModel?.options,
              let index = allOptions.firstIndex(of: option) else { return }
        buttons[index].setAttributedTitle(NSAttributedString(string: value.uppercased(), attributes: [.font: UIFont.systemFont(ofSize: 18, weight: .medium), .foregroundColor: UIColor.systemBlue]), for: .normal)
    }
}

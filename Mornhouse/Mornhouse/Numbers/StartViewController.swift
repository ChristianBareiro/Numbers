//
//  StartViewController.swift
//  Mornhouse
//
//  Created by Александр Колесник on 13.09.2025.
//

import UIKit
import RxSwift
import RxCocoa

fileprivate final class HistoryTableData: TableData {
    
    init(array: [MHNumber]) {
        super.init()
        sections = [firstSection(array: array)]
    }
    
    private func firstSection(array: [MHNumber]) -> MHSection {
        let section = MHSection()
        section.rows = array.map { MHRow(id: .historyNumber, data: $0) }
        return section
    }
    
}

class StartViewController: SuperViewController {
    
    @IBOutlet weak var textField: UITextField! {
        didSet {
            textField.delegate = self
        }
    }
    @IBOutlet weak var randomButton: UIButton!
    @IBOutlet weak var checkButton: UIButton! {
        didSet {
            checkButton.isEnabled = false
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModel: NumberViewModel = NumberViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listeners()
        initConstructor()
        updateHistory()
    }
    
    // MARK: - Actions
    
    @IBAction func randomAction(_ sender: UIButton) {
        sender.isEnabled = false
        Task { @MainActor in
            await viewModel.loadRandomNumber()
            sender.isEnabled = true
        }
    }
    
    @IBAction func checkAction(_ sender: UIButton) {
        sender.isEnabled = false
        Task { @MainActor in
            await viewModel.loadNumberInfo(textField.text!)
        }
    }
    
    // MARK: - Helper methods
    
    private func listeners() {
        viewModel
            .numberListener
            .applyIOSchedulers()
            .subscribe(onNext: { dbNumber in
                self.updateHistory(cache: true)
                self.textField.text = ""
                self.performSegue(withIdentifier: "fact", sender: dbNumber)
            })
            .disposed(by: disposeBag)
        
        textField
            .rx
            .text
            .orEmpty
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] text in
                self?.checkButton.isEnabled = !text.isEmpty
            })
            .disposed(by: disposeBag)
    }
    
    private func updateHistory(cache: Bool = false) {
        let array = viewModel.getNumbers(cache: cache)
        constructor?.tableData = HistoryTableData(array: array)
    }
    
    private func initConstructor() {
        constructor = MHTableConstructor(tableView: tableView, data: TableData())
        constructor?.handler = { [weak self] object in
            guard let mObject = object.object as? MHNumber else { return }
            self?.performSegue(withIdentifier: "fact", sender: mObject)
        }
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard
            let object = sender as? MHNumber,
            let vc = segue.destination as? FactViewController
        else { return }
        vc.number = object
    }

}

extension StartViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let allowedCharacters = CharacterSet.decimalDigits
        let characterSet = CharacterSet(charactersIn: string)
        return allowedCharacters.isSuperset(of: characterSet)
    }
    
}

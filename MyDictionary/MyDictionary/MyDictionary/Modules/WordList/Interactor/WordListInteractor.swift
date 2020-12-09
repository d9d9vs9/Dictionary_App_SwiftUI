//
//  WordListInteractor.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import Foundation

protocol WordListInteractor {
    var dataModel: WordListDataModel { get }
    func delete(from source: IndexSet)
    func searchTextDidChange(_ string: String)
    func searchBarCancelButtonClicked()
}

final class MYWordListInteractor: WordListInteractor {
    
    fileprivate let coreDataStack: CoreDataStack
    fileprivate let wordCoreDataService: WordCoreDataService
    fileprivate var words: [WordModel]
    let dataModel: WordListDataModel
    
    init(dataModel: WordListDataModel) {
        self.coreDataStack = CoreDataStack.init()
        self.wordCoreDataService = MYWordCoreDataService(managedObjectContext: coreDataStack.privateContext,
                                                         coreDataStack: coreDataStack)
        self.words = []
        self.dataModel = dataModel
        subscribe()
        updateWords()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

// MARK: - Delete Word
extension MYWordListInteractor {
    
    func delete(from source: IndexSet) {
        guard let uuid = source.map ({ self.dataModel.words[$0].uuid }).first else { return }
        wordCoreDataService.delete(byUUID: uuid) { [unowned self] (result) in
            switch result {
            case .success:
                self.dataModel.words.removeAll(where: { $0.uuid == uuid })
            case .failure:
                return
            }
        }
    }
    
}

// MARK: - Search Text Did Change
extension MYWordListInteractor {
    
    func searchTextDidChange(_ string: String) {
        self.updateWords(filteredWords(input: string))
    }
    
}

// MARK: - Search Bar Cancel Button Clicked
extension MYWordListInteractor {
    
    func searchBarCancelButtonClicked() {
        self.updateWords(self.words)
    }
    
}


// MARK: - Subscribe
fileprivate extension MYWordListInteractor {
    
    func subscribe() {
        addObservers()
    }
    
}

// MARK: - Add Observers
fileprivate extension MYWordListInteractor {
    
    func addObservers() {
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(didAddWordAction),
                         name: WordNSNotificationName.didAddWord,
                         object: nil)
        
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(didUpdateWordAction),
                         name: WordNSNotificationName.didUpdateWord,
                         object: nil)
    }
    
}

// MARK: - Actions
fileprivate extension MYWordListInteractor {
    
    @objc func didAddWordAction() {
        updateWords()
    }
    
    @objc func didUpdateWordAction() {
        updateWords()
    }
    
}

// MARK: - Update Words
fileprivate extension MYWordListInteractor {
    
    func updateWords() {
        fetchedWords { [unowned self] (result) in
            switch result {
            case .success(let words):
                self.updateWords(words)
                self.words = words
            case .failure(let error):
                debugPrint(#function, error)
                return
            }
        }
    }
    
    func updateWords(_ words: [WordModel]) {
        self.dataModel.words = words
    }
    
}

// MARK: - Fetched Words
fileprivate extension MYWordListInteractor {
    
    func fetchedWords(completionHandler: @escaping FetchResultWords) {
        wordCoreDataService.fetchWords(completionHandler: completionHandler)
    }
    
}

// MARK: - Filtered Words
fileprivate extension MYWordListInteractor {
    
    func filteredWords(input: String) -> [WordModel] {
        if (input.contains(Constants.StaticText.emptyString)) {
            return self.words
        } else {
            let filteredWords = words.filter ({ (wordModel) in
                return wordModel.word.lowercased().contains(input.lowercased())
            })
            return filteredWords
        }
    }
    
}

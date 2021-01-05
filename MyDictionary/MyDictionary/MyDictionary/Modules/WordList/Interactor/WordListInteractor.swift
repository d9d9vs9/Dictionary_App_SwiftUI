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
    func onAppearCell(word: WordModel)
}

final class MYWordListInteractor: WordListInteractor {
    
    fileprivate let coreDataStack: CoreDataStack
    fileprivate let wordManager: WordManager
    // Default is []
    fileprivate var words: [WordModel]
    // Default is 0
    fileprivate var fetchOffset: Int
    let dataModel: WordListDataModel
    
    init(dataModel: WordListDataModel) {
        self.coreDataStack = CoreDataStack.init()
        self.wordManager = MYWordManager(managedObjectContext: coreDataStack.privateContext,
                                                         coreDataStack: coreDataStack)
        self.words = []
        self.dataModel = dataModel
        self.fetchOffset = 0
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
        wordManager.delete(byUUID: uuid) { [unowned self] (result) in
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

// MARK: - On Appear Cell
extension MYWordListInteractor {
    
    func onAppearCell(word: WordModel) {
        self.onScrollToBottom(word: word)
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
    
    @objc func didAddWordAction(_ notification: Notification) {
        guard let word = notification.object as? WordModel else { return }
        self.dataModel.words.append(word)        
    }
    
    @objc func didUpdateWordAction(_ notification: Notification) {
        guard let word = notification.object as? WordModel else { return }
        guard let index = self.dataModel.words.firstIndex(where: { $0.uuid == word.uuid }) else { return }
        self.dataModel.words[index] = word
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
        wordManager.fetchWords(fetchLimit: Constants.CoreData.fetchLimit,
                                       fetchOffset: self.fetchOffset,
                                       completionHandler: completionHandler)
    }
    
}

// MARK: - Fetched All Words Count
fileprivate extension MYWordListInteractor {
    
    func fetchedAllWordsCount(completionHandler: @escaping FetchResultWordsCount) {
        wordManager.fetchWordsCount(completionHandler: completionHandler)
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

// MARK: - Merge Words
fileprivate extension MYWordListInteractor {
    
    func mergeWords() {
        fetchedWords { [unowned self] (result) in
            switch result {
            case .success(let words):
                self.dataModel.words.append(contentsOf: words)
                self.words.append(contentsOf: words)
            case .failure(let error):
                debugPrint(#function, error)
                return
            }
        }
    }
    
}

// MARK: - On Scroll To Bottom
fileprivate extension MYWordListInteractor {
    
    func onScrollToBottom(word: WordModel) {
        let isLastCell: Bool = (word.uuid == self.dataModel.words.last?.uuid)
        if (isLastCell) {
            self.canLoadNextWords { [unowned self] (isLoad) in
                if (isLoad) {
                    self.fetchOffset += Constants.CoreData.fetchLimit
                    self.mergeWords()
                } else {
                    return
                }
            }
        } else {
            return
        }
    }
    
}

// MARK: - Can Load Next Words
fileprivate extension MYWordListInteractor {
    
    func canLoadNextWords(completionHandler: @escaping((Bool) -> Void)) {
        fetchedAllWordsCount { [unowned self] (result) in
            switch result {
            case .success(let wordsCount):
                if (self.dataModel.words.count == wordsCount) {
                    completionHandler(false)
                } else {
                    completionHandler(true)
                }
                break
            case .failure:
                completionHandler(false)
                break
            }
        }
    }
    
}

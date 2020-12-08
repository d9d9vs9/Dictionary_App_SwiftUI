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
}

final class MYWordListInteractor: WordListInteractor {
    
    fileprivate let coreDataStack: CoreDataStack
    fileprivate let wordCoreDataService: WordCoreDataService
    let dataModel: WordListDataModel
    
    init(dataModel: WordListDataModel) {
        self.coreDataStack = CoreDataStack.init()
        self.wordCoreDataService = MYWordCoreDataService(managedObjectContext: coreDataStack.privateContext,
                                                         coreDataStack: coreDataStack)
        self.dataModel = dataModel
        subscribe()
        updateDataModel()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

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

// MARK: - Subscribe
fileprivate extension MYWordListInteractor {
    
    func subscribe() {
        addObservers()
    }
    
}

// MARK: - Subscribe
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
        updateDataModel()
    }
    
    @objc func didUpdateWordAction() {
        updateDataModel()
    }
    
}

// MARK: - Update Data Model
fileprivate extension MYWordListInteractor {
    
    func updateDataModel() {
        fetchedWords { [unowned self] (result) in
            switch result {
            case .success(let words):
                self.dataModel.words = words
            case .failure(let error):
                debugPrint(#function, error)
                return
            }
        }
    }
    
}

// MARK: - Fetched Words
fileprivate extension MYWordListInteractor {
    
    func fetchedWords(completionHandler: @escaping FetchResultWords) {
        wordCoreDataService.fetchWords(completionHandler: completionHandler)
    }
    
}

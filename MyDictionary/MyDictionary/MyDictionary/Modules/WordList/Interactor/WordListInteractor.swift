//
//  WordListInteractor.swift
//  MyDictionary
//
//  Created by Admin on 27.11.2020.
//

import Foundation

protocol WordListInteractor {
    var dataModel: WordListDataModel { get }
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
    }
    
}

// MARK: - Actions
fileprivate extension MYWordListInteractor {
    
    @objc func didAddWordAction() {
        updateDataModel()
    }
    
}

// MARK: - Update Data Model
fileprivate extension MYWordListInteractor {
    
    func updateDataModel() {
        self.dataModel.words = fetchedWords()
    }
    
}

// MARK: - Fetched Words
fileprivate extension MYWordListInteractor {
    
    func fetchedWords() -> [WordModel] {
        return wordCoreDataService.fetchWords()
    }
    
}

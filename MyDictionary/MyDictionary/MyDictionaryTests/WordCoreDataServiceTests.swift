//
//  WordCoreDataServiceTests.swift
//  MyDictionaryTests
//
//  Created by Дмитрий Чумаков on 06.12.2020.
//

import XCTest
@testable import MyDictionary

final class WordCoreDataServiceTests: XCTestCase {
    
    var coreDataStack: CoreDataStack = TestCoreDataStack()
    lazy var wordCoreDataService: WordCoreDataService = MYWordCoreDataService(managedObjectContext: coreDataStack.privateContext,
                                                                              coreDataStack: coreDataStack)
    
}

extension WordCoreDataServiceTests {
    
    func test_Add_Word() {
        let mockWord: WordModel = .init(id: UUID.init().uuidString,
                                        word: "MOSF",
                                        translatedWord: "metal–oxide–semiconductor-field")
        
        wordCoreDataService.add(word: mockWord) { [unowned self] (result) in
            switch result {
            case .success(let model):
                XCTAssertTrue(model.id == mockWord.id)
                XCTAssertTrue(model.word == mockWord.word)
                XCTAssertTrue(model.translatedWord == mockWord.translatedWord)
            case .failure:
                XCTAssertTrue(false)
            }
        }
        
    }
}

extension WordCoreDataServiceTests {
    
    func test_Fetch_Words() {
        let mockWord: WordModel = .init(id: UUID.init().uuidString,
                                        word: "MOSFC",
                                        translatedWord: "metal–oxide–semiconductor-field-c")
        
        wordCoreDataService.add(word: mockWord) { [unowned self] (result) in
            switch result {
            case .success(let model):
                
                self.wordCoreDataService.fetchWords { [unowned self] (result) in
                    switch result {
                    case .success(let fetchedWords):
                        XCTAssertTrue(model.id == fetchedWords.last?.id)
                        XCTAssertTrue(model.word == fetchedWords.last?.word)
                        XCTAssertTrue(model.translatedWord == fetchedWords.last?.translatedWord)
                    case .failure:
                        XCTAssertTrue(false)
                    }
                }
                
            case .failure:
                XCTAssertTrue(false)
            }
        }
        
    }
    
}

extension WordCoreDataServiceTests {
    
    func test_Delete_Word() {
        let mockWord: WordModel = .init(id: UUID.init().uuidString,
                                        word: "MOSFCX",
                                        translatedWord: "metal–oxide–semiconductor-field-c-x")
        
        wordCoreDataService.add(word: mockWord) { [unowned self] (result) in
            switch result {
            case .success(let model):
                XCTAssertTrue(model.id == mockWord.id)
                XCTAssertTrue(model.word == mockWord.word)
                XCTAssertTrue(model.translatedWord == mockWord.translatedWord)
                self.wordCoreDataService.delete(word: model) { [unowned self] (result) in
                    switch result {
                    case .success:
                        self.wordCoreDataService.fetchWords { [unowned self] (result) in
                            switch result {
                            case .success(let words):
                                XCTAssertFalse((words.contains(where: { $0.id == mockWord.id })))
                            case .failure:
                                XCTAssertTrue(false)
                            }
                        }
                    case .failure:
                        XCTAssertTrue(false)
                    }
                }
            case .failure:
                XCTAssertTrue(false)
            }
        }
        
    }
    
}

//
//  WordCoreDataServiceTests.swift
//  MyDictionaryTests
//
//  Created by Дмитрий Чумаков on 06.12.2020.
//

import XCTest
@testable import MyDictionary

final class WordCoreDataServiceTests: XCTestCase {
    
    fileprivate let testTimeout: TimeInterval = 20.0
    var coreDataStack: CoreDataStack = TestCoreDataStack()
    lazy var wordCoreDataService: WordCoreDataService = MYWordCoreDataService(managedObjectContext: coreDataStack.privateContext,
                                                                              coreDataStack: coreDataStack)
    
}

extension WordCoreDataServiceTests {
    
    func test_Add_Word() {
        
        let expectation = XCTestExpectation(description: "Add Word Expectation")
        
        let mockWord: WordModel = .init(id: UUID.init().uuidString,
                                        word: "MOSF",
                                        translatedWord: "metal–oxide–semiconductor-field")
        
        wordCoreDataService.add(word: mockWord) { [unowned self] (result) in
            switch result {
            case .success(let model):
                XCTAssertTrue(model.id == mockWord.id)
                XCTAssertTrue(model.word == mockWord.word)
                XCTAssertTrue(model.translatedWord == mockWord.translatedWord)
                expectation.fulfill()
            case .failure:
                XCTAssertTrue(false)
            }
        }
                
        wait(for: [expectation], timeout: testTimeout)
        
    }
}

extension WordCoreDataServiceTests {
    
    func test_Fetch_Words() {
        let expectation = XCTestExpectation(description: "Fetch Words Expectation")
        
        let mockWord: WordModel = .init(id: UUID.init().uuidString,
                                        word: "MOSFC",
                                        translatedWord: "metal–oxide–semiconductor-field-c")
                        
        wordCoreDataService.add(word: mockWord) { [unowned self] (result) in
            switch result {
            case .success(let model):
                
                self.wordCoreDataService.fetchWords { [unowned self] (result) in
                    switch result {
                    case .success(let fetchedWords):
                        XCTAssertFalse(fetchedWords.isEmpty)
                        XCTAssertTrue(model.id == fetchedWords.last?.id)
                        XCTAssertTrue(model.word == fetchedWords.last?.word)
                        XCTAssertTrue(model.translatedWord == fetchedWords.last?.translatedWord)
                        expectation.fulfill()
                    case .failure:
                        XCTAssertTrue(false)
                    }
                }
                
            case .failure:
                XCTAssertTrue(false)
            }
        }
                
        wait(for: [expectation], timeout: testTimeout)
        
    }
    
    func test_Fetch_Word_By_ID() {
        let expectation = XCTestExpectation(description: "Fetch Word Expectation")
        
        let mockWord: WordModel = .init(id: UUID.init().uuidString,
                                        word: "NFC",
                                        translatedWord: "Near-field communication")
        
        wordCoreDataService.add(word: mockWord) { [unowned self] (result) in
            switch result {
            case .success:
                self.wordCoreDataService.fetchWord(byID: mockWord.id) { [unowned self] (result) in
                    switch result {
                    case .success(let model):
                        XCTAssertTrue(model.id == mockWord.id)
                        XCTAssertTrue(model.word == mockWord.word)
                        XCTAssertTrue(model.translatedWord == mockWord.translatedWord)
                        expectation.fulfill()
                    case .failure:
                        XCTAssertTrue(false)
                    }
                }
            case .failure:
                XCTAssertTrue(false)
            }
        }
             
        wait(for: [expectation], timeout: testTimeout)
        
    }
    
}

extension WordCoreDataServiceTests {
    
    func test_Delete_Word() {
        let expectation = XCTestExpectation(description: "Delete Word Expectation")
        
        let mockWord: WordModel = .init(id: UUID.init().uuidString,
                                        word: "MOSFCX",
                                        translatedWord: "metal–oxide–semiconductor-field-c-x")
        
        wordCoreDataService.add(word: mockWord) { [unowned self] (result) in
            switch result {
            case .success(let model):
                self.wordCoreDataService.delete(byID: model.id) { [unowned self] (result) in
                    switch result {
                    case .success:
                        self.wordCoreDataService.fetchWords { [unowned self] (result) in
                            switch result {
                            case .success(let words):
                                let isContains = words.contains(where: { $0.id == mockWord.id })
                                XCTAssertFalse(isContains)
                                expectation.fulfill()
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
                
        wait(for: [expectation], timeout: testTimeout)
        
    }
    
}

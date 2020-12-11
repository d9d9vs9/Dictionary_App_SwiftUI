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
        
        let mockWord: WordModel = .init(uuid: UUID.init().uuidString,
                                        word: "MOSF",
                                        translatedWord: "metal–oxide–semiconductor-field",
                                        stringCreatedDate: ISO8601DateFormatter.init().string(from: Date.init()))
        
        wordCoreDataService.add(word: mockWord) { [unowned self] (result) in
            switch result {
            case .success(let model):
                XCTAssertTrue(model.uuid == mockWord.uuid)
                XCTAssertTrue(model.word == mockWord.word)
                XCTAssertTrue(model.translatedWord == mockWord.translatedWord)
                XCTAssertTrue(model.stringCreatedDate == mockWord.stringCreatedDate)
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
        
        let mockWord: WordModel = .init(uuid: UUID.init().uuidString,
                                        word: "MOSFC",
                                        translatedWord: "metal–oxide–semiconductor-field-c",
                                        stringCreatedDate: ISO8601DateFormatter.init().string(from: Date.init()))
        
        wordCoreDataService.add(word: mockWord) { [unowned self] (result) in
            switch result {
            case .success(let model):
                
                self.wordCoreDataService.fetchWords(fetchLimit: 0, fetchOffset: 0) { [unowned self] (result) in
                    switch result {
                    case .success(let fetchedWords):
                        XCTAssertFalse(fetchedWords.isEmpty)
                        XCTAssertTrue(model.uuid == fetchedWords.last?.uuid)
                        XCTAssertTrue(model.word == fetchedWords.last?.word)
                        XCTAssertTrue(model.translatedWord == fetchedWords.last?.translatedWord)
                        XCTAssertTrue(model.stringCreatedDate == fetchedWords.first?.stringCreatedDate)
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
    
    func test_Fetch_Word_By_UUID() {
        let expectation = XCTestExpectation(description: "Fetch Word Expectation")
        
        let mockWord: WordModel = .init(uuid: UUID.init().uuidString,
                                        word: "NFC",
                                        translatedWord: "Near-field communication",
                                        stringCreatedDate: ISO8601DateFormatter.init().string(from: Date.init()))
        
        wordCoreDataService.add(word: mockWord) { [unowned self] (result) in
            switch result {
            case .success:
                self.wordCoreDataService.fetchWord(byUUID: mockWord.uuid) { [unowned self] (result) in
                    switch result {
                    case .success(let model):
                        XCTAssertTrue(model.uuid == mockWord.uuid)
                        XCTAssertTrue(model.word == mockWord.word)
                        XCTAssertTrue(model.translatedWord == mockWord.translatedWord)
                        XCTAssertTrue(model.stringCreatedDate == mockWord.stringCreatedDate)
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
    
    func test_Fetch_Words_Count_After_One_Addition() {
        let expectation = XCTestExpectation(description: "Fetch Words Count Expectation")
        
        let mockWord: WordModel = .init(uuid: UUID.init().uuidString,
                                        word: "USB",
                                        translatedWord: "Universal Serial Bus",
                                        stringCreatedDate: ISO8601DateFormatter.init().string(from: Date.init()))
        
        wordCoreDataService.add(word: mockWord) { [unowned self] (result) in
            switch result {
            case .success:
                self.wordCoreDataService.fetchWordsCount() { [unowned self] (result) in
                    switch result {
                    case .success(let count):
                        XCTAssertTrue(count == 1)                        
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
    
    func test_Update_Word() {
        let expectation = XCTestExpectation(description: "Update Word Expectation")
        
        let mockWord: WordModel = .init(uuid: UUID.init().uuidString,
                                        word: "BLE",
                                        translatedWord: "Bluetooth Low Energy",
                                        stringCreatedDate: ISO8601DateFormatter.init().string(from: Date.init()))
        
        wordCoreDataService.add(word: mockWord) { [unowned self] (result) in
            switch result {
            case .success:
                let updatedWord: WordModel = .init(uuid: mockWord.uuid,
                                                   word: "NBA",
                                                   translatedWord: "The National Basketball Association",
                                                   stringCreatedDate: ISO8601DateFormatter.init().string(from: Date.init()))
                
                self.wordCoreDataService.update(word: updatedWord) { [unowned self] (result) in
                    switch result {
                    case .success(let updated):
                        XCTAssertTrue(updated.uuid == updatedWord.uuid)
                        XCTAssertTrue(updated.word == updatedWord.word)
                        XCTAssertTrue(updated.translatedWord == updatedWord.translatedWord)
                        XCTAssertTrue(updated.stringCreatedDate == updatedWord.stringCreatedDate)
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
        
        let mockWord: WordModel = .init(uuid: UUID.init().uuidString,
                                        word: "MOSFCX",
                                        translatedWord: "metal–oxide–semiconductor-field-c-x",
                                        stringCreatedDate: ISO8601DateFormatter.init().string(from: Date.init()))
        
        wordCoreDataService.add(word: mockWord) { [unowned self] (result) in
            switch result {
            case .success(let model):
                self.wordCoreDataService.delete(byUUID: model.uuid) { [unowned self] (result) in
                    switch result {
                    case .success:
                        self.wordCoreDataService.fetchWords(fetchLimit: 0, fetchOffset: 0) { [unowned self] (result) in
                            switch result {
                            case .success(let words):
                                let isContains = words.contains(where: { $0.uuid == mockWord.uuid })
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

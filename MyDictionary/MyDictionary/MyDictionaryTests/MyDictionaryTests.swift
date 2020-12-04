//
//  MyDictionaryTests.swift
//  MyDictionaryTests
//
//  Created by Admin on 27.11.2020.
//

import XCTest
@testable import MyDictionary

class MyDictionaryTests: XCTestCase {
    
    var coreDataStack: CoreDataStack = TestCoreDataStack()
    lazy var wordCoreDataService: WordCoreDataService = MYWordCoreDataService(managedObjectContext: coreDataStack.mainContext,
                                                                         coreDataStack: coreDataStack)
      
    
}

extension MyDictionaryTests {
    
    func test_Add_Word() {
        let mockWord: WordModel = .init(word: "MOSF",
                                        translatedWord: "metal–oxide–semiconductor-field")
        
        wordCoreDataService.add(word: mockWord) { [unowned self] (result) in
            switch result {
            case .success(let model):
                XCTAssertTrue(model.word == mockWord.word)
                XCTAssertTrue(model.translatedWord == mockWord.translatedWord)
            case .failure:
                XCTAssertTrue(false)
            }
        }
        
    }
    
    func test_Fetch_Words() {
        let mockWord: WordModel = .init(word: "MOSFC",
                                        translatedWord: "metal–oxide–semiconductor-field-c")
        
        wordCoreDataService.add(word: mockWord) { [unowned self] (result) in
            switch result {
            case .success(let model):
                
                let fetchedWords = self.wordCoreDataService.fetchWords()
                        
                XCTAssertTrue(fetchedWords.count == 1)
                XCTAssertTrue(model.word == fetchedWords.first?.word)
                
            case .failure:
                XCTAssertTrue(false)
            }
        }
                
    }
    
}

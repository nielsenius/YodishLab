//
//  YodaSpeakTests.swift
//  YodaSpeakTests
//

import Quick
import Nimble
import YodaSpeak

// extension to the String class to allow for bracket access to characters
extension String {
    
    // access a one-character substring like this: "string"[0]
    subscript (i: Int) -> String {
        return String(Array(self)[i])
    }
    
    // access a multi-character substring like this: "string"[0...2]
    subscript(integerRange: Range<Int>) -> String {
        let start = advance(startIndex, integerRange.startIndex)
        let end = advance(startIndex, integerRange.endIndex)
        let range = start..<end
        return self[range]
    }
    
}

class YodaSpeakSpec: QuickSpec {
    override func spec() {
        
        describe("YodishAPI") {
            
            describe("error handling") {
                
                it("checks for empty input") {
                    let blankRequest = YodishAPI.request("")
                    expect(blankRequest).to(equal("ERROR: sentence provided is blank"))
                    expect(blankRequest).notTo(equal(""))
                }
                
                it("checks for a valid response") {
                    expect(YodishAPI.request("This is a test.")).notTo(equal("ERROR: API request failed; make sure the URL is correct"))
                }
                
                it("checks for correct API key") {
                    expect(YodishAPI.request("This is a test.")).notTo(equal("ERROR: API key is not valid"))
                }
                
            }
            
            describe("sentence conversion") {
                
                it("converts a sentence from English to Yodish") {
                    expect(YodishAPI.request("This is a test.")[0...13]).to(equal("Test, this is."))
                    expect(YodishAPI.request("My name is Yoda.")[0...16]).to(equal("Yoda, my name is."))
                    expect(YodishAPI.request("How is it going?")[0...20]).to(equal("How going is it, hmm?"))
                }
                
            }
            
        }
        
    }
    
}

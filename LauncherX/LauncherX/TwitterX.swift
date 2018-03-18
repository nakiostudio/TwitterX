// The MIT License (MIT) - Copyright (c) 2018 Carlos Vidal
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

import AppKit

final class TwitterX {
    
    private struct Key {
        static let twitterAppURL: String = "twitterAppURL"
        static let twitterConsumerKey: String = "twitterConsumerKey"
        static let twitterConsumerSecret: String = "twitterConsumerSecret"
    }
    private static let latestVersionURL: URL = URL(string: "https://raw.githubusercontent.com/nakiostudio/TwitterX/master/version")!
    
    private let urlSession: URLSession
    private let userDefaults: UserDefaults
    private let twitterXFrameworkURL: URL!
    private let versionNumber: String!
    
    var twitterAppURL: URL? {
        didSet {
            userDefaults.set(self.twitterAppURL, forKey: Key.twitterAppURL)
        }
    }
    
    var twitterConsumerKey: String? {
        didSet {
            userDefaults.set(self.twitterConsumerKey, forKey: Key.twitterConsumerKey)
        }
    }
    
    var twitterConsumerSecret: String? {
        didSet {
            userDefaults.set(self.twitterConsumerSecret, forKey: Key.twitterConsumerSecret)
        }
    }
    
    init(urlSession: URLSession = .shared,  userDefaults: UserDefaults = .standard) {
        self.urlSession = urlSession
        self.userDefaults = userDefaults
        self.twitterAppURL = userDefaults.url(forKey: Key.twitterAppURL)
        self.twitterConsumerKey = userDefaults.string(forKey: Key.twitterConsumerKey)
        self.twitterConsumerSecret = userDefaults.string(forKey: Key.twitterConsumerSecret)
        let twitterXFrameworkPath: String = Bundle.main.path(forResource: "TwitterX", ofType: "framework")! + "/Versions/A/TwitterX"
        self.twitterXFrameworkURL = URL(fileURLWithPath: twitterXFrameworkPath)
        self.versionNumber = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }
    
    // MARK: - Public
    
    func launchTwitterApp(completion: (Bool, Error?) -> Void) {
        guard let twitterAppURL = self.twitterAppURL,
            let twitterConsumerKey = self.twitterConsumerKey,
            let twitterConsumerSecret = self.twitterConsumerSecret else {
                completion(false, nil)
                return
        }
        
        do {
            try NSWorkspace.shared.launchApplication(
                at: twitterAppURL,
                options: [],
                configuration: [.environment: [
                    "DYLD_INSERT_LIBRARIES": self.twitterXFrameworkURL.path,
                    "TWITTER_CONSUMER_KEY": twitterConsumerKey,
                    "TWITTER_CONSUMER_SECRET": twitterConsumerSecret]]
            )
            completion(true, nil)
        } catch let error {
            self.twitterAppURL = nil
            completion(false, error)
        }
    }
    
    func checkUpdates(completion: @escaping (Bool) -> Void) {
        self.urlSession.dataTask(with: TwitterX.latestVersionURL) { (data, response, error) in
            guard let data = data, error == nil,
                let json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any],
                let latestVersionNumber = json?["version_number"] as? String else {
                    DispatchQueue.main.async {
                        completion(false)
                    }
                    return
            }
            
            DispatchQueue.main.async {
                completion(latestVersionNumber.compare(self.versionNumber, options: .numeric) == .orderedDescending)
            }
        }.resume()
    }
    
}

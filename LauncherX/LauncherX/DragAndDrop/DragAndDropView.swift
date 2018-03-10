import AppKit

private extension URL {
    
    func isTwitterAppURL() -> Bool {
        return self.lastPathComponent == "Twitter.app"
    }
    
}

private extension NSDraggingInfo {
    
    func isDraggingTwitterApp() -> Bool {
        return self.twitterAppURL() != nil
    }
    
    func twitterAppURL() -> URL? {
        guard self.draggingPasteboard().canReadObject(forClasses: [NSURL.self]) else { return nil }
        let pasteboard = self.draggingPasteboard()
        let urls = pasteboard.readObjects(forClasses: [NSURL.self]) as? [URL]
        return urls?.first { $0.isTwitterAppURL() }
    }
    
}

final class DragAndDropView: NSView {
    
    private enum State {
        case idle, validDrag, invalidDrag
    }
    
    var didReceiveDragAndDropURL: ((URL) -> Void)? {
        didSet {
            if didReceiveDragAndDropURL != nil {
                self.registerForDraggedTypes([.fileURL])
                return
            }
            self.unregisterDraggedTypes()
        }
    }
    
    // MARK: - Overridden
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setup()
    }
    
    override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        return sender.isDraggingTwitterApp()
    }
    
    override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        let allow = sender.isDraggingTwitterApp()
        self.updateAppearance(forState: allow ? .validDrag : .invalidDrag)
        return allow ? .copy : NSDragOperation()
    }
    
    override func draggingExited(_ sender: NSDraggingInfo?) {
        self.updateAppearance(forState: .idle)
    }
    
    override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        defer {
            self.updateAppearance(forState: .idle)
        }
        
        if let twitterURL = sender.twitterAppURL() {
            self.didReceiveDragAndDropURL?(twitterURL)
            return true
        }
        
        return false
    }
    
    // MARK: - Private
    
    private func setup() {
        self.alphaValue = 0.0
        self.wantsLayer = true
        self.layer?.borderWidth = 1.0
        self.layer?.cornerRadius = 4.0
    }
    
    private func updateAppearance(forState state: State) {
        switch state {
        case .idle:
            self.alphaValue = 0.0
        case .validDrag:
            self.alphaValue = 0.2
            self.layer?.backgroundColor = NSColor(calibratedRed: 105.0/255.0, green: 110.0/255.0, blue: 135.0/255.0, alpha: 1.0).cgColor
            self.layer?.borderColor = NSColor.white.cgColor
        case .invalidDrag:
            self.alphaValue = 0.2
            self.layer?.backgroundColor = NSColor(calibratedRed: 214.0/255.0, green: 117.0/255.0, blue: 117.0/255.0, alpha: 1.0).cgColor
            self.layer?.borderColor = NSColor(calibratedRed: 1.0, green: 169.0/255.0, blue: 169.0/255.0, alpha: 1.0).cgColor
        }
    }
    
}

//
//  SUWebView.swift
//  
//
//  Created by JSilver on 2023/03/24.
//

import SwiftUI
import WebKit

public struct SUWebView: UIViewRepresentable {
    public class Coordinator: NSObject, ObservableObject, WKUIDelegate, WKNavigationDelegate {
        // MARK: - Property
        @Binding
        private var url: URL?
        
        var onProgressChange: ((Double) -> Void)?
        
        var onCreateWebView: ((WKWebViewConfiguration, WKNavigationAction, WKWindowFeatures) -> Bool)?
        
        var onCommit: ((WKNavigation) -> Void)?
        var onFinish: ((WKNavigation) -> Void)?
        var onFail: ((WKNavigation, Error) -> Void)?
        var onNavigationAction: ((WKNavigationAction, WKWebpagePreferences) async -> (WKNavigationActionPolicy, WKWebpagePreferences))?
        var onNavigationResponse: ((WKNavigationResponse) async -> WKNavigationResponsePolicy)?
        
        private weak var webView: WKWebView?
        private var webViewObservations: [NSKeyValueObservation]?
        
        // MARK: - Initializer
        init(url: Binding<URL?>) {
            self._url = url
        }
        
        // MARK: - Lifecycle
        public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            guard !(onCreateWebView?(configuration, navigationAction, windowFeatures) ?? false) else {
                return nil
            }
            
            guard navigationAction.targetFrame == nil else {
                return nil
            }
            
            webView.load(navigationAction.request)
            return nil
        }
        
        public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
            onCommit?(navigation)
        }
        
        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            onFinish?(navigation)
        }
        
        public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            onFail?(navigation, error)
        }
        
        public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, preferences: WKWebpagePreferences, decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void) {
            Task {
                let decision = await onNavigationAction?(navigationAction, preferences)
                decisionHandler(decision?.0 ?? .allow, decision?.1 ?? preferences)
            }
        }
        
        public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
            Task {
                let decision = await onNavigationResponse?(navigationResponse)
                decisionHandler(decision ?? .allow)
            }
        }
        
        // MARK: - Public
        func bind(webView: WKWebView) {
            self.webView = webView
            
            webViewObservations = [
                observeWebView(webView, \.url) { [weak self] in self?.url = $0 },
                observeWebView(webView, \.estimatedProgress) { [weak self] in self?.onProgressChange?($0) }
            ]
        }
        
        // MARK: - Private
        private func observeWebView<Value>(
            _ webView: WKWebView,
            _ keyPath: KeyPath<WKWebView, Value>,
            changeHandler: @escaping (Value) -> Void
        ) -> NSKeyValueObservation {
            webView.observe(keyPath, options: [.new]) { view, value in
                Task {
                    await MainActor.run {
                        changeHandler(value.newValue ?? view[keyPath: keyPath])
                    }
                }
            }
        }
    }
    
    // MARK: - Property
    @Binding
    private var url: URL?
    
    private var onProgressChange: ((Double) -> Void)?
    
    private var onCreateWebView: ((WKWebViewConfiguration, WKNavigationAction, WKWindowFeatures) -> Bool)?
    
    private var onCommit: ((WKNavigation) -> Void)?
    private var onFinish: ((WKNavigation) -> Void)?
    private var onFail: ((WKNavigation, Error) -> Void)?
    private var onNavigationAction: ((WKNavigationAction, WKWebpagePreferences) async -> (WKNavigationActionPolicy, WKWebpagePreferences))?
    private var onNavigationResponse: ((WKNavigationResponse) async -> WKNavigationResponsePolicy)?
    
    // MARK: - Initializer
    public init(url: Binding<URL?>) {
        self._url = url
    }
    
    // MARK: - Lifecycle
    public func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        
        let view = WKWebView(frame: .zero, configuration: configuration)
        view.backgroundColor = .clear
        view.isOpaque = false
        
        view.uiDelegate = context.coordinator
        view.navigationDelegate = context.coordinator
        
        context.coordinator.bind(webView: view)
        
        return view
    }
    
    public func updateUIView(_ uiView: WKWebView, context: Context) {
        context.environment.suWebViewContainer?.webView = uiView
        
        context.coordinator.onProgressChange = onProgressChange
        
        context.coordinator.onCreateWebView = onCreateWebView
        
        context.coordinator.onCommit = onCommit
        context.coordinator.onFinish = onFinish
        context.coordinator.onFail = onFail
        context.coordinator.onNavigationAction = onNavigationAction
        context.coordinator.onNavigationResponse = onNavigationResponse
        
        if let url, url != uiView.url {
            uiView.load(URLRequest(url: url))
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(url: $url)
    }
    
    // MARK: - Public
    public func onProgressChange(_ action: @escaping (Double) -> Void) -> Self {
        var view = self
        view.onProgressChange = action
        return view
    }
    
    public func onCreateWebView(_ action: @escaping (WKWebViewConfiguration, WKNavigationAction, WKWindowFeatures) -> Bool) -> Self {
        var view = self
        view.onCreateWebView = action
        return view
    }
    
    public func onCommit(_ action: @escaping (WKNavigation) -> Void) -> Self {
        var view = self
        view.onCommit = action
        return view
    }
    
    public func onFinish(_ action: @escaping (WKNavigation) -> Void) -> Self {
        var view = self
        view.onFinish = action
        return view
    }
    
    public func onFail(_ action: @escaping (WKNavigation, Error) -> Void) -> Self {
        var view = self
        view.onFail = action
        return view
    }
    
    public func onNavigationAction(_ action: @escaping (WKNavigationAction, WKWebpagePreferences) async -> (WKNavigationActionPolicy, WKWebpagePreferences)) -> Self {
        var view = self
        view.onNavigationAction = action
        return view
    }
    
    public func onNavigationResponse(_ action: @escaping (WKNavigationResponse) async -> WKNavigationResponsePolicy) -> Self {
        var view = self
        view.onNavigationResponse = action
        return view
    }
    
    // MARK: - Private
}

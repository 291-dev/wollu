import React from 'react';
import ReactDOM from 'react-dom/client';
import reportWebVitals from './reportWebVitals';
import AppDownloadView from './Js/AppDownloadView.jsx';
const AppDownloadRoot = ReactDOM.createRoot(document.getElementById('WolluAppDownloadRoot'));
AppDownloadRoot.render(
    <React.StrictMode>
        <AppDownloadView></AppDownloadView>
    </React.StrictMode>
)
reportWebVitals();

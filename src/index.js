import React from 'react';
import ReactDOM from 'react-dom/client';
import './index.css';
import reportWebVitals from './reportWebVitals';
import Wollu from "./Js/Wollu.js";
import AppDownloadView from './Js/AppDownloadView';
import { BrowserRouter, } from 'react-router-dom';
import { Routes ,Route } from 'react-router-dom';
const root = ReactDOM.createRoot(document.getElementById('root'));
root.render(
  <React.StrictMode>
    <BrowserRouter>
      <Routes>
      <Route exact path="/" component={Wollu} />
      <Route exact path="/AppDownload" component={AppDownloadView} />
      </Routes>
    </BrowserRouter>

    <Wollu/>
  </React.StrictMode>
);

// If you want to start measuring performance in your app, pass a function
// to log results (for example: reportWebVitals(console.log))
// or send to an analytics endpoint. Learn more: https://bit.ly/CRA-vitals
reportWebVitals();

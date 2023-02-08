import "../CssUtil/Color.css";
import "../CssUtil/Font.css";
import "../CssUtil/Effects.css";

import React, {useState} from 'react';
import styled from 'styled-components';

export default function Background() {
  var window_width = window.innerWidth;
  var window_height = window.innerHeight;

  if (window_width < 1000){
    window_width = 375;
  }

  const EntireCSS = styled.div`
    background-color: var(--main-background-color);
    width: ${window_width};
    height: ${window_height};
  `;
  return (
    <>
      <EntireCSS>
        
      </EntireCSS>
    </>
  );
}
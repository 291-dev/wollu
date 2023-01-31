import React from 'react';
import styled from 'styled-components';
import "../Css/WolluAppAggroView.css";
import WolluAppAggroCardSelection2 from "../Resources/Images/WolluAppAggroCardSelection2.svg";

export default function WolluAggroCard({ text1, text2 }) {
  return (
    <div className="WolluAppAggroCard">
    <div id="wolluAppAggroText">
      {text1}
      <br/>
      {text2}
      <div id="wolluAppAggroSpace8"/>
    </div>
    <img src={WolluAppAggroCardSelection2} id="WolluAppAggroCardSelection2"/>
  </div>
  )   
}
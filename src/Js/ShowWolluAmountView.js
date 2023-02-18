import '../Css/ShowWolluAmountView.css';
import '../CssUtil/CardStyle.css';
import '../CssUtil/Spaces.css';
import '../CssUtil/Utils.css';
import '../CssUtil/Font.css';
import '../CssUtil/Effects.css';
import ShowWolluImageBorder from "../Resources/Images/ShowWolluImageBorder.svg";
import ShowWolluImageEffect from "../Resources/Images/ShowWolluImageEffect.svg";
import EatWolluImage from "../Resources/Images/EatWolluImage.svg";
import React, {useState} from 'react';

function ShowWolluAmountView(salaryText,workingTimeText,wolluMinuteText,wolluItem,showWolluText,roopangText,setRoopangText,wolluItemSelected) {
  var wolluAmount = "?";
  if (!isNaN(wolluMinuteText) && "a" == "a"){
    if(!isNaN(workingTimeText)){
      if(!isNaN(salaryText)){
        wolluAmount = parseInt(wolluMinuteText * (salaryText/20/workingTimeText/60 * 10000));
      }
    }
  }
  else {
    wolluAmount = "?";
  }
      
  return (
    <div>
     <div class="card">
      <div class="face face--front">
        <div className="ShowWolluAmountView" id="ShowCardEmpty" ></div>
      </div>
      <div class="face face--back">

      <div className="ShowWolluAmountView" id="ShowCard" >
          <div className="CombineImages">
        <img src={ShowWolluImageBorder} id="showWolluImageBorder"/>
        <img src={ShowWolluImageEffect} id="showWolluImageEffect"/>
        <div className="InterRegular" id="showWolluTextBoundary">
            <div className="Inline" id="showWolluFactorText">{showWolluText}</div>
            <div className="Inline" id="showWolluText1">로</div>
            <br/>
            <div id="showWolluSpace2"/>
            <div className="Inline" id="showWolluFactorText2">{wolluAmount}원</div>
            <div className="Inline" id="showWolluText2">루팡중입니다!</div>               
        </div>
        <img src={EatWolluImage} id="eatWolluImage"/>
        <div id="showWolluNameBox">
            <div className="Rebecca" id="showWolluNameText"> {roopangText}</div>
        </div>
      </div>
    </div>
      </div>
  </div>
    </div>
  );
}

export default ShowWolluAmountView;
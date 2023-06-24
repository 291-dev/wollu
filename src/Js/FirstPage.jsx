import "../CssUtil/Color.css";
import "../CssUtil/Font.css";
import "../CssUtil/Effects.css";
import WolluTextImage from "../Resources/Images/MainView_WolluMainImage.svg";
import MainView_291LogoImage from "../Resources/Images/MainView_291LogoImage.svg";
import React from 'react';
import styled from "styled-components";

export default function FirstPage() {
    // initialize
    var window_width = window.innerWidth;
    var window_height = window.innerHeight;
  
    if (window_width < 375){
      window_width = 375;
    }
    const Background = styled.div`
      width:${window_width}px;
      height:${window_height}px;
      background-color: var(--main-background-color);
      display:flex;
      justify-content: center;
      //align-items: center;
    `;

    const WolluIntroText = styled.div`
      font-family:"puradack";
      font-weight:normal;
      font-size:18px;
      color:var(--main-color);
      text-align: center;
    `;

    const WolluMainImage = styled.img`
      padding-top: 8px;
    `;

    const Contents = styled.div`
      margin-top: ${window_height/100*38.42}px;
    `;


    const BottomContent = styled.div`
      display:flex;
      justify-content: center;
      margin-top: ${window_height/100*41}px;
    `;

    const TeamLogo = styled.img`
      width: 85px;
      height: 33px;
    `; 
  return (
    <Background>
      <Contents>
        <WolluIntroText>사장님 돈은 제가 가져갑니다!</WolluIntroText>
        <WolluMainImage src={WolluTextImage}/>
        <BottomContent>
          <TeamLogo src={MainView_291LogoImage}></TeamLogo>
        </BottomContent>
      </Contents>
    </Background>
  );
}
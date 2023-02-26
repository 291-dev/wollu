import React,{useState} from 'react';
import styled from 'styled-components';
import "../CssUtil/Color.css";
import "../CssUtil/Font.css";
import "../CssUtil/Effects.css";
import ShowWolluImageBorder from "../Resources/Images/ShowWolluImageBorder.svg";
import ShowWolluImageEffect from "../Resources/Images/ShowWolluImageEffect.svg";
import EatWolluImage from "../Resources/Images/EatWolluImage.png";
import "./fourthpage.css";
import ReactCardFlip from 'react-card-flip';

export default function FourthPage(showWolluInfo){
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

    const card_height = window_height*0.8578;
    const card_width = card_height * 0.4842;
    const card_margin_top = (window_height - card_height) / 2;

    const Card = styled.div`
      margin-top: ${card_margin_top}px;
      width:${card_width}px;
      height:${card_height}px;
      background-color: #FFFFFF;
      border-radius: 12px;
      filter : drop-shadow(0px 0px 1px #8294EF);      
      background-color: var(--main-color);
    `;
    const CardBack = styled.div`
        margin-top: ${card_margin_top}px;
        width:${card_width}px;
        height:${card_height}px;
        background-color: var(--main-color);
        border-radius: 12px;
        filter : drop-shadow(0px 0px 1px #8294EF);
      `;
  
    const CombineImages = styled.div`
        position: relative;
    `;

    const BorderImage = styled.img`
      position: absolute;
      left: ${15/339*card_width}px;
      top: ${15/700*card_height}px;
      height: ${668/700*card_height}px;
    `;

    const BackEffect = styled.img`
      position: absolute;
      height: ${638/700*card_height}px;
      left: ${31/339*card_width}px;
      top: ${31/700*card_height}px;
      opacity: 0.2;
    `;
    

    const WolluTextField = styled.div`
      padding-top: ${132/700*card_height}px;
      //margin-left: ${54/339*card_width}px;
      margin-left : auto;
      margin-right : auto;
      font-family: "inter_regular";
      line-height: 145%;
      font-size: ${24/700*card_height}px;
      width:max-content;
      text-align: center;
    `;

    const FocusText = styled.div`
      background-color: white;
      color: var(--main-color);
      display:inline;
    `;
    const BR = styled.div`
      padding-top: ${5/700*card_height}px;
    `;
    const UnFocusText = styled.div`
      color:white;
      display:inline;
    `;

    const WolluImage = styled.img`
      position: absolute;
      margin-top: ${196/700*card_height}px;
      margin-left: ${34/339*card_width}px;
      height:${350/700*card_height}px;
      width:${270/339*card_width}px;
    `;

    const WolluName = styled.div`
      margin-top:${344/700*card_height}px;
      margin-left:${59/339*card_width}px;
      width:${221/339*card_width}px;
      height:${49/700*card_height}px;
      background-color: var(--main-color);
      position:absolute;
      text-align: center;
      border-color: white;
      box-shadow: 0 0 0 ${4/339*card_width}px #FFFFFF inset;
      border-radius: ${7/700*card_height}px;
      display: flex;
      justify-content: center;
      align-content: center;
    `;

    const WolluNameText = styled.div`
      padding-top:${5/700*card_height}px;
      color: white;
      font-family: "rebecca";
      font-size: ${24/700*card_height}px;
      margin-top: auto;
      margin-bottom: auto;
    `;

    let TestCard = styled.div`
      
      position: relative;
      margin-top: ${card_margin_top}px;
      width: ${card_width}px;
      height:${card_height}px;
      float:left;
      border-radius: 12px;
      perspective: 500px;
      `;

    const TestContent = styled.div`
      position: absolute;
      width: 100%;
      height: 100%;
      box-shadow: 0 0 15px rgba(0,0,0,0.1);
      transition: transform 1s;
      border-radius: 12px;
      transform-style: preserve-3d;
    `;
    const FrontCard = styled.div`
      position : absolute;
      height: 100%;
      width : 100%;
      background-color: white;
      border-radius: 12px;
      backface-visibility: hidden;
    `;


    const BackCard = styled.div`
      position : absolute;
      height: 100%;
      width : 100%;
      transform: rotateY(180deg);
      backface-visibility: hidden;
      border-radius: 12px;
      background-color: var(--main-color);
    `;


    var clicked_var = false;
    const cardClicked = () => {

      let testContent = document.querySelector('.content');
      if (clicked_var){
        testContent.classList.add("card_flip_active");
        clicked_var = false;
      } else {
        testContent.classList.remove("card_flip_active");
        clicked_var = true;
      }

    };
    return (
      <Background>
      <TestCard onClick={cardClicked}>
        <TestContent className='content'>
          <FrontCard className="showFrontColor">
          </FrontCard>
          <BackCard className="showBackColor">
                    <CombineImages>
                      <BorderImage className="showBackColor" src={ShowWolluImageBorder}/>
                      <BackEffect className="showCardEffect" src={ShowWolluImageEffect}/>
                      <WolluImage className="showWolluImage" src={EatWolluImage}/>
                      <WolluTextField>
                        <FocusText className = "showWolluFactor" id="showText1">커피/간식먹기</FocusText>
                        <UnFocusText className="hideText1">로</UnFocusText>
                        <BR/>
                        <FocusText className = "showWolluAmount" id="showText2">12,500원</FocusText>
                        <UnFocusText className="hideText2"> 루팡중입니다!</UnFocusText>
                      </WolluTextField>
                      <WolluName className = "showBackColor2">
                        <WolluNameText className="showWolluTitle">
                          간식루팡
                        </WolluNameText>
                      </WolluName>
                    </CombineImages>
                  </BackCard>
        </TestContent>
      </TestCard>
  </Background>
        /*
              <Background>
        <div class="card">
        <div class="content">
          <div class="front">
            front
          </div>
          <div class="back">
            back
          </div>
        </div>
        </div>
    </Background>
         */
      /*
        <Background>
            <Card className="showBackColor">
              <CombineImages>
                <BorderImage className="showBackColor" src={ShowWolluImageBorder}/>
                <BackEffect className="showCardEffect" src={ShowWolluImageEffect}/>
                <WolluImage className="showWolluImage" src={EatWolluImage}/>
                <WolluTextField>
                  <FocusText className = "showWolluFactor" id="showText1">커피/간식먹기</FocusText>
                  <UnFocusText className="hideText1">로</UnFocusText>
                  <BR/>
                  <FocusText className = "showWolluAmount" id="showText2">12,500원</FocusText>
                  <UnFocusText className="hideText2"> 루팡중입니다!</UnFocusText>
                </WolluTextField>
                <WolluName className = "showBackColor2">
                  <WolluNameText className="showWolluTitle">
                    간식루팡
                  </WolluNameText>
                </WolluName>
              </CombineImages>
            </Card>
        </Background>
      */
    );
}

function MyImage(content, w, h) {
  return (
    <img 
      src={EatWolluImage}
      alt="My Image"
      style={{ width: w, height: h }}
    />
  );
}
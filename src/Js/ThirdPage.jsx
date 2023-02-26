
import React, {useState, useEffect} from 'react';
import styled, { keyframes } from 'styled-components';
import "../Css/WolluItemBottomSheet.css";
import "../CssUtil/Color.css";
import "../CssUtil/Font.css";
import RotatingCircle from "../Resources/Images/RotatingCircle.png";
import FloatingMoney from "../Resources/Images/FloatingMoney.svg";
import GetWolluView_WolluImage from "../Resources/Images/GetWolluView_WolluImage.svg";
import BottomArrrow from "../Resources/Images/InputBottomArrowImage.svg";
import BottomSheet from './BottomSheet';

export default function ThirdPage(salaryInfo, wolluInfo, showWolluInfo){

    const onWolluMinuteChange = (e) => {
        
        if (isNaN(e.target.value)) {
            e.target.value = "";
            alert("숫자만 입력해주세요");
        }  else {
            if (Number(e.target.value) > 60 * 24 ){
                alert("하루를 초과한 시간은 할 수 없습니다.");
                e.target.value = 60 * 24;
            } else if (salaryInfo.workingTime * 60 < e.target.value){
                alert("일한 시간보다 많을 수 없습니다.");
                e.target.value = "";
            }
            wolluInfo.wolluTime = e.target.value;
        }
    };

    const showBottomSheet = () => {
        let container = document.querySelector(".Container");
        let bottomSheet = document.querySelector(".Container .BottomSheetContent")
        container.classList.add("active");
        setTimeout(() => {
            bottomSheet.classList.add("active");
        }, 1);
    };
    let test_value = "";
    const bottomSheet = BottomSheet(wolluInfo, showWolluInfo,test_value);

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
    filter : drop-shadow(rgba(130,148,239,0.2) 0px 0px 20px);
    `;

    const WolluTextFiled = styled.div`
        margin-top: ${72/700 * card_height}px;
        background-color: white;
        width: ${221/339 * card_width}px;
        height: ${52/700 * card_height}px;
        margin-left:auto;
        margin-right:auto;
        filter : drop-shadow(0px 0px 1px rgba(0,0,0,0.3));
        display: flex;
        justify-content: center;
        align-items: center;
        border-radius: 8px;
    `;

    const WolluTextFieldInner = styled.div`
        background-color: var(--main-color);
        padding-top : ${0/700 * card_height}px;
        width: ${(221-5)/339 * card_width}px;
        height: ${(52-5)/700 * card_height}px;
        display: flex;
        justify-content: center;
        align-items: center;
        font-family: "rebecca";
        font-weight: normal;
        font-size: ${24/700 * card_height}px;
        border-radius: 8px;
        //line-height: 145%;
        color:white;
    `;

    const TextFieldImageMargin = styled.div`
        margin-top:${56.94/700 * card_height}px;
        margin-left: auto;
        margin-right: auto;
        width:${292.2/339 * card_width}px;
        height:${312.4/700 * card_height}px;
        position:relative;
    `;

    const money_height = 55.48/700 * card_height
    const moneyEffect = keyframes`
    50% {
        transform: rotate(30deg);
    }
    50% {
        transform: rotate(-30deg);
    }
`;
    const MoneyImage = styled.img`
        right:0px;
        height: ${money_height}px;
        position: absolute;
        z-index: 5;
        animation: ${moneyEffect} 3s linear infinite; transform-origin: 50% 50%;
    `;

    const rotatingEffect = keyframes`
        100% {
            transform: rotate(360deg);
        }
    `;
    const RotatingImage = styled.img`
        top:${21.44/700*card_height}px;
        height:${290.96/700*card_height}px;
        position:absolute;
        z-index: 2;
        animation: ${rotatingEffect} 2s linear infinite; transform-origin: 50% 50%;
    `;

    const WolluImage = styled.img`
        top:${42.93/700*card_height}px;
        height:${256.54/700*card_height}px;
        position:absolute;
        left:${17.52/282.65 * card_width}px;
    `;

    const TextField = styled.div`
        margin-top:${60.67/700 * card_height}px;
        margin-left:${27/339*card_width}px;
        width:max-content;
        height:max-content;
    `;
    const TextInRow = styled.div`
        display:inline-block;
    `;
    const pretendard_font_size = 24/700 * card_height;
    const text_between_margin = 11/700 * card_height;
    const TextMarginTop = styled.div`
    margin-top:${text_between_margin}px;
  `;
    const TextStyleInlineFront = styled.div`
        font-family: "pretendard_light";
        font-weight: normal;
        line-height: 145%;
        font-size: ${pretendard_font_size}px;
        color: var(--gray01-color);
        display:inline-block;
        margin-right:${text_between_margin}px;
    `;
    const TextStyleInlineBack = styled.div`
        font-family: "pretendard_light";
        font-weight: normal;
        line-height: 145%;
        font-size: ${pretendard_font_size}px;
        color: var(--gray01-color);
        display:inline-block;
        margin-left:${text_between_margin}px;
    `;

    const InputTextField = styled.input`
        font-family: "pretendard_light";
        font-size: ${pretendard_font_size}px;
        color: var(--gray01-color);
        border-color: #FFFFFF;
        line-height: 145%;
        border-radius: 4px;
        border-width: 0px;
        width : ${175/339 * card_width}px;
        text-align: center;
        display: inline-block;
        filter : drop-shadow(0px 0px 20px rgba(43, 53, 139, 0.1));
        :focus{
        font-family: "pretendard_medium";
        color: var(--main-color);
        filter : drop-shadow(0px 0px 0px rgba(43, 53, 139, 0.1));
        border-color: var(--main-color);
        border-width: 1px;
        }
    `;
    const BottomArrowImage = styled.img`
        position:absolute;
    `;
    const InputTextField2 = styled.input`
        font-family: "pretendard_light";
        font-size: ${pretendard_font_size}px;
        color: var(--gray01-color);
        border-color: #FFFFFF;
        line-height: 145%;
        border-radius: 4px;
        border-width: 0px;
        width : ${62/339 * card_width}px;
        height : ${30/700 * card_height}px;
        text-align: center;
        display: inline-block;
        filter : drop-shadow(0px 0px 20px rgba(43, 53, 139, 0.1));
        :focus{
          font-family: "pretendard_medium";
          color: var(--main-color);
          border-color: var(--main-color);
          filter : drop-shadow(0px 0px 0px rgba(43, 53, 139, 0.1));
          border-width: 1px;
          outline: 0;
        }
    `;

    function prevent_tabkey(event) {
        if (event.key === 'Tab') {
        event.preventDefault();
        }
    }
    return (
      <Background>
        {bottomSheet}
      <Card>
        <WolluTextFiled>
            <WolluTextFieldInner>월루중</WolluTextFieldInner>
        </WolluTextFiled>
        <TextFieldImageMargin>
            <RotatingImage src={RotatingCircle}/>
            <MoneyImage src={FloatingMoney}/>   
            <WolluImage src={GetWolluView_WolluImage}/>     
        </TextFieldImageMargin>
        <TextField>
            <TextInRow>
              <TextStyleInlineFront>오늘</TextStyleInlineFront>
              <InputTextField className="WolluFactor" placeholder="월루 항목 선택" onClick={showBottomSheet} readOnly onKeyDown={prevent_tabkey}></InputTextField>
              <TextStyleInlineBack>으로</TextStyleInlineBack>
            </TextInRow>
            <TextMarginTop/>
            <TextInRow>
              <InputTextField2 placeholder="00" onChange={onWolluMinuteChange} onKeyDown={prevent_tabkey}></InputTextField2>
              <TextStyleInlineBack>분 월루했습니다.</TextStyleInlineBack>
            </TextInRow>
        </TextField>
      </Card>
      </Background>  
    );
};

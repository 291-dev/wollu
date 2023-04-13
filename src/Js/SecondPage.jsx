import "../CssUtil/Color.css";
import "../CssUtil/Font.css";
import "../CssUtil/Effects.css";

import styled from "styled-components";
import '../CssUtil/CardStyle.css';
import GetSalaryView_MainImage from "../Resources/Images/GetSalaryView_MainImage.svg";
import '../CssUtil/TextStyle.css';
import '../CssUtil/Spaces.css';
import '../CssUtil/Utils.css'
import React, {useState} from 'react';
import {useRef,useEffect} from 'react';
import { BrowserView, MobileView } from "react-device-detect";
import { useHref } from "react-router-dom";

export default function SecondPage(salaryInfo) {
    const onNickNameChange = (e) => {
      // replace string
      var reg = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
      e.target.value = e.target.value.replace(reg,'');      
      
      if ([...e.target.value].length > 7) {
        alert("7자리 아래로 만들어주세요");
        e.target.value = e.target.value.slice(0,-1);
      }
      //nickNameText = e.target.value;
      salaryInfo.nickName = e.target.value;
    };
  
    const onSalaryChange = (e) => {
      
      if (isNaN(e.target.value)) {
        alert("숫자만 입력해주세요");
        e.target.value = "";
      }  else {
        if (e.target.value > 10000) {
          alert("월급 1억 이상은 계산을 못합니다..");
          e.target.value = "";
        }
        //salaryText = e.target.value;
        salaryInfo.salary = e.target.value;
      }
    };
  
    const onWorkingTimeChange = (e) => {
      if ( isNaN(e.target.value)) {
        e.target.value = "";
        alert("숫자만 입력해주세요");
      } else {
        if (e.target.value > 24) {
          alert("24시간 이상은 입력할 수 없습니다.");
          e.target.value = "";
        } else if (e.target.value < 0) {
          alert("음수는 입력이 안됩니다");
        }
        //workingTimeText = e.target.value;
        salaryInfo.workingTime = e.target.value;
      }
    };

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
      //filter : drop-shadow(0px 0px 1px #8294EF);
      filter : drop-shadow(rgba(130,148,239,0.2) 0px 0px 20px);
    `;

    const image_height = card_height * 0.6271;
    const UpperImage = styled.img`
      float: right;
      height: ${image_height}px;
      object-fit: contain;
    `;

    const textbox_margin_top = card_height * 0.04;
    const textbox_margin_left = 28/339 * card_width;
    const TextBox = styled.div`
      margin-top: ${image_height + textbox_margin_top}px;
      width : max-content;
      height : min-content;
      margin-left: ${textbox_margin_left}px;
    `;

    const pretendard_font_size = 24/700 * card_height;
    const TextStyle = styled.div`
      font-family: "pretendard_light";
      font-weight: normal;
      line-height: 145%;
      font-size: ${pretendard_font_size}px;
      color: var(--gray01-color);
    `;

    const text_between_margin = 11/700 * card_height;
    const TextMarginTop = styled.div`
      margin-top:${text_between_margin}px;
    `;

    const TextInRow = styled.div`
      display:inline-block;
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
      color: var(--main-color);
      border-color: #FFFFFF;
      line-height: 145%;
      border-radius: 4px;
      border-width: 0px;
      width : ${102/339 * card_width}px;
      height : ${30/700 * card_height}px;
      text-align: center;
      display: inline-block;
      filter : drop-shadow(0px 0px 20px rgba(43, 53, 139, 0.1));
      :focus{
        font-family: "pretendard_medium";
        border-width: 1px;
        color: var(--main-color);
        border-color: var(--main-color);
        filter : drop-shadow(0px 0px 0px rgba(43, 53, 139, 0.1));
        outline: 0;
      }
      ::placeholder{
            color: #E8E9F5;
        }
      `;

      

    const InputTextField2 = styled.input`
        font-family: "pretendard_light";
        font-size: ${pretendard_font_size}px;
        color: var(--main-color);
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
        ::placeholder{
            color: #E8E9F5;
        }
        `;

    const InputTextField3 = styled.input`
      font-family: "pretendard_light";
      font-size: ${pretendard_font_size}px;
      color: var(--main-color);
      border-color: #FFFFFF;
      line-height: 145%;
      border-radius: 4px;
      border-width: 0px;
      width : ${34/339 * card_width}px;
      height : ${30/700 * card_height}px;
      text-align: center;
      display: inline-block;
      filter : drop-shadow(0px 0px 20px rgba(43, 53, 139, 0.1));
      :focus{
        font-family: "pretendard_medium";
        color: var(--main-color);
        border-color: var(--main-color);
        filter : drop-shadow(0px 0px 0px rgba(43, 53, 139, 0.1));
        outline: 0;
        border-width: 1px;
      }
      ::placeholder{
            color: #E8E9F5;
        }
      `;

    function prevent_tabkey(event) {
      if (event.key === 'Tab') {
        event.preventDefault();
      }
    }
    
    return (
      <React.StrictMode>
      <Background>
        <Card>
          <UpperImage src={GetSalaryView_MainImage}/>
          <TextBox>
            <TextStyle>사장님, 안녕하세요.</TextStyle>
            <TextMarginTop/>
            <TextInRow>
              <TextStyleInlineFront>저</TextStyleInlineFront>
              <InputTextField placeholder="000" onChange={onNickNameChange} ></InputTextField>
              <TextStyleInlineBack>은/는</TextStyleInlineBack>
            </TextInRow>
            <TextMarginTop/>
            <TextInRow>
              <TextStyleInlineFront>월급</TextStyleInlineFront>
              <InputTextField2 placeholder="00" onChange={onSalaryChange}></InputTextField2>
              <TextStyleInlineBack>만원을 받고</TextStyleInlineBack>
            </TextInRow>
            <TextMarginTop/>
            <TextInRow>
              <TextStyleInlineFront>하루</TextStyleInlineFront>
              <InputTextField3 placeholder="0" onChange={onWorkingTimeChange} onKeyDown={prevent_tabkey}></InputTextField3>
              <TextStyleInlineBack>시간 근무합니다</TextStyleInlineBack>
            </TextInRow>
          </TextBox>
        </Card>
      </Background>
      </React.StrictMode>
    );
  }
import '../Css/Wollu.css';
import MainView from "./MainView.js";
import GetSalaryView from './GetSalaryView';
import GetWolluView from './GetWolluView';
import ShowWolluAmountView from './ShowWolluAmountView';
import WolluAppAggroView from './WolluAppAggroView';
import React, {useState} from 'react';
import WolluItemBottomSheet from './WolluItemBottomSheet';
import Slider from "./Slider";
import WolluAggroCardSlider from "./WolluAggroCardSlider";

import AppDownloadView from "./AppDownloadView";
import ScrollTest from "./ScrollTest";
import { BrowserRouter, Routes, Route } from 'react-router-dom';

import Background from './BackGround';

import FirstPage from "./FirstPage";
import styled from 'styled-components';
import "../CssUtil/Color.css";
import SecondPage from './SecondPage';
import "./ScrollTest.css";
import {useRef,useEffect} from 'react';
import ThirdPage from "./ThirdPage";
import FourthPage from './FourthPage';
import BottomSheet from './BottomSheet';
import FifthPage from './FifthPage';
function Wollu() {

  const [nickNameText, setNickNameText] = useState('');
  const [salaryText, setSalaryText] = useState('');
  const [workingTimeText, setWorkingTimeText] = useState('');
  const [wolluMinuteText, setWolluMinuteText] = useState('');
  const [wolluItemSelected,setWolluItemSelected] = useState(-1);
  const [wolluItemText,setWolluItemText] = useState('');
  const [showWolluText,setShowWolluText] = useState('');
  const [roopangText,setRoopangText] = useState('');

  // views
  const wolluItemBottomSheet = WolluItemBottomSheet(wolluItemSelected, setWolluItemSelected, wolluItemText, setWolluItemText,setShowWolluText,setRoopangText);
  const getSalaryView = GetSalaryView(nickNameText,setNickNameText, salaryText,setSalaryText, workingTimeText, setWorkingTimeText);
  const getWolluView = GetWolluView(wolluMinuteText, setWolluMinuteText , workingTimeText, wolluItemText);
  const showWolluAmountView = ShowWolluAmountView(salaryText,workingTimeText,wolluMinuteText,wolluItemText,showWolluText,roopangText,setRoopangText,wolluItemSelected);


  const outerDivRef = useRef();
  const DIVIDER_HEIGHT = 5;
  
  useEffect(() => {
    const wheelHandler = (e) => {
        e.preventDefault();
        const { deltaY } = e;
        const { scrollTop } = outerDivRef.current; // 스크롤 위쪽 끝부분 위치
        const pageHeight = window.innerHeight; // 화면 세로길이, 100vh와 같습니다.
      
        if (deltaY > 0) {
          // 스크롤 내릴 때
          if (scrollTop >= 0 && scrollTop < pageHeight) {
            //현재 1페이지
            outerDivRef.current.scrollTo({
              top: pageHeight + DIVIDER_HEIGHT,
              left: 0,
              behavior: "smooth",
            });
          } else {

            for (var page_number = 2; page_number<6; page_number++){
                if (scrollTop >= pageHeight && scrollTop < pageHeight * page_number){
                    outerDivRef.current.scrollTo({
                        top: pageHeight * page_number + DIVIDER_HEIGHT * page_number,
                        left: 0,
                        behavior: "smooth",
                      });
                      break;
                } else {
                    outerDivRef.current.scrollTo({
                        top: pageHeight * page_number + DIVIDER_HEIGHT * page_number,
                        left: 0,
                        behavior: "smooth",
                    });
                }
            }
          } 
        } else {
          // 스크롤 올릴 때
          if (scrollTop >= 0 && scrollTop < pageHeight) {
            //현재 1페이지
            outerDivRef.current.scrollTo({
              top: 0,
              left: 0,
              behavior: "smooth",
            });
          } else if (scrollTop >= pageHeight && scrollTop < pageHeight * 2) {
            //현재 2페이지
            outerDivRef.current.scrollTo({
              top: 0,
              left: 0,
              behavior: "smooth",
            });
          } else if (scrollTop >= pageHeight && scrollTop < pageHeight * 3) {
            //현재 2페이지
            outerDivRef.current.scrollTo({
              top: pageHeight + DIVIDER_HEIGHT,
              left: 0,
              behavior: "smooth",
            });
          }
          else if (scrollTop >= pageHeight && scrollTop < pageHeight * 4) {
            //현재 2페이지
            outerDivRef.current.scrollTo({
              top: pageHeight*2 + DIVIDER_HEIGHT*2,
              left: 0,
              behavior: "smooth",
            });
          } else if (scrollTop >= pageHeight && scrollTop < pageHeight * 5) {
            //현재 2페이지
            outerDivRef.current.scrollTo({
              top: pageHeight*3 + DIVIDER_HEIGHT*3,
              left: 0,
              behavior: "smooth",
            });
          } else {
            // 현재 3페이지
            outerDivRef.current.scrollTo({
              top: pageHeight + DIVIDER_HEIGHT,
              left: 0,
              behavior: "smooth",
            });
          }
        }
      };
    const outerDivRefCurrent = outerDivRef.current;
    outerDivRefCurrent.addEventListener("wheel", wheelHandler);
    return () => {
      outerDivRefCurrent.removeEventListener("wheel", wheelHandler);
    };
  }, []);

  const SCROLL_OUTER = styled.div`
    height:100vh;
    overflow-y: auto;
    ::-webkit-scrollbar{
      display:none;
    }
  `;
  const PageDivider = styled.div`
      width: 100%;
      height: ${DIVIDER_HEIGHT}px;
      background-color: var(--main-background-color);
  `;
  return (
    <SCROLL_OUTER ref={outerDivRef}>
      <FirstPage/>
      <PageDivider/>
      <SecondPage/>
      <PageDivider/>
      <ThirdPage/>
      <PageDivider/>
      <FourthPage/>
      <PageDivider/>
      <FifthPage/>
    </SCROLL_OUTER>
    /*
      <FirstPage/>
      <BottomSheet></BottomSheet>
      
    <>
    <BrowserRouter>
        <Routes>
          <Route path={"/wollu"} element={<WolluAppAggroView/>}></Route>
          <Route path={"/download_app"} element={<AppDownloadView/>}></Route>
      </Routes>
      </BrowserRouter>
      <AppDownloadView/>
      <Background>

      </Background>
    </>
    <div className='WalluBackground'>
      <ScrollTest/>
      <AppDownloadView/>
      {wolluItemBottomSheet}
      <MainView/>
      {getSalaryView}
      {getWolluView}
      {showWolluAmountView}
      <WolluAppAggroView/>
      <div id="WolluAdSpace"/>
      <Slider/>
      <WolluAggroCardSlider/>
      <div className="GoogleAd">
        광고 
      </div> 
    </div>
    */
  );
}

export default Wollu;
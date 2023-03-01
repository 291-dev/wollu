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
import { BrowserRouter, Switch, Route } from 'react-router-dom';

function Wollu() {
  var [nickNameText, setNickNameText] = useState('');
  var [salaryText, setSalaryText] = useState('');
  var [workingTimeText, setWorkingTimeText] = useState('');
  const [wolluMinuteText, setWolluMinuteText] = useState('');
  const [wolluItemSelected,setWolluItemSelected] = useState(-1);
  const [wolluItemText,setWolluItemText] = useState('');
  const [showWolluText,setShowWolluText] = useState('');
  const [roopangText,setRoopangText] = useState('');


  const outerDivRef = useRef();
  const DIVIDER_HEIGHT = 5;
  let salaryInfo = {
    nickName: "",
    workingTime: "",
    salary : "",
  };
  let wolluInfo = {
    wolluFactor: 0,
    wolluTime: 0,
  }
  let showWolluInfo = {
    wolluFactorText: "",
    wolluAmount : 0,
    wolluTitle : "",
  }

  // touch events

  // views
  useEffect(() => {
    const wheelHandler = (e) => {
        e.preventDefault();
        const { deltaY } = e;
        const { scrollTop } = outerDivRef.current; // 스크롤 위쪽 끝부분 위치
        const pageHeight = window.innerHeight; // 화면 세로길이, 100vh와 같습니다.
        const SCROLL_SENSITIVITY = 200;

        if (deltaY > SCROLL_SENSITIVITY) {
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
              if (page_number ==2){
                  if (salaryInfo.nickName == ""){
                      alert("닉네임을 입력해주세요!");
                      break;
                  } else if (salaryInfo.salary == "") {
                      alert("월급을 입력해주세요!");
                      break;
                  } else if (salaryInfo.workingTime == ""){
                      alert("근무 시간을 입력해주세요!");
                      break;
                  }
              } else if (page_number == 3){
                  if (showWolluInfo.wolluFactorText == "") {
                    alert("월급 항목을 선택해주세요!");
                    break;
                  } else if (wolluInfo.wolluTime == "") {
                    alert("루팡한 시간을 입력해주세요!");
                    break;
                  } else {
                    showWolluInfo.wolluAmount = parseInt(parseInt(wolluInfo.wolluTime) * ( (parseInt(salaryInfo.salary) * 10000 )/20/parseInt(salaryInfo.workingTime)/60));
                    if (showWolluInfo.wolluAmount != 0){
                      document.querySelector(".hideText1").innerHTML = "로";
                      document.querySelector(".hideText2").innerHTML = " 루팡중입니다!";

                      document.querySelector(".showWolluFactor").innerHTML = showWolluInfo.wolluFactorText;
                      document.querySelector(".showWolluAmount").innerHTML = showWolluInfo.wolluAmount + "원";
                      document.querySelector(".showWolluTitle").innerHTML = showWolluInfo.wolluTitle;
                    } else {

                        document.querySelector(".showWolluFactor").innerHTML = "월루를 하지 않은 당신";
                        document.querySelector(".showWolluAmount").innerHTML = "사장님의 최애 직장인 등극";
                        document.querySelector(".showWolluTitle").innerHTML = "충직한 도비";
                        document.querySelector(".hideText1").innerHTML = "";
                        document.querySelector(".hideText2").innerHTML = "";
  
                    }
                    let showFrontColor = document.querySelector(".showFrontColor");
                    let showBackColor = document.querySelector(".showBackColor");
                    let showBackColor2 = document.querySelector(".showBackColor2");
                    let showText1 = document.querySelector("#showText1");
                    let showText2 = document.querySelector("#showText2");
                    let showImage = document.querySelector(".showWolluImage");

                    // remove all first
                    for (var i = 0; i< 9; i++){
                        var classNumber = "active_" + i;
                        showFrontColor.classList.remove(classNumber);
                        showBackColor.classList.remove(classNumber);
                        showBackColor2.classList.remove(classNumber);
                        showText1.classList.remove(classNumber);
                        showText2.classList.remove(classNumber);
                        showImage.classList.remove(classNumber);
                    }
                    var adjustClassNumber = "active_" + wolluInfo.wolluFactor;
                    if (document.querySelector(".showWolluTitle").innerHTML == "충직한 도비"){
                      adjustClassNumber = "active_8";
                    }
                    showFrontColor.classList.add(adjustClassNumber);
                    showBackColor.classList.add(adjustClassNumber);
                    showBackColor2.classList.add(adjustClassNumber);
                    showText1.classList.add(adjustClassNumber);
                    showText2.classList.add(adjustClassNumber);
                    showImage.classList.add(adjustClassNumber);

                    // flip card
                    let testContent = document.querySelector('.content');
                    testContent.classList.add("card_flip_active");
                  }
              } else if ( page_number == 4){
                let testContent = document.querySelector('.content');
                testContent.classList.remove("card_flip_active");
            
              }
              //if (page_number == 3 && ())
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
        } else if (deltaY < -SCROLL_SENSITIVITY){
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
            //현재3페이지
            outerDivRef.current.scrollTo({
              top: pageHeight + DIVIDER_HEIGHT,
              left: 0,
              behavior: "smooth",
            });
          }
          else if (scrollTop >= pageHeight && scrollTop < pageHeight * 4) {
            //현재 4페이지
            outerDivRef.current.scrollTo({
              top: pageHeight*2 + DIVIDER_HEIGHT*2,
              left: 0,
              behavior: "smooth",
            });
            let testContent = document.querySelector('.content');
            testContent.classList.remove("card_flip_active");

          } else if (scrollTop >= pageHeight && scrollTop < pageHeight * 5) {
            //현재 5페이지
            outerDivRef.current.scrollTo({
              top: pageHeight*3 + DIVIDER_HEIGHT*3,
              left: 0,
              behavior: "smooth",
            });
            let testContent = document.querySelector('.content');
            testContent.classList.add("card_flip_active");
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

  const  fourth = FourthPage(showWolluInfo);
 

  const second = SecondPage(salaryInfo);
  const third = ThirdPage(salaryInfo, wolluInfo, showWolluInfo);

  window.addEventListener('touchmove', ev => {
    ev.preventDefault();
    ev.stopImmediatePropagation();
  }, {passive: false});

  let touch_start_y,touch_end_y = 0;
  const touch_start = (e) => {
    touch_start_y = e.touches[0].clientY;
  }

  const touch_end = (e) => {
    touch_end_y = e.changedTouches[0].clientY;
    console.log(touch_end_y - touch_start_y);

    var scrolled = touch_end_y - touch_start_y;
    const { scrollTop } = outerDivRef.current; // 스크롤 위쪽 끝부분 위치
    const pageHeight = window.innerHeight; // 화면 세로길이, 100vh와 같습니다.
    const SCROLL_SENSITIVITY = 200;

    if (scrolled > SCROLL_SENSITIVITY){
      // up
      
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
        //현재3페이지
        outerDivRef.current.scrollTo({
          top: pageHeight + DIVIDER_HEIGHT,
          left: 0,
          behavior: "smooth",
        });
      }
      else if (scrollTop >= pageHeight && scrollTop < pageHeight * 4) {
        //현재 4페이지
        outerDivRef.current.scrollTo({
          top: pageHeight*2 + DIVIDER_HEIGHT*2,
          left: 0,
          behavior: "smooth",
        });
        let testContent = document.querySelector('.content');
        testContent.classList.remove("card_flip_active");

      } else if (scrollTop >= pageHeight && scrollTop < pageHeight * 5) {
        //현재 5페이지
        outerDivRef.current.scrollTo({
          top: pageHeight*3 + DIVIDER_HEIGHT*3,
          left: 0,
          behavior: "smooth",
        });
        let testContent = document.querySelector('.content');
        testContent.classList.add("card_flip_active");
      } else {
        // 현재 3페이지
        outerDivRef.current.scrollTo({
          top: pageHeight + DIVIDER_HEIGHT,
          left: 0,
          behavior: "smooth",
        });
      }
    }else if (scrolled < -SCROLL_SENSITIVITY) {
      // down
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
          if (page_number ==2){
              if (salaryInfo.nickName == ""){
                  alert("닉네임을 입력해주세요!");
                  break;
              } else if (salaryInfo.salary == "") {
                  alert("월급을 입력해주세요!");
                  break;
              } else if (salaryInfo.workingTime == ""){
                  alert("근무 시간을 입력해주세요!");
                  break;
              }
          } else if (page_number == 3){
              if (showWolluInfo.wolluFactorText == "") {
                alert("월급 항목을 선택해주세요!");
                break;
              } else if (wolluInfo.wolluTime == "") {
                alert("루팡한 시간을 입력해주세요!");
                break;
              } else {
                showWolluInfo.wolluAmount = parseInt(parseInt(wolluInfo.wolluTime) * ( (parseInt(salaryInfo.salary) * 10000 )/20/parseInt(salaryInfo.workingTime)/60));
                if (showWolluInfo.wolluAmount != 0){
                  document.querySelector(".hideText1").innerHTML = "로";
                  document.querySelector(".hideText2").innerHTML = " 루팡중입니다!";

                  document.querySelector(".showWolluFactor").innerHTML = showWolluInfo.wolluFactorText;
                  document.querySelector(".showWolluAmount").innerHTML = showWolluInfo.wolluAmount + "원";
                  document.querySelector(".showWolluTitle").innerHTML = showWolluInfo.wolluTitle;
                } else {

                    document.querySelector(".showWolluFactor").innerHTML = "월루를 하지 않은 당신";
                    document.querySelector(".showWolluAmount").innerHTML = "사장님의 최애 직장인 등극";
                    document.querySelector(".showWolluTitle").innerHTML = "충직한 도비";
                    document.querySelector(".hideText1").innerHTML = "";
                    document.querySelector(".hideText2").innerHTML = "";

                }
                let showFrontColor = document.querySelector(".showFrontColor");
                let showBackColor = document.querySelector(".showBackColor");
                let showBackColor2 = document.querySelector(".showBackColor2");
                let showText1 = document.querySelector("#showText1");
                let showText2 = document.querySelector("#showText2");
                let showImage = document.querySelector(".showWolluImage");

                // remove all first
                for (var i = 0; i< 9; i++){
                    var classNumber = "active_" + i;
                    showFrontColor.classList.remove(classNumber);
                    showBackColor.classList.remove(classNumber);
                    showBackColor2.classList.remove(classNumber);
                    showText1.classList.remove(classNumber);
                    showText2.classList.remove(classNumber);
                    showImage.classList.remove(classNumber);
                }
                var adjustClassNumber = "active_" + wolluInfo.wolluFactor;
                if (document.querySelector(".showWolluTitle").innerHTML == "충직한 도비"){
                  adjustClassNumber = "active_8";
                }
                showFrontColor.classList.add(adjustClassNumber);
                showBackColor.classList.add(adjustClassNumber);
                showBackColor2.classList.add(adjustClassNumber);
                showText1.classList.add(adjustClassNumber);
                showText2.classList.add(adjustClassNumber);
                showImage.classList.add(adjustClassNumber);

                // flip card
                let testContent = document.querySelector('.content');
                testContent.classList.add("card_flip_active");
              }
          } else if ( page_number == 4){
            let testContent = document.querySelector('.content');
            testContent.classList.remove("card_flip_active");
        
          }
          //if (page_number == 3 && ())
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
    }


  }
  
   return (
    <SCROLL_OUTER ref={outerDivRef} className="TouchEventClass" onTouchStart={touch_start} onTouchEnd={touch_end}>
      <FirstPage/>
      <PageDivider/>
      {second}
      <PageDivider/>
      {third}
      <PageDivider/>
      {fourth}
      <PageDivider/>
      <FifthPage/>
    </SCROLL_OUTER>
  );
}

export default Wollu;
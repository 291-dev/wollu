import '../CssUtil/Color.css';
import '../CssUtil/Font.css';
import './ScrollTest.css';
import React, {useState} from 'react';
import styled from 'styled-components';
import { useRef, useEffect} from "react";

export default function ScrollTest() {
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
    return (
        <>
        <SCROLL_OUTER ref={outerDivRef}>
          <div className="inner bg-yellow">1</div>
          <div className="divider"></div>
          <div className="inner bg-blue">2</div>
          <div className="divider"></div>
          <div className="inner bg-pink">3</div>
          <div className="divider"></div>
          <div className="inner bg-red">4</div>
          <div className="divider"></div>
          <div className="inner bg-black">5</div>
        </SCROLL_OUTER>
        </>
    );
}
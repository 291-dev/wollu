import '../CssUtil/Color.css';
import '../CssUtil/Font.css';
import '../Css/AppDownloadView.css';
import React, {useState} from 'react';
import styled from 'styled-components';
import WebDownloadViewImage from "../Resources/Images/WebDownloadViewImage.png";
import WebDownloadViewTeamLogo from "../Resources/Images/WebDownloadViewTeamLogo.svg";
import WolluTextImage from "../Resources/Images/MainView_WolluMainImage.svg";
import PlayStoreButtonImage from "../Resources/Images/PlayStoreButtonImage.png";
import AppStoreButtonImage from "../Resources/Images/AppStoreButtonImage.png";

export default function AppDownloadView() {
  // initialize
  var window_width = window.innerWidth;
  var window_height = window.innerHeight;

  if (window_width < 1000){
    window_width = 1000;
  }
  if (window_height < 609) {
    window_height = 609;
  }
  
  const AppDownloadViewBackground = styled.div`
    width: ${window_width}px;
    height:${window_height}px;
    background-color: #E3E4EC;
    justify-content: center;
    align-items: center;
    display:flex;ß
  `;
  const AppDownloadViewInner = styled.div`
    width: max-content;
    height: max-content;
    margin:auto;
    margin-top:auto;
    margin-bottom: auto;
  `;

  // Upper Parts
  const UpperPart = styled.div`
    display:flex;
  `; 

  //Left Parts
  const LeftPart = styled.div`
    margin-top: 150px;
    margin-left: 24px;
    margin-right: 62.33px;
    width:max-content;
    height:min-content;
  `;

  const WolluIntroText = styled.div`
    font-family:"puradack";
    font-weight:normal;
    font-size:18px;
    color:var(--main-color);
  `;

  const WolluMainImage = styled.img`
    padding-top: 8px;
    padding-bottom:41.5px;
  `;

  const WolluAppIntroText = styled.div`
    font-family: "pretendard_regular";
    font-weight:normal;
    font-size: 16px;
    color: var(--gray01-color);
  `;

  const AppDownloadButtonPart = styled.div`
    padding-top : 85px;
    display: flex;
  `;

  const PlayStoreButton = styled.img`
    width: 163.67px;
    height: 49.17px;
  `;
  const AppStoreButton = styled.img`
    padding-left:12.33px;
    width: 163.67px;
    height: 49.17px;
  `;

  const onPlayStoreButtonClicked = () => {
      alert("open Play Store");
  }

  const onAppStoreButtonClicked = () => {
    alert("open App Store");
  }

  //Right Parts
  const RightPart = styled.div`
    width: min-content;
    height: min-content;
    background-color: white;
    margin-left: 35px;
    border-radius: 24px 24px 0px 0px;
    display:flex;
  `;

  const RightPartImage = styled.img`
    margin-top: 15px;
    margin-left: 15px;
    margin-right: 15px;
    width: 375px;
    border-radius: 24px;
  `;

  // Bottom Part
  const BottomPart = styled.div`
    width:1000px;
    height:100px;
    border-radius: 24px;
    background-color: #FAFAFF;
  `;

  const BottomUpPart = styled.div`
    padding-left: 24px;
    display: flex;
  `;

  const TeamLogo = styled.img`
    padding-top: 18px;
    width: 85px;
    height: 33px;
  `;

  const TeamText = styled.div`
    padding-left: 8px;
    padding-top: 25px;
    color: #000000;
    font-family: "puradack_mac";
    font-weight: normal;
    font-size: 18px;
  `;

  const TeamIntroText = styled.div`
    color: #424242;
    font-family: "pretendard_regular";
    font-weight: normal;
    font-size: 16px;
    padding-top: 9px;
    padding-left: 27px;
  `;
  return (
    <>
      <AppDownloadViewBackground className='AppDownloadView'>
        <AppDownloadViewInner>
          <UpperPart>
            <LeftPart>
              <WolluIntroText>사장님 돈은 제가 가져갑니다</WolluIntroText>
              <WolluMainImage src={WolluTextImage}/>
              <WolluAppIntroText>본인의 월급을 얼마나 루팡하는 지</WolluAppIntroText>
              <WolluAppIntroText>측정해보세요!</WolluAppIntroText>
              <AppDownloadButtonPart>
                <PlayStoreButton src={PlayStoreButtonImage} onClick={onPlayStoreButtonClicked}/>
                <AppStoreButton src={AppStoreButtonImage} onClick={onAppStoreButtonClicked}/>
              </AppDownloadButtonPart>
            </LeftPart>
            <RightPart>
              <RightPartImage src={WebDownloadViewImage}/>
            </RightPart>
          </UpperPart>
          <BottomPart>
            <BottomUpPart>
              <TeamLogo src={WebDownloadViewTeamLogo}/>
            <TeamText>team.이구하나</TeamText>
            </BottomUpPart>
            <TeamIntroText>우리 팀은 29살에 모인 팀이라서 이구하나입니다.\n Contact Me: 김강직, liver.atease@icloud.com</TeamIntroText>
          </BottomPart>
        </AppDownloadViewInner>
      </AppDownloadViewBackground>
    </>
  );
}
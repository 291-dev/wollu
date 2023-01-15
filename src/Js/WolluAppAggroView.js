import "../Css/WolluAppAggroView.css";
import "../CssUtil/Font.css";
import DeviceShareIcon from "../Resources/Images/DeviceShareIcon.svg";
import KakaoShareIcon from "../Resources/Images/KakaoShareIcon.svg";
import FacebookShareIcon from "../Resources/Images/FacebookShareIcon.svg";
import InstagramShareIcon from "../Resources/Images/InstagramShareIcon.svg";
import TweeterShareIcon from "../Resources/Images/TweeterShareIcon.svg";
import WolluAppAggroCardSelection2 from "../Resources/Images/WolluAppAggroCardSelection2.svg";
import React, {useState, useEffect} from 'react';
import WolluEnv from "../Environment.js";

const WOLLU_WEB_URL = "http://wollu.me";
const WOLLU_KAKAO_JS_KEY = "851b19589ec25afcb0e69973ce38ef2e";
const TEAM_URL = "http://wollu.me/project_info";
function WolluAppAggroView() {
  useEffect(() => {
    const script = document.createElement("script");
    script.src = "https://developers.kakao.com/sdk/js/kakao.js";
    script.async = true;
    document.body.appendChild(script);
    return () => document.body.removeChild(script);
  }, []);
  
  const onKaKaoShareButtonClicked = () => {
    shareKakao(WOLLU_WEB_URL,"월루 공유하기");
  };

  const shareKakao = (route, title) => { // url이 id값에 따라 변경되기 때문에 route를 인자값으로 받아줌
    if (window.Kakao) {
      const kakao = window.Kakao;
      if (!kakao.isInitialized()) {
        kakao.init(WOLLU_KAKAO_JS_KEY); // 카카오에서 제공받은 javascript key를 넣어줌 -> .env파일에서 호출시킴
      }
  
      kakao.Link.sendDefault({
        objectType: "feed",
        content: {
          title: title,
          description: "월급 루팡 내역을 공유해보세요!\n월급 루팡 함께 해보기 : http://wollu.me",
          imageUrl: "../Resources/Images/WolluFabicon512.png",
          link: {
            mobileWebUrl: TEAM_URL, // 인자값으로 받은 route(uri 형태)
            webUrl: TEAM_URL // TODO 
          }
        },
        buttons: [
          {
            title: "나의 월루 금액 확인하기",
            link: {
              mobileWebUrl: WOLLU_WEB_URL,
              webUrl: WOLLU_WEB_URL
            }
          }
        ]
      });
    }
  };

  return (    
    <div className="WolluAppAggroView">
      <div id="wolluAppAggroSpace1"/>
      <div id="shareFriendText">친구에게 테스트 공유하기</div>
      <div id="wolluAppAggroSpace2"/>
      <div className="ShareIconButtons">
        <img src={KakaoShareIcon} onClick={onKaKaoShareButtonClicked}/>
        <img src={FacebookShareIcon} id ="wolluAppAggroShareIconSpace"/>
        <img src={InstagramShareIcon} id ="wolluAppAggroShareIconSpace"/>
        <img src={TweeterShareIcon} id ="wolluAppAggroShareIconSpace"/>
        <img src={DeviceShareIcon} id ="wolluAppAggroShareIconSpace"/>
      </div>
      <div id="wolluAppAggroSpace3" />
      <div id="showOtherFriendsWolluText">
        나와 비슷한 사람들은
        <br/>
        얼마나 루팡하는 지 알고 싶다면?
      </div>
      <div id="wolluAppAggroSpace4" />
      <div className="AggroTextSytle">
      
        <div id="sameJobAggroText">
          나와 같은 직종 사람들은 &nbsp;
          <div className="Inline" id="blurText">12000</div>
          원 루팡해요
        </div>        
        <div id="wolluAppAggroSpace5"/>
        <div className="ShowWolluAmountSlider">
          <div id="showSameJobAmount"/>
        </div>
        <div id="wolluAppAggroSpace6"/>

        <div id="sameJobYearAggroText">
          나와 같은 연차 사람들은 &nbsp;
          <div className="Inline" id="blurText">2000</div>
          원 루팡해요
        </div>        
        <div id="wolluAppAggroSpace5"/>
        <div className="ShowWolluAmountSlider">
          <div id="showSameJobYearAmount"/>
        </div>
        <div id="wolluAppAggroSpace6"/>

        <div id="sameGenderAggroText">
          나와 같은 성별 사람들은 &nbsp;
          <div className="Inline" id="blurText">2000</div>
          원 루팡해요
        </div>        
        <div id="wolluAppAggroSpace5"/>
        <div className="ShowWolluAmountSlider">
          <div id="showSameGenderAmount"/>
        </div>
        <div id="wolluAppAggroSpace6"/>

        <div id="sameAgeAggroText">
          나와 같은 나이 사람들은 &nbsp;
          <div className="Inline" id="blurText">112000</div>
          원 루팡해요
        </div>        
        <div id="wolluAppAggroSpace5"/>
        <div className="ShowWolluAmountSlider">
          <div id="showSameAgeAmount"/>
        </div>
      </div>

      <div id="wolluAppAggroSpace7" />

      <div className="WolluAppAggroCard">
        <div id="wolluAppAggroText">
          직장인 하루 평균 담배로 월루하는 시간
          <br/>
          확인하러가기
        </div>
        <div id="wolluAppAggroSpace8"/>
        <img src={WolluAppAggroCardSelection2}/>
      </div>

      <div id="wolluAppAggroSpace9" />
      <div className="WolluAppDownloadButton">
        <div id="wolluAppDonwloadButtonText">어플 다운받기</div>
      </div>
    </div> 
  );
}
export default WolluAppAggroView;
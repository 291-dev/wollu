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

import testImage from "../Resources/Images/WolluFabicon192.png";

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
          imageUrl: "../Resource/",//"http://wollu.me/static/media/GetWolluView_WolluImage.bed8b581.svg",
          link: {
            mobileWebUrl: TEAM_URL, // 인자값으로 받은 route(uri 형태)
            webUrl: TEAM_URL // TODO 
          }
        },
        buttons: [
          {
            title: "나는 얼마를 루팡할까?",
            link: {
              mobileWebUrl: WOLLU_WEB_URL,
              webUrl: WOLLU_WEB_URL
            }
          }
        ]
      });

    }
  };

  const deviceShareButtonClicked = () => {
    var isMobile = false; //initiate as false
    // device detection
    if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|ipad|iris|kindle|Android|Silk|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(navigator.userAgent) 
      || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(navigator.userAgent.substr(0,4))) { 
      isMobile = true;
    }
    if (window.navigator.share){ // only safari
      alert("share function exists");
      window.navigator.share({
        title: "test", // 공유될 제목
        text: "", // 공유될 설명
        url: "", // 공유될 URL
        files: [], // 공유할 파일 배열
      });
    } else {
      alert("share function not exists");
      alert(isMobile);
      alert(window.device);
    }
  };

  const twitterShareButtonClicked = () => {

    // Opens a pop-up with twitter sharing dialog
    var shareURL = "http://twitter.com/share?"; //url base
    //params
    var params = {
      url: "http://wollu.me\n", 
      text: "월루 금액을 확인해보세요!!\n",
      via: "291",
      hashtags: "월급루팡,얼마나루팡할까?",
    }
    for(var prop in params) shareURL += '&' + prop + '=' + encodeURIComponent(params[prop]);
    window.open(shareURL, '', 'left=0,top=0,width=550,height=450,personalbar=0,toolbar=0,scrollbars=0,resizable=0');
  }

  const faceBookShareButtonClicked = (e) => {
    const navUrl = 'https://www.facebook.com/sharer/sharer.php?u=' + 'https://wollu.me';
    window.open(navUrl);
    return;
  }

  return (    
    <div className="WolluAppAggroView">
      <div id="wolluAppAggroSpace1"/>
      <div id="shareFriendText">친구에게 테스트 공유하기</div>
      <div id="wolluAppAggroSpace2"/>
      <div className="ShareIconButtons">
        <img src={KakaoShareIcon} onClick={onKaKaoShareButtonClicked}/>
        <img src={FacebookShareIcon} id ="wolluAppAggroShareIconSpace" onClick={faceBookShareButtonClicked}/>
        <img src={InstagramShareIcon} id ="wolluAppAggroShareIconSpace"/>
        <img src={TweeterShareIcon} id ="wolluAppAggroShareIconSpace" onClick={twitterShareButtonClicked}/>
        <img src={DeviceShareIcon} id ="wolluAppAggroShareIconSpace" onClick={deviceShareButtonClicked}/>
      </div>
      <div id="wolluAppAggroSpace3" />
      <div id="wolluAppAggroTextBoxes">
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
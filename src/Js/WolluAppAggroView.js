import "../Css/WolluAppAggroView.css";
import "../CssUtil/Font.css";
import DeviceShareIcon from "../Resources/Images/DeviceShareIcon.svg";
import KakaoShareIcon from "../Resources/Images/KakaoShareIcon.svg";
import FacebookShareIcon from "../Resources/Images/FacebookShareIcon.svg";
import InstagramShareIcon from "../Resources/Images/InstagramShareIcon.svg";
import TweeterShareIcon from "../Resources/Images/TweeterShareIcon.svg";
import WolluAppAggroCardSelection2 from "../Resources/Images/WolluAppAggroCardSelection2.svg";

function WolluAppAggroView() {
  return (
    <div className="WolluAppAggroView">
      <div id="wolluAppAggroSpace1"/>
      <div id="shareFriendText">친구에게 테스트 공유하기</div>
      <div id="wolluAppAggroSpace2"/>
      <div className="ShareIconButtons">
        <img src={KakaoShareIcon}/>
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
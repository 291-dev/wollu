import React,{useState, useEffect}from 'react';
import styled from 'styled-components';
import "../CssUtil/Color.css";
import "../CssUtil/Font.css";
import "../CssUtil/Effects.css";
import DeviceShareIcon from "../Resources/Images/DeviceShareIcon.svg";
import KakaoShareIcon from "../Resources/Images/KakaoShareIcon.svg";
import FacebookShareIcon from "../Resources/Images/FacebookShareIcon.svg";
import InstagramShareIcon from "../Resources/Images/InstagramShareIcon.svg";
import TweeterShareIcon from "../Resources/Images/TweeterShareIcon.svg";
import WolluAppAggroCardSelection2 from "../Resources/Images/WolluAppAggroCardSelection2.svg";

const WOLLU_WEB_URL = "http://wollu.me";
const WOLLU_KAKAO_JS_KEY = "851b19589ec25afcb0e69973ce38ef2e";
const TEAM_URL = "http://wollu.me/project_info";
export default function FifthPage(){
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
          window.navigator.share({
            title: "test", // 공유될 제목
            text: "", // 공유될 설명
            url: "", // 공유될 URL
            files: [], // 공유할 파일 배열
          });
        } else {
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
      const onAppDownloadButtonClicked = () => {
        var isMobile = false;
        if(/(android|bb\d+|meego).+mobile|avantgo|bada\/|blackberry|blazer|compal|elaine|fennec|hiptop|iemobile|ip(hone|od)|ipad|iris|kindle|Android|Silk|lge |maemo|midp|mmp|netfront|opera m(ob|in)i|palm( os)?|phone|p(ixi|re)\/|plucker|pocket|psp|series(4|6)0|symbian|treo|up\.(browser|link)|vodafone|wap|windows (ce|phone)|xda|xiino/i.test(navigator.userAgent) 
          || /1207|6310|6590|3gso|4thp|50[1-6]i|770s|802s|a wa|abac|ac(er|oo|s\-)|ai(ko|rn)|al(av|ca|co)|amoi|an(ex|ny|yw)|aptu|ar(ch|go)|as(te|us)|attw|au(di|\-m|r |s )|avan|be(ck|ll|nq)|bi(lb|rd)|bl(ac|az)|br(e|v)w|bumb|bw\-(n|u)|c55\/|capi|ccwa|cdm\-|cell|chtm|cldc|cmd\-|co(mp|nd)|craw|da(it|ll|ng)|dbte|dc\-s|devi|dica|dmob|do(c|p)o|ds(12|\-d)|el(49|ai)|em(l2|ul)|er(ic|k0)|esl8|ez([4-7]0|os|wa|ze)|fetc|fly(\-|_)|g1 u|g560|gene|gf\-5|g\-mo|go(\.w|od)|gr(ad|un)|haie|hcit|hd\-(m|p|t)|hei\-|hi(pt|ta)|hp( i|ip)|hs\-c|ht(c(\-| |_|a|g|p|s|t)|tp)|hu(aw|tc)|i\-(20|go|ma)|i230|iac( |\-|\/)|ibro|idea|ig01|ikom|im1k|inno|ipaq|iris|ja(t|v)a|jbro|jemu|jigs|kddi|keji|kgt( |\/)|klon|kpt |kwc\-|kyo(c|k)|le(no|xi)|lg( g|\/(k|l|u)|50|54|\-[a-w])|libw|lynx|m1\-w|m3ga|m50\/|ma(te|ui|xo)|mc(01|21|ca)|m\-cr|me(rc|ri)|mi(o8|oa|ts)|mmef|mo(01|02|bi|de|do|t(\-| |o|v)|zz)|mt(50|p1|v )|mwbp|mywa|n10[0-2]|n20[2-3]|n30(0|2)|n50(0|2|5)|n7(0(0|1)|10)|ne((c|m)\-|on|tf|wf|wg|wt)|nok(6|i)|nzph|o2im|op(ti|wv)|oran|owg1|p800|pan(a|d|t)|pdxg|pg(13|\-([1-8]|c))|phil|pire|pl(ay|uc)|pn\-2|po(ck|rt|se)|prox|psio|pt\-g|qa\-a|qc(07|12|21|32|60|\-[2-7]|i\-)|qtek|r380|r600|raks|rim9|ro(ve|zo)|s55\/|sa(ge|ma|mm|ms|ny|va)|sc(01|h\-|oo|p\-)|sdk\/|se(c(\-|0|1)|47|mc|nd|ri)|sgh\-|shar|sie(\-|m)|sk\-0|sl(45|id)|sm(al|ar|b3|it|t5)|so(ft|ny)|sp(01|h\-|v\-|v )|sy(01|mb)|t2(18|50)|t6(00|10|18)|ta(gt|lk)|tcl\-|tdg\-|tel(i|m)|tim\-|t\-mo|to(pl|sh)|ts(70|m\-|m3|m5)|tx\-9|up(\.b|g1|si)|utst|v400|v750|veri|vi(rg|te)|vk(40|5[0-3]|\-v)|vm40|voda|vulc|vx(52|53|60|61|70|80|81|83|85|98)|w3c(\-| )|webc|whit|wi(g |nc|nw)|wmlb|wonu|x700|yas\-|your|zeto|zte\-/i.test(navigator.userAgent.substr(0,4))) { 
          isMobile = true;
        }
    
        if (!isMobile) {
          alert("Web Detected.. go to web download page");
          //goWebAppDownloadView();
        } else {
          var varUA = navigator.userAgent.toLowerCase(); //userAgent 값 얻기
          if ( varUA.indexOf('android') > -1) {
            //안드로이드
            alert("android device detected");
        } else if ( varUA.indexOf("iphone") > -1||varUA.indexOf("ipad") > -1||varUA.indexOf("ipod") > -1 ) {
            //IOS
            alert('ios device detected');
        } else {
            //아이폰, 안드로이드 외
            alert("not ios and android");
        }
        }
      }

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

    const MainContent = styled.div`
        margin-top: ${card_margin_top}px;   
        width:${card_width}px;
        height:${card_height}px;
    `;

    const ShareBox = styled.div`
        margin-left:auto;
        margin-right:auto;
        width:max-content;
    `;

    const ShareText = styled.div`
        font-family: "pretendard_semibold";
        font-size: ${14/700*card_height}px;
        color: var(--main-color);
        text-align: center;
    `;

    const ShareButtonBox = styled.div`
        margin-top: ${14/700*card_height}px;
    `;

    const ShareButton1 = styled.img`
        height:${34/700*card_height}px;
    `;
    const ShareButton2 = styled.img`
        height:${34/700*card_height}px;
        margin-left: ${10/339*card_width}px;
    `;

    const ShowTextField = styled.div`
        margin-top: ${82.59/700*card_height}px;
    `;

    const ShowText = styled.div`
        font-family: "pretendard_semibold";
        font-size: ${18/700*card_height}px;
        line-height: 150%;
        color:var(--main-color);
    `;

    const ShowWolluCases = styled.div`
        margin-top: ${42.3/700*card_height}px;
        width: ${334.85/339 *card_width}px;
        text-align: left;
        font-family: "pretendard_regular";
        font-size: ${14/700*card_height}px;
        color: #000000;
    `;

    const BlurText = styled.div`
        display:inline;
        filter: blur(3px);
    `;    
    const WolluAmountSlider = styled.div`
        height: ${4/700*card_height}px;
        background-color: #F3F3F3;
        box-shadow: inset 0px ${1.63333/700*card_height}px ${1.63333/700*card_height}px rgba(0, 0, 0, 0.05);
        border-radius: 2px;
        width: ${card_width}px;
        margin-top:${19.24/700*card_height}px;
    `;
    const WolluAmountInnerSlider = styled.div`
        height:${4/700*card_height}px;
        width: ${100/339*card_width}px;
        background-color: var(--main-color);
    `;
    const SliderMargin = styled.div`
        margin-top:${16.11/700*card_height}px;
    `;

    const AggroTextMargin = styled.div`
        padding-top: ${21/700*card_height}px;
    `;
    const AggroTextButton = styled.div`
        margin-top:${54.39/700*card_height}px;
        width:${card_width}px;
        height:${135.97/700*card_height}px;
        background-color: var(--main-color);
        border-radius: 8px;
        display: flex;
        justify-content: center;
    `;
    const AggroTextField = styled.div`
        padding-top: ${21.15/700*card_height}px;
    `;
    const AggroTextInner = styled.div`
        font-family: "pretendard_semibold";
        font-size: ${18/700*card_height}px;
        line-height: 150%;
        color: white;
    `;
    const SliderDotImage = styled.img`
        margin-top:${42.3/700*card_height}px;
        display: flex;
        margin-left: auto;
        margin-right: auto;
        //background-color: red;
    `;

    const AppDownloadButton = styled.div`
        margin-top: ${24.17/700*card_height}px;
        height:${43.31/700*card_height}px;
        border-radius: 8px;
        background-color: var(--main-color);        display: flex;
        justify-content: center;
        align-items: center;
    `;

    const AppDownloadText = styled.div`
        color: #F2F3F6;
        font-family: "pretendard_semibold";
        font-size: ${16/700*card_height}px;

    `;
    return (
        <Background>
            <MainContent>
                <ShareBox>
                    <ShareText>친구에게 테스트 공유하기</ShareText>
                    <ShareButtonBox>
                        <ShareButton1 src={KakaoShareIcon} onClick={onKaKaoShareButtonClicked}/>
                        <ShareButton2 src={FacebookShareIcon} onClick={faceBookShareButtonClicked}/>
                        <ShareButton2 src={TweeterShareIcon} onClick={twitterShareButtonClicked}/>
                        <ShareButton2 src={DeviceShareIcon} onClick={deviceShareButtonClicked}/>
                    </ShareButtonBox>
                </ShareBox>
                
                <ShowTextField>
                    <ShowText>나랑 비슷한 사람들은</ShowText>
                    <ShowText>얼마나 루팡하는지 알고싶다면?</ShowText>                    
                </ShowTextField>
                <ShowWolluCases>
                    나와 같은 직종 사람들은 &nbsp;<BlurText>12000원</BlurText>원 루팡해요
                    <br/>
                    <WolluAmountSlider><WolluAmountInnerSlider/></WolluAmountSlider>
                    <SliderMargin/>

                    나와 같은 연차 사람들은 &nbsp;<BlurText>2000원</BlurText>원 루팡해요
                    <br/>
                    <WolluAmountSlider><WolluAmountInnerSlider/></WolluAmountSlider>
                    <SliderMargin/>

                    나와 같은 성별 사람들은 &nbsp;<BlurText>600원</BlurText>원 루팡해요
                    <br/>
                    <WolluAmountSlider><WolluAmountInnerSlider/></WolluAmountSlider>
                    <SliderMargin/>

                    나와 같은 나이 사람들은 &nbsp;<BlurText>11200원</BlurText>원 루팡해요
                    <br/>
                    <WolluAmountSlider><WolluAmountInnerSlider/></WolluAmountSlider>
                </ShowWolluCases>
                <AggroTextButton>
                    <AggroTextField>
                        <AggroTextInner>
                            직장인 하루 평균 담배로 월루하는 시간
                            <br/>
                            확인하러 가기
                        </AggroTextInner>
                        <SliderDotImage src={WolluAppAggroCardSelection2}/>
                    </AggroTextField>
                </AggroTextButton>
                <AppDownloadButton>
                    <AppDownloadText>어플 다운받기</AppDownloadText>
                </AppDownloadButton>
            </MainContent>
        </Background>
    );
}
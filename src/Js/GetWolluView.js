import '../Css/GetWolluView.css';
import '../CssUtil/CardStyle.css';
import '../CssUtil/TextStyle.css';
import '../CssUtil/Spaces.css';
import '../CssUtil/Utils.css';
import GetWolluView_ShowTextImage from "../Resources/Images/GetWolluView_ShowTextImage.svg";
import GetWolluView_WolluImage from "../Resources/Images/GetWolluView_WolluImage.svg";
import React, {useState} from 'react';

//const [wolluMinuteText, setWolluMinuteText] = useState('');

function GetWolluView(wolluMinuteText, setWolluMinuteText, workingTimeText) {
    //const [wolluMinuteText, setWolluMinuteText] = useState('');
    const onWolluMinuteChange = (e) => {
        if (isNaN(e.target.value)) {
            e.target.value = "";
            alert("숫자만 입력해주세요");
        }  else {
            if (Number(e.target.value) > 60 * 24 ){
                alert("하루를 초과한 시간은 할 수 없습니다.");
                e.target.value = 60 * 24;
            } else if (workingTimeText * 60 < e.target.value){
                alert("일한 시간보다 많을 수 없습니다.");
                e.target.value = "";
            }
            setWolluMinuteText(e.target.value);
        }
    };

    const onWolluCaseClick = (e) => {
        alert("clicked");
        e.target.value = "selected";
    }
  return (
    <div className="GetWolluView" id="Card">
        <div id="cardTopSpaces"/>
        <div id="getWolluSpace1"/>
        <img src={GetWolluView_ShowTextImage} id="GetWolluView_ShowTextImage"/>
        <div id="getWolluSpace2"/>
        <img src={GetWolluView_WolluImage} id = "GetWolluView_WolluImage"/>
        <div id="getWolluSpace3"/>
        <div className="PretendaredLight" id="getWolluViewTextStyles" >
            <div>
                <div className="Inline" id="getWolluViewFrontText">오늘</div>
                <div className="Inline">
                    <input className="UnFocusedInputText" id="getWolluViewInputField1" onClick={onWolluCaseClick} placeholder="항목 선택"></input>
                </div>
                <div className="Inline" id="getWolluViewBackText">으로</div>
            </div>

            <div id="getWolluSpace4"></div>

            <div>
                <div className="Inline">
                    <input className="UnFocusedInputText" id="getWolluViewInputField2" onChange={onWolluMinuteChange} placeholder="30"></input>
                </div>
                <div className="Inline" id="getWolluViewBackText">분 월루했습니다.</div>
            </div>
            

        </div>
    </div>
    
  );
}

export default GetWolluView;
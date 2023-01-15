import '../Css/GetSalaryView.css';
import '../CssUtil/CardStyle.css';
import GetSalaryView_MainImage from "../Resources/Images/GetSalaryView_MainImage.svg";
import '../CssUtil/TextStyle.css';
import '../CssUtil/Spaces.css';
import '../CssUtil/Utils.css'
import React, {useState} from 'react';

function GetSalaryView(nickNameText,setNickNameText, salaryText,setSalaryText, workingTimeText, setWorkingTimeText) {

  const onNickNameChange = (e) => {
    // replace string
    var reg = /[\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi;
    e.target.value = e.target.value.replace(reg,'');
    
    if ([...e.target.value].length > 7) {
      alert("7자리 아래로 만들어주세요");
      e.target.value = e.target.value.slice(0,-1);
    }
    setNickNameText(e.target.value);      
  };

  const onSalaryChange = (e) => {
    
    if (isNaN(e.target.value)) {
      e.target.value = "";
      alert("숫자만 입력해주세요");
    }  else {
      if (e.target.value > 10000) {
        alert("월급 1억 이상은 계산을 못합니다..");
        e.target.value = "";
      }
      setSalaryText(e.target.value);
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
      setWorkingTimeText(e.target.value);
      
    }
  };

  return (
    <div className="GetSalaryView" id="Card">
        <div id="cardTopSpaces"/>
        <img src={GetSalaryView_MainImage}/>
        <div id="getSalarySpace1"/>
        <div className="PretendaredLight" id="getSalaryViewTextStyles" >
            <div>사장님, 안녕하세요.</div>
            
            <div id="getSalarySpace2"/>            
            
            <div>
              <div className="Inline" id="getSalaryViewFrontText">저</div>
              <div className="Inline">
                <input className="UnFocusedInputText" id="getSalaryViewInputField1" onChange={onNickNameChange} placeholder="홍길동"></input>
              </div>
              <div className="Inline" id="getSalaryViewBackText">은/는</div>
            </div>
            
            <div id="getSalarySpace2"/>            
            
            <div>
              <div className="Inline" id="getSalaryViewFrontText">월급</div>
              <div className="Inline">
                <input className="UnFocusedInputText" id="getSalaryViewInputField2" onChange={onSalaryChange} placeholder="300"></input>
              </div>
              <div className="Inline" id="getSalaryViewBackText">만원을 받고</div>
            </div>
            
            <div id="getSalarySpace2"/>

            <div>
              <div className="Inline" id="getSalaryViewFrontText">하루</div>
              <div className="Inline">
                <input className="UnFocusedInputText" id="getSalaryViewInputField3" onChange={onWorkingTimeChange} placeholder="30"></input>
              </div>
              <div className="Inline" id="getSalaryViewBackText">시간 근무합니다.</div>
            </div>
        </div>

        <div id="getSalarySpace3"/>
    </div>
  );
}

export default GetSalaryView;
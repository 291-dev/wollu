import '../Css/Wollu.css';
import Test from "./Test.js";
import MainView from "./MainView.js";
import GetSalaryView from './GetSalaryView';
import GetWolluView from './GetWolluView';
import ShowWolluAmountView from './ShowWolluAmountView';
import WolluAppAggroView from './WolluAppAggroView';
import '../CssUtil/CardFlip.css';
import React, {useState} from 'react';

function Wollu() {
  
  const [nickNameText, setNickNameText] = useState('');
  const [salaryText, setSalaryText] = useState('');
  const [workingTimeText, setWorkingTimeText] = useState('');
  const [wolluMinuteText, setWolluMinuteText] = useState('');

  // views
  var wolluItem = "커피마시기?";
  const getSalaryView = GetSalaryView(nickNameText,setNickNameText, salaryText,setSalaryText, workingTimeText, setWorkingTimeText);
  const getWolluView = GetWolluView(wolluMinuteText, setWolluMinuteText, workingTimeText);
  const showWolluAmountView = ShowWolluAmountView(salaryText,workingTimeText,wolluMinuteText,wolluItem);
  return (
    <div className='WalluBackground'>      
      <MainView/>
      {getSalaryView}
      {getWolluView}
      {showWolluAmountView}
      <WolluAppAggroView/>
      <div id="WolluAdSpace"/>
      <div className="GoogleAd">
        광고
      </div>
      <div className="flip">  
        <div className="card">
          <div className="front">
            <GetWolluView/>
          </div>
          <div className="back">
            <GetSalaryView/>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Wollu;
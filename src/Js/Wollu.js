import '../Css/Wollu.css';
import MainView from "./MainView.js";
import GetSalaryView from './GetSalaryView';
import GetWolluView from './GetWolluView';
import ShowWolluAmountView from './ShowWolluAmountView';
import WolluAppAggroView from './WolluAppAggroView';
import '../CssUtil/CardFlip.css';
import React, {useState} from 'react';
import WolluItemBottomSheet from './WolluItemBottomSheet';
function Wollu() {
  
  const [nickNameText, setNickNameText] = useState('');
  const [salaryText, setSalaryText] = useState('');
  const [workingTimeText, setWorkingTimeText] = useState('');
  const [wolluMinuteText, setWolluMinuteText] = useState('');
  const [wolluItemSelected,setWolluItemSelected] = useState(-1);
  const [wolluItemText,setWolluItemText] = useState('');

  // views
  var wolluItem = "커피마시기?";
  const wolluItemBottomSheet = WolluItemBottomSheet(wolluItemSelected, setWolluItemSelected, wolluItemText, setWolluItemText);
  const getSalaryView = GetSalaryView(nickNameText,setNickNameText, salaryText,setSalaryText, workingTimeText, setWorkingTimeText);
  const getWolluView = GetWolluView(wolluMinuteText, setWolluMinuteText , workingTimeText, wolluItemText);
  const showWolluAmountView = ShowWolluAmountView(salaryText,workingTimeText,wolluMinuteText,wolluItemText);  

  return (
    <div className='WalluBackground'>
      {wolluItemBottomSheet}
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
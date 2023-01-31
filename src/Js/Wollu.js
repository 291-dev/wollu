import '../Css/Wollu.css';
import MainView from "./MainView.js";
import GetSalaryView from './GetSalaryView';
import GetWolluView from './GetWolluView';
import ShowWolluAmountView from './ShowWolluAmountView';
import WolluAppAggroView from './WolluAppAggroView';
import React, {useState} from 'react';
import WolluItemBottomSheet from './WolluItemBottomSheet';
import Slider from "./Slider";
import WolluAggroCardSlider from "./WolluAggroCardSlider";

import AppDownloadView from "./AppDownloadView";
import ScrollTest from "./ScrollTest";
function Wollu() {

  const [nickNameText, setNickNameText] = useState('');
  const [salaryText, setSalaryText] = useState('');
  const [workingTimeText, setWorkingTimeText] = useState('');
  const [wolluMinuteText, setWolluMinuteText] = useState('');
  const [wolluItemSelected,setWolluItemSelected] = useState(-1);
  const [wolluItemText,setWolluItemText] = useState('');
  const [showWolluText,setShowWolluText] = useState('');
  const [roopangText,setRoopangText] = useState('');

  // views
  const wolluItemBottomSheet = WolluItemBottomSheet(wolluItemSelected, setWolluItemSelected, wolluItemText, setWolluItemText,setShowWolluText,setRoopangText);
  const getSalaryView = GetSalaryView(nickNameText,setNickNameText, salaryText,setSalaryText, workingTimeText, setWorkingTimeText);
  const getWolluView = GetWolluView(wolluMinuteText, setWolluMinuteText , workingTimeText, wolluItemText);
  const showWolluAmountView = ShowWolluAmountView(salaryText,workingTimeText,wolluMinuteText,wolluItemText,showWolluText,roopangText,setRoopangText,wolluItemSelected);

  return (
    <>
          <AppDownloadView/>
    </>
    /*
    <div className='WalluBackground'>
      <AppDownloadView/>
      {wolluItemBottomSheet}
      <MainView/>
      {getSalaryView}
      {getWolluView}
      {showWolluAmountView}
      <WolluAppAggroView/>
      <div id="WolluAdSpace"/>
      <Slider/>
      <WolluAggroCardSlider/>
      <div className="GoogleAd">
        광고 
      </div> 
    </div>
    */
  );
}

export default Wollu;
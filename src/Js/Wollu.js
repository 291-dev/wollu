import '../Css/Wollu.css';
import Test from "./Test.js";
import MainView from "./MainView.js";
import GetSalaryView from './GetSalaryView';
import GetWolluView from './GetWolluView';
import ShowWolluAmountView from './ShowWolluAmountView';
import WolluAppAggroView from './WolluAppAggroView';

function Wollu() {
  return (
    <div className='WalluBackground'>
      <MainView/>
      <GetSalaryView/>
      <GetWolluView/>
      <ShowWolluAmountView/>
      <WolluAppAggroView/>
      <div id="WolluAdSpace"/>
      <div className="GoogleAd">
        광고
      </div>
    </div>    
  );
}

export default Wollu;
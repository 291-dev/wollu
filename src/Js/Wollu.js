import '../Css/Wollu.css';
import Test from "./Test.js";
import MainView from "./MainView.js";
import GetSalaryView from './GetSalaryView';
import GetWolluView from './GetWolluView';
import ShowWolluAmountView from './ShowWolluAmountView';

function Wollu() {
  return (
    <div className='WalluBackground'>
      <MainView/>
      <GetSalaryView/>
      <GetWolluView/>
      <ShowWolluAmountView/>
    </div>
  );
}
/*    <Wollu>
      <WolluViewEffects>
        <MainView/>
        <GetSalaryView/>
        <GetWolluAmountView/>
        <ShowWalluAmountView/>
        <AggroWolluAppView/>
        <DownloadWalluAppView/>
      </WolluViewEffects>
    </Wollu>
*/
export default Wollu;
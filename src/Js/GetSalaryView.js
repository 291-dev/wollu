import '../Css/GetSalaryView.css';
import '../CssUtil/CardStyle.css';
import GetSalaryView_MainImage from "../Resources/Images/GetSalaryView_MainImage.svg";
import '../CssUtil/TextStyle.css';
import '../CssUtil/Spaces.css';
import '../CssUtil/Utils.css'

function GetSalaryView() {
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
                <input className="FocusedInputText" id="getSalaryViewInputField1"></input>
              </div>
              <div className="Inline" id="getSalaryViewBackText">은/는</div>
            </div>
            
            <div id="getSalarySpace2"/>            
            
            <div>
              <div className="Inline" id="getSalaryViewFrontText">월급</div>
              <div className="Inline">
                <input className="UnFocusedInputText" id="getSalaryViewInputField2"></input>
              </div>
              <div className="Inline" id="getSalaryViewBackText">만원을 받고</div>
            </div>
            
            <div id="getSalarySpace2"/>

            <div>
              <div className="Inline" id="getSalaryViewFrontText">하루</div>
              <div className="Inline">
                <input className="UnFocusedInputText" id="getSalaryViewInputField3"></input>
              </div>
              <div className="Inline" id="getSalaryViewBackText">시간 근무합니다.</div>
            </div>
        </div>        

        <div id="getSalarySpace3"/>
    </div>
  );
}

export default GetSalaryView;
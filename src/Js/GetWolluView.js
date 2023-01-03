import '../Css/GetWolluView.css';
import '../CssUtil/CardStyle.css';
import '../CssUtil/TextStyle.css';
import '../CssUtil/Spaces.css';
import '../CssUtil/Utils.css';
import GetWolluView_ShowTextImage from "../Resources/Images/GetWolluView_ShowTextImage.svg";
import GetWolluView_WolluImage from "../Resources/Images/GetWolluView_WolluImage.svg";

function GetWolluView() {
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
                    <input className="FocusedInputText" id="getWolluViewInputField1"></input>
                </div>
                <div className="Inline" id="getWolluViewBackText">으로</div>
            </div>

            <div id="getWolluSpace4"></div>

            <div>
                <div className="Inline">
                    <input className="UnFocusedInputText" id="getWolluViewInputField2"></input>
                </div>
                <div className="Inline" id="getWolluViewBackText">분 월루했습니다.</div>
            </div>
            

        </div>
    </div>
    
  );
}

export default GetWolluView;
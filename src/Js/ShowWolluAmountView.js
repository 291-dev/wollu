import '../Css/ShowWalluAmountView.css';
import '../CssUtil/CardStyle.css';
import '../CssUtil/Spaces.css';
import '../CssUtil/Utils.css';
import '../CssUtil/Font.css';
import ShowWolluImageBorder from "../Resources/Images/ShowWolluImageBorder.svg";
import ShowWolluImageEffect from "../Resources/Images/ShowWolluImageEffect.svg";
import EatWolluImage from "../Resources/Images/EatWolluImage.svg";

function ShowWalluAmountView() {
  return (
    <div className="ShowWolluAmountView" id="ShowCard" >
        <div id="cardTopSpaces"/>
        <div className="CombineImages">
            <img src={ShowWolluImageBorder} id="showWolluImageBorder"/>
            <img src={ShowWolluImageEffect} id="showWolluImageEffect"/>
            <div className="InterRegular" id="showWolluTextBoundary">
                <div className="Inline" id="showWolluFactorText">커피/간식먹기</div>
                <div className="Inline" id="showWolluText1">로</div>
                <br/>
                <div id="showWolluSpace2"/>
                <div className="Inline" id="showWolluFactorText">12500원</div>
                <div className="Inline" id="showWolluText2">루팡중입니다!</div>               
            </div>
            <img src={EatWolluImage} id="eatWolluImage"/>
            <div id="showWolluNameBox">
                <div className="Rebecca" id="showWolluNameText"> 간식 루팡</div>
            </div>
        </div>
    </div>
  );
}

export default ShowWalluAmountView;
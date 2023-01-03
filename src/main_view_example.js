import WolluColors from "./resources/WolluColors";
import './MainView.css';
import maintext_1 from "./resources/maintext_1.svg"
import maintext_2 from "./resources/maintext_2.svg"
import maintext_3 from "./resources/maintext_3.svg"
import maintext_4 from "./resources/maintext_4.svg"
import maintext_5 from "./resources/maintext_5.svg"
import walluicon from "./resources/walluicon.svg"
//import getsalaryview_image from "./resources/getsalaryview_image.svg"
import getsalaryview_image from "./resources/test.svg"

const MainView = () => {
    return (
        <div className = "WalluBackground">
            <div className = "MainView">
                <div className = "TopMargin"></div>
                <div className = "WalluDetailText" > 사장님 돈은 제가 가져갑니다</div>
                <div className = "WalluMainText" >
                    <img src={maintext_1}/>
                    <img src={maintext_2}/> 
                    <img src={maintext_3}/> 
                    <img src={maintext_4}/> 
                    <img src={maintext_5}/> 
                </div>
                <img src ={walluicon} className="WalluIcon"/>
            </div>
            
            <div className = "GetSalaryView">
                <img src={getsalaryview_image} className="GetSalaryViewImage"/>
                <div className="GetSalaryViewTextStyle">
                    <div id="GetSalaryViewText1">사장님, 안녕하세요.</div>
                    <div id="GetSalaryViewText2">저 </div>
                    <div class="WalluInputText">
                        <input class="WalluInputText" id="GetNameInput"/>
                    </div>
                    <div id="GetSalaryViewText2">은/는 </div>
                    <br/>
                    <div id="GetSalaryViewText2">월급 </div>
                    <div class="WalluInputText">
                        <input class="WalluInputText" id="GetNameInput2"/>
                    </div>
                    <div id="GetSalaryViewText2">만원을 받고 </div>
                    <br/>
                    <div id="GetSalaryViewText2">하루 </div>
                    <div class="WalluInputText">
                        <input class="WalluInputText" id="GetNameInput3"/>
                    </div>
                    <div id="GetSalaryViewText2">시간 근무합니다 </div>

                </div>
            </div>

            <div className = "GetWalluView">
                what should i do
            </div>
        </div>
    )
}

export default MainView;

import React, {FC} from 'react';
import "../Css/WolluItemBottomSheet.css";
import bottomSheetItemUnSelected from "../Resources/Images/bottomSheetItemUnSelected.svg";


function WolluItemBottomSheet(wolluItemSelected,setWolluItemSelected,wolluItemText,setWolluItemText) {
    
    const hideBottomSheet = () => {     
        if (wolluItemSelected != -1) {
            let container = document.querySelector("#bottomSheetContainer");
            let bottomSheet = document.querySelector("#bottomSheetContainer #bottomSheet");
            bottomSheet.classList.remove('active');
            setTimeout(()=> {
                container.classList.remove("active");
            }, 500);
        } else {
            alert("하나의 항목을 선택해주세요");
        }
    };

    var selection_list = [0,0,0,0,0,0,0,0];

    const onButtonSheetItemClicked = (selected) => {
        let adjustButton = document.querySelector("#bottomSheetAdjustButton");
        if (selection_list[selected-1] == 1) {
            selection_list[selected-1] = 0;
            // off self event
            adjustButton.classList.remove("active");
        } else {
            selection_list = [0,0,0,0,0,0,0,0];
            selection_list[selected-1] = 1;
            // on target evnet
            adjustButton.classList.add("active");
            setWolluItemSelected(selected);
        }

        var selection_index = 1;
        for (selection_index = 1; selection_index < selection_list.length+1; selection_index ++) {
            let selected_item_text = document.getElementById("bottomSheetItemText" + selection_index);
            let selected_item_image = document.getElementById("bottomSheetItemImage" + selection_index);
            if (selection_list[selection_index-1] == 1) {
                selected_item_text.classList.add("bottomSheetItemClickedText");
                selected_item_image.classList.add("bottomSheetItemClickedImage");                
            } else {
                selected_item_text.classList.remove("bottomSheetItemClickedText");
                selected_item_image.classList.remove("bottomSheetItemClickedImage");
            }
        }

        // set text
        console.log("selected : ", selected);
        if (selected == -1)
            setWolluItemText("");
        else if (selected == 1){
            setWolluItemText("업무 없음");
        }
        else if (selected == 2){
            setWolluItemText("커피/간식 먹기");
        }
        else if (selected == 3){
            setWolluItemText("화장실 가기");
        }
        else if (selected == 4){
            setWolluItemText("바람 쐬기");
        }
        else if (selected == 5){
            setWolluItemText("인터넷 서핑하기");
        }
        else if (selected == 6){
            setWolluItemText("담배 피우기");
        }
        else if (selected == 7){
            setWolluItemText("딴 짓 하기");
        }
        else if (selected == 8){
            setWolluItemText("이직 준비");
        } else {
            setWolluItemText("???");
        }
        

    };
    
  return (
    <div>
        <div id="bottomSheetContainer">
            <div id="bottomSheet">
                <div id="bottomSheetHeader"></div>
                <div id="bottomSheetSpace1"></div>
                <div id="bottomSheetBody">
                    <div id="bottomSheetSpace2"/>
                    <div id="bottomSheeetTextFields">
                        <div className="bottomSheetUnSelected" onClick={() => onButtonSheetItemClicked(1)}>
                            <div id = "bottomSheetItemText1">업무 없음</div>
                            <img id="bottomSheetItemImage1" src={bottomSheetItemUnSelected}/>
                        </div>
                        <div id="bottomSheetItemSpace"/>

                        <div className="bottomSheetUnSelected" onClick={() => onButtonSheetItemClicked(2)}>
                            <div id = "bottomSheetItemText2">커피/간식먹기</div>
                            <img id="bottomSheetItemImage2" src={bottomSheetItemUnSelected}/>
                        </div>
                        <div id="bottomSheetItemSpace"/>

                        <div className="bottomSheetUnSelected" onClick={() => onButtonSheetItemClicked(3)}>
                            <div id = "bottomSheetItemText3">화장실 가기</div>
                            <img id="bottomSheetItemImage3" src={bottomSheetItemUnSelected}/>
                        </div>
                        <div id="bottomSheetItemSpace"/>

                        <div className="bottomSheetUnSelected" onClick={() => onButtonSheetItemClicked(4)}>
                            <div id = "bottomSheetItemText4">바람 쐬기</div>
                            <img id="bottomSheetItemImage4" src={bottomSheetItemUnSelected}/>
                        </div>
                        <div id="bottomSheetItemSpace"/>

                        <div className="bottomSheetUnSelected" onClick={() => onButtonSheetItemClicked(5)}>
                            <div id = "bottomSheetItemText5">인터넷 서핑하기</div>
                            <img id="bottomSheetItemImage5" src={bottomSheetItemUnSelected}/>
                        </div>
                        <div id="bottomSheetItemSpace"/>

                        <div className="bottomSheetUnSelected" onClick={() => onButtonSheetItemClicked(6)}>
                            <div id = "bottomSheetItemText6">담배 피우기</div>
                            <img id="bottomSheetItemImage6" src={bottomSheetItemUnSelected}/>
                        </div>
                        <div id="bottomSheetItemSpace"/>

                        <div className="bottomSheetUnSelected" onClick={() => onButtonSheetItemClicked(7)}>
                            <div id = "bottomSheetItemText7">딴짓하기</div>
                            <img id="bottomSheetItemImage7" src={bottomSheetItemUnSelected}/>
                        </div>
                        <div id="bottomSheetItemSpace"/>

                        <div className="bottomSheetUnSelected" onClick={() => onButtonSheetItemClicked(8)}>
                            <div id = "bottomSheetItemText8">이직 준비</div>
                            <img id="bottomSheetItemImage8" src={bottomSheetItemUnSelected}/>
                        </div>
                    </div>
                    <div id="bottomSheetSpace3"/>
                    <div id="bottomSheetAdjustButton" onClick={hideBottomSheet}>적용하기</div>
                    <div id="bottomSheetSpace4"/>
                </div>
            </div>
        </div>
    </div>
  );
}

export default WolluItemBottomSheet;
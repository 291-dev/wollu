import React,{useState} from 'react';
import styled from 'styled-components';
import bottomSheetItemUnSelected from "../Resources/Images/bottomSheetItemUnSelected.svg";
import bottomSheetItemSelected  from "../Resources/Images/bottomSheetItemSelected.svg";
import "./bottomsheet.css";

export default function BottomSheet(wolluInfo, showWolluInfo, test_value){
    const [wolluItemText,setWolluItemText] = useState('');
    const [wolluItemSelected,setWolluItemSelected] = useState(-1);
    const [showWolluText,setShowWolluText] = useState('');
    const [roopangText,setRoopangText] = useState('');
  
    var window_width = window.innerWidth;
    var window_height = window.innerHeight;

    if (window_width > 375) {
        window_width = 375;
    }
    const width_standard = 375;
    const height_standard = 811;

    const card_height = window_height*0.8578;
    const card_width = card_height * 0.4842;

    const Container = styled.div`
        position: fixed;
        z-index: 1;
        top: 0px;
        left: 0px;
        width: 100%;
        height: 100%;
        background-color:rgba(0,0,0,0.85);
        //display: ${showWolluInfo.isBottomSheetOn ? "flex" : "none"};
        align-items: flex-end;
        justify-content: center;
        //display:flex;
        display: none;
    `;
    const BottomSheetContent = styled.div`
            //transform: translateY(100%);
            //transition: transform 0.4s ease-in-out;
        `;
    const BottomSheetHeader = styled.div`
        margin-left : auto;
        margin-right : auto;
        background-color: white;
        width: ${39/width_standard*window_width}px;
        height: ${4/height_standard * window_height}px;
        border-radius: 2px; 
    `;

    const BottomSheetBody = styled.div`
        margin-top: ${8/height_standard*window_height}px;
        background-color: white;
        border-radius: 24px 24px 0px 0px;
        width: ${window_width}px;
        height: max-content;
        justify-content: center;
        align-items: center;
    `;

    const BottomSheetBodySelectionSpace = styled.div`
        padding-top:${50/height_standard*window_height}px;
    `;
    const BottomSheetSelection = styled.div`
        margin-left:auto;
        margin-right:auto;
        height:max-content;
        width: ${311/width_standard*window_width}px;
    `;
    const BottomSheetUnSelected = styled.div`
        text-align: left;
        font-family: "pretendard_regular";
        //font-size: ${16/height_standard*window_height}px;
        line-height: 20px;
        font-size: 16px;
        color:#AAAAAA;
        vertical-align: auto;
        justify-content: space-between;
        display: flex;
    `;

    const SelectionText = styled.div`
    `;
    const SelectionImage = styled.img`
    `;
    const TestImage = styled.img`
    `;
    const SelectionSpace = styled.div`
        padding-top: ${20/height_standard*window_height}px;
    `;


    const AdjustButton = styled.div`
        margin-top:${34/height_standard*window_height}px;
        margin-left : auto;
        margin-right: auto;
        width: ${327/width_standard*window_width}px;
        height: ${43/height_standard*window_height}px;
        text-align: center;
        background-color: #AAAAAA;
        color: white;
        border-radius: 8px;
        font-family: "pretendard_semibold";
        font-size: ${16/height_standard*window_height}px;
        display:flex;
        justify-content: center;
        align-items: center;
        `;
    const BottomMargin = styled.div`
        padding-top: ${34/height_standard*window_height}px;
    `;

    let selected_number = -1;
    const hideBottomSheet = () => {     
        if (selected_number != -1) {
            let container = document.querySelector(".Container");
            let bottomSheet = document.querySelector(".Container .BottomSheetContent");
            bottomSheet.classList.remove('active');
            setTimeout(()=> {
                container.classList.remove("active");
            }, 500);
        } else {
            alert("하나의 항목을 선택해주세요");
        }
    };

    const SelectionClicked = (number) => {
        selected_number = number;
        
        let wolluFactorInputTextValue = document.querySelector(".WolluFactor");
        wolluFactorInputTextValue.setAttribute("value","");
        if (number == 0){
            wolluInfo.wolluFactor = 0;
            wolluFactorInputTextValue.setAttribute("value",'업무 없음');
            showWolluInfo.wolluFactorText = "업무가 없어";
            showWolluInfo.wolluTitle = "찐루팡";
        } else if (number == 1) {
            wolluInfo.wolluFactor = 1;
            wolluFactorInputTextValue.setAttribute("value",'커피/간식 먹기');
            showWolluInfo.wolluFactorText = "커피/간식 먹기";
            showWolluInfo.wolluTitle = "간식 루팡";           
        } else if (number == 2) {
            wolluInfo.wolluFactor = 2;
            wolluFactorInputTextValue.setAttribute("value",'화장실 가기');
            showWolluInfo.wolluFactorText = "화장실 가기";
            showWolluInfo.wolluTitle = "똥루팡";            
        } else if (number == 3) {
            wolluInfo.wolluFactor = 3;
            wolluFactorInputTextValue.setAttribute("value",'바람 쐬기');
            showWolluInfo.wolluFactorText = "바깥 바람쐬며";
            showWolluInfo.wolluTitle = "바람루팡";            
        } else if (number == 4) {
            wolluInfo.wolluFactor = 4;
            wolluFactorInputTextValue.setAttribute("value",'인터넷 서핑하기');
            showWolluInfo.wolluFactorText = "인터넷 서핑하기";
            showWolluInfo.wolluTitle = "전기세 루팡";            
        } else if (number == 5) {
            wolluInfo.wolluFactor = 5;
            wolluFactorInputTextValue.setAttribute("value",'담배 피우기');
            showWolluInfo.wolluFactorText = "담배 피우기";
            showWolluInfo.wolluTitle = "흡연 루팡";            
        } else if (number == 6) {
            wolluInfo.wolluFactor = 6;
            wolluFactorInputTextValue.setAttribute("value",'딴 짓 하기');
            showWolluInfo.wolluFactorText = "딴짓하기";
            showWolluInfo.wolluTitle = "딴짓 루팡";            
        } else if (number == 7) {
            wolluInfo.wolluFactor = 7;
            wolluFactorInputTextValue.setAttribute("value",'이직 준비');
            showWolluInfo.wolluFactorText = "이직 준비하기";
            showWolluInfo.wolluTitle = "이직 루팡";            
        }
        let selected_text = document.querySelector(".SelText" + number);
        let selected_image = document.querySelector(".SelImage" + number);
        let adjust_button = document.querySelector(".BottomSheetButton");
        selected_text.classList.add("TextSelected");
        selected_image.classList.add("ImageSelected");
        adjust_button.classList.add("active");
        for (var i = 0; i< 8; i++){
            if (number == i)
                continue;
            let selected_text = document.querySelector(".SelText" + i);
            let selected_image = document.querySelector(".SelImage" + i);
            selected_text.classList.remove("TextSelected");
            selected_image.classList.remove("ImageSelected");        
        }


    }
    return (
        <Container className="Container">
            <BottomSheetContent className="BottomSheetContent">
                <BottomSheetHeader/>
                <BottomSheetBody>
                    <BottomSheetBodySelectionSpace/>
                    <BottomSheetSelection>
                        <BottomSheetUnSelected onClick={() => SelectionClicked(0)}>
                            <SelectionText className="SelText0">업무 없음</SelectionText>
                            <SelectionImage className="SelImage0" src={bottomSheetItemUnSelected}></SelectionImage>
                        </BottomSheetUnSelected>
                        <SelectionSpace/>
                        <BottomSheetUnSelected onClick={()=>SelectionClicked(1)}>
                            <SelectionText className="SelText1">커피/간식 먹기</SelectionText>
                            <SelectionImage className="SelImage1" src={bottomSheetItemUnSelected}></SelectionImage>
                        </BottomSheetUnSelected>
                        <SelectionSpace/>
                        <BottomSheetUnSelected onClick={()=>SelectionClicked(2)} >
                            <SelectionText className="SelText2">화장실 가기</SelectionText>
                            <SelectionImage className="SelImage2" src={bottomSheetItemUnSelected}></SelectionImage>
                        </BottomSheetUnSelected>
                        <SelectionSpace/>
                        <BottomSheetUnSelected onClick={()=>SelectionClicked(3)} >
                            <SelectionText className="SelText3">바람쐬기</SelectionText>
                            <SelectionImage className="SelImage3" src={bottomSheetItemUnSelected}></SelectionImage>
                        </BottomSheetUnSelected>
                        <SelectionSpace/>
                        <BottomSheetUnSelected onClick={()=>SelectionClicked(4)}>
                            <SelectionText className="SelText4">인터넷 서핑하기</SelectionText>
                            <SelectionImage className="SelImage4" src={bottomSheetItemUnSelected}></SelectionImage>
                        </BottomSheetUnSelected>
                        <SelectionSpace/>
                        <BottomSheetUnSelected onClick={()=>SelectionClicked(5)}>
                            <SelectionText className="SelText5">담배 피우기</SelectionText>
                            <SelectionImage className="SelImage5" src={bottomSheetItemUnSelected}></SelectionImage>
                        </BottomSheetUnSelected>
                        <SelectionSpace/>
                        <BottomSheetUnSelected onClick={()=>SelectionClicked(6)}>
                            <SelectionText className="SelText6">딴짓하기</SelectionText>
                            <SelectionImage className="SelImage6" src={bottomSheetItemUnSelected}></SelectionImage>
                        </BottomSheetUnSelected>
                        <SelectionSpace/>
                        <BottomSheetUnSelected onClick={()=>SelectionClicked(7)} >
                            <SelectionText className="SelText7">이직준비</SelectionText>
                            <SelectionImage className="SelImage7" src={bottomSheetItemUnSelected}></SelectionImage>
                        </BottomSheetUnSelected>
                    </BottomSheetSelection>
                    <AdjustButton className="BottomSheetButton" onClick={hideBottomSheet}>적용하기</AdjustButton>
                    <BottomMargin/>
                </BottomSheetBody>
            </BottomSheetContent>
        </Container>
    );
}
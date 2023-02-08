import React,{useState} from 'react';
import styled from 'styled-components';
import bottomSheetItemUnSelected from "../Resources/Images/bottomSheetItemUnSelected.svg";
import bottomSheetItemSelected  from "../Resources/Images/bottomSheetItemSelected.svg";
import "./bottomsheet.css";

export default function BottomSheet(){
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
        display: flex;
        align-items: flex-end;
        justify-content: center;
        display:flex; //display: none;
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
    var BottomSheetUnSelected = styled.div`
        text-align: left;
        font-family: "pretendard_regular";
        //font-size: ${16/height_standard*window_height}px;
        line-height: 20px;
        font-size: 16px;
        color: ${({selected}) => selected ? 'var(--gray01-color)' : '#AAAAAA'};
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
    const [selection0, setSelection0] = useState(false);
    const [selection1, setSelection1] = useState(false);
    const [selection2, setSelection2] = useState(false);
    const [selection3, setSelection3] = useState(false);
    const [selection4, setSelection4] = useState(false);
    const [selection5, setSelection5] = useState(false);
    const [selection6, setSelection6] = useState(false);
    const [selection7, setSelection7] = useState(false);
    const [current_number,set_current_number] = useState(-1);
    const selected = (number) => {
        if (number == 0) {
            setSelection0(true);
            setSelection1(false);
            setSelection2(false);
            setSelection3(false);
            setSelection4(false);
            setSelection5(false);
            setSelection6(false);
            setSelection7(false);
            set_current_number(0);
            setWolluItemText("업무 없음");
            setShowWolluText("업무가 없어");
            setRoopangText("찐루팡");
        }
        else if (number == 1){
            setSelection0(false);
            setSelection1(true);
            setSelection2(false);
            setSelection3(false);
            setSelection4(false);
            setSelection5(false);
            setSelection6(false);
            setSelection7(false);
            set_current_number(1);
            setWolluItemText("커피/간식 먹기");
            setShowWolluText("커피/간식먹기");
            setRoopangText("간식 루팡");
        }
        else if (number == 2){
            setSelection0(false);
            setSelection1(false);
            setSelection2(true);
            setSelection3(false);
            setSelection4(false);
            setSelection5(false);
            setSelection6(false);
            setSelection7(false);
            set_current_number(2);
            setWolluItemText("화장실 가기");
            setShowWolluText("화장실 가기");
            setRoopangText("똥루");
        }
        else if (number == 3){
            setSelection0(false);
            setSelection1(false);
            setSelection2(false);
            setSelection3(true);
            setSelection4(false);
            setSelection5(false);
            setSelection6(false);
            setSelection7(false);
            set_current_number(3);
            setWolluItemText("바람 쐬기");
            setShowWolluText("바깥바람쐬며");
            setRoopangText("바람루팡");
        }
        else if (number == 4){
            setSelection0(false);
            setSelection1(false);
            setSelection2(false);
            setSelection3(false);
            setSelection4(true);
            setSelection5(false);
            setSelection6(false);
            setSelection7(false);
            set_current_number(4);
            setWolluItemText("인터넷 서핑하기");
            setShowWolluText("인터넷 서핑하기");
            setRoopangText("전기세 루팡");
        }
        else if (number == 5){
            setSelection0(false);
            setSelection1(false);
            setSelection2(false);
            setSelection3(false);
            setSelection4(false);
            setSelection5(true);
            setSelection6(false);
            setSelection7(false);
            set_current_number(5);
            setWolluItemText("담배 피우기");
            setShowWolluText("담배 피우기");
            setRoopangText("흡연 루팡");
        }
        else if (number == 6){
            setSelection0(false);
            setSelection1(false);
            setSelection2(false);
            setSelection3(false);
            setSelection4(false);
            setSelection5(false);
            setSelection6(true);
            setSelection7(false);
            set_current_number(6);
            setWolluItemText("딴 짓 하기");
            setShowWolluText("딴짓하기");
            setRoopangText("딴짓루팡");
        }
        else if (number == 7){
            setSelection0(false);
            setSelection1(false);
            setSelection2(false);
            setSelection3(false);
            setSelection4(false);
            setSelection5(false);
            setSelection6(false);
            setSelection7(true);
            set_current_number(7);
            setWolluItemText("이직 준비");
            setShowWolluText("이직 준비하기");
            setRoopangText("이직 루팡");   
        }
    };

    const AdjustButton = styled.div`
        margin-top:${34/height_standard*window_height}px;
        margin-left : auto;
        margin-right: auto;
        width: ${327/width_standard*window_width}px;
        height: ${43/height_standard*window_height}px;
        text-align: center;
        background-color:  ${({current_number}) => current_number != -1 ? "var(--main-color)" : '#AAAAAA'};
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

    const hideBottomSheet = () => {     
        if (current_number != -1) {
            alert("todo");
            /*
            let container = document.querySelector("#bottomSheetContainer");
            let bottomSheet = document.querySelector("#bottomSheetContainer #bottomSheet");
            bottomSheet.classList.remove('active');
            setTimeout(()=> {
                container.classList.remove("active");
            }, 500);
            */
        } else {
            alert("하나의 항목을 선택해주세요");
        }
    };
    return (
        <Container>
            <BottomSheetContent>
                <BottomSheetHeader/>
                <BottomSheetBody>
                    <BottomSheetBodySelectionSpace/>
                    <BottomSheetSelection>
                        <BottomSheetUnSelected onClick={()=>selected(0)} selected={selection0}>
                            <SelectionText>업무 없음</SelectionText>
                            <SelectionImage className={selection0 ? "SelectedImage" : "NotSelectedImage"} selected={selection0}></SelectionImage>
                        </BottomSheetUnSelected>
                        <SelectionSpace/>
                        <BottomSheetUnSelected onClick={()=>selected(1)} selected={selection1}>
                            <SelectionText>커피/간식 먹기</SelectionText>
                            <SelectionImage className={selection1 ? "SelectedImage" : "NotSelectedImage"} selected={selection1}></SelectionImage>
                        </BottomSheetUnSelected>
                        <SelectionSpace/>
                        <BottomSheetUnSelected onClick={()=>selected(2)} selected={selection2}>
                            <SelectionText>화장실 가기</SelectionText>
                            <SelectionImage className={selection2 ? "SelectedImage" : "NotSelectedImage"} selected={selection2}></SelectionImage>
                        </BottomSheetUnSelected>
                        <SelectionSpace/>
                        <BottomSheetUnSelected onClick={()=>selected(3)} selected={selection3}>
                            <SelectionText>바람쐬기</SelectionText>
                            <SelectionImage className={selection3 ? "SelectedImage" : "NotSelectedImage"} selected={selection3}></SelectionImage>
                        </BottomSheetUnSelected>
                        <SelectionSpace/>
                        <BottomSheetUnSelected onClick={()=>selected(4)} selected={selection4}>
                            <SelectionText>인터넷 서핑하기</SelectionText>
                            <SelectionImage className={selection4 ? "SelectedImage" : "NotSelectedImage"} selected={selection4}></SelectionImage>
                        </BottomSheetUnSelected>
                        <SelectionSpace/>
                        <BottomSheetUnSelected onClick={()=>selected(5)} selected={selection5}>
                            <SelectionText>담배 피우기</SelectionText>
                            <SelectionImage className={selection5 ? "SelectedImage" : "NotSelectedImage"} selected={selection5}></SelectionImage>
                        </BottomSheetUnSelected>
                        <SelectionSpace/>
                        <BottomSheetUnSelected onClick={()=>selected(6)} selected={selection6}>
                            <SelectionText>딴짓하기</SelectionText>
                            <SelectionImage className={selection6 ? "SelectedImage" : "NotSelectedImage"} selected={selection6}></SelectionImage>
                        </BottomSheetUnSelected>
                        <SelectionSpace/>
                        <BottomSheetUnSelected onClick={()=>selected(7)} selected={selection7}>
                            <SelectionText>이직준비</SelectionText>
                            <SelectionImage className={selection7 ? "SelectedImage" : "NotSelectedImage"} selected={selection7}></SelectionImage>
                        </BottomSheetUnSelected>
                    </BottomSheetSelection>
                    <AdjustButton current_number={current_number} onClick={hideBottomSheet}>적용하기</AdjustButton>
                    <BottomMargin/>
                </BottomSheetBody>
            </BottomSheetContent>
        </Container>
    );
}
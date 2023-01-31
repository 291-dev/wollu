import React, { useEffect, useRef, useState } from 'react';
import styled from 'styled-components';
import Slide from './WolluAggroCard';
import img1 from '../Resources/Images/WolluFabicon192.png';
import img2 from '../Resources/Images/WolluFabicon192.png';
import img3 from '../Resources/Images/WolluFabicon192.png';

const TOTAL_SLIDES = 2; // 전체 슬라이드 개수(총3개. 배열로 계산)

export default function WolluAggroCardSlider() {
  const [currentSlide, setCurrentSlide] = useState(0);
  const slideRef = useRef(null);

  // Next 버튼 클릭 시
  const NextSlide = () => {
    if (currentSlide >= TOTAL_SLIDES) {
      // 더 이상 넘어갈 슬라이드가 없으면
      setCurrentSlide(0); // 1번째 사진으로 넘어갑니다.
      // return;  // 클릭이 작동하지 않습니다.
    } else {
      setCurrentSlide(currentSlide + 1);
    }
  };
  // Prev 버튼 클릭 시
  const PrevSlide = () => {
    if (currentSlide === 0) {
      setCurrentSlide(TOTAL_SLIDES); // 마지막 사진으로 넘어갑니다.
      // return;  // 클릭이 작동하지 않습니다.
    } else {
      setCurrentSlide(currentSlide - 1);
    }
  };

  useEffect(() => {
    slideRef.current.style.transition = 'all 0.5s ease-in-out';
    slideRef.current.style.transform = `translateX(-${currentSlide}00%)`; // 백틱을 사용하여 슬라이드로 이동하는 에니메이션을 만듭니다.
  }, [currentSlide]);

  const onTouchStart=()=>{
    NextSlide();
  }

  return (    
    <Container>
      <Text>
        <h1>호두 아가 시절</h1>
        <p>{currentSlide + 1}번 째 사진</p>
      </Text>
      <div onTouchStart={onTouchStart}>
      <SliderContainer ref={slideRef}>
        <Slide text1={"직장인 하루 평균 담배로 월루하는 시간"} text2={"확인하러가기"} />
        <Slide text1={"내 나이대 친구들은 얼마나"} text2={"루팡하고 있을까?"} />
        <Slide text1={"나는 평균적으로 얼마나"} text2={"루팡할까?"} />
        
      </SliderContainer>

      </div>
      <Center>
        <Button onClick={PrevSlide}>Prev</Button>
        <Button onClick={NextSlide}>Next</Button>
      </Center>
    </Container>
  );
}
const Container = styled.div`
  width: 327px;
  margin: auto;
  height: 1000px;
  overflow: hidden; // 선을 넘어간 이미지들은 숨겨줍니다.
`;
const Button = styled.div`
  all: unset;
  padding: 1em 2em;
  margin: 2em 2em;
  color: burlywood;
  border-radius: 10px;
  border: 1px solid burlywood;
  cursor: pointer;
  &:hover {
    background-color: burlywood;
    color: #fff;
  }
`;
const SliderContainer = styled.div`
  width : 327;
  height:135;
  margin: 0 auto;
  margin-bottom: 2em;
`;
const Text = styled.div`
  text-align: center;
  color: burlywood;
  p {
    color: #fff;
    font-size: 20px;
    background-color: burlywood;
    display: inline-block;
    border-radius: 50px;
    padding: 0.5em 1em;
  }
`;
const Center = styled.div`
  text-align: center;
`;
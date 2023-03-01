import React,{useState} from 'react';
import styled from 'styled-components';
import "../CssUtil/Color.css";

export default function AD(){
    const AD_AREA = styled.div`
        background-color: var(--main-background-color);
        width: 100%;
        align-items: center;
        justify-content: center;
    `;
    const KAKAO_AD = styled.ins`
        display: flex;
        margin-left:auto;
        margin-right:auto;
    `;
    return (
        <AD_AREA>
            <KAKAO_AD className="kakao_ad_area"
            data-ad-unit = "DAN-oR5y5Ly1zBql2L5U" 
            data-ad-width = "300" 
            data-ad-height = "250"
            ></KAKAO_AD>
        </AD_AREA>
    )
}

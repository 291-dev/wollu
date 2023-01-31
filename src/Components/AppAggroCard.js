import React from "react";
import styled from 'styled-components';


export default function AppAggroCard(test) {
    const AppAggroCardContainer = styled.div`
    width: 500px;
    height: 300px;
    background-color: var(--main-color);
    color: orange;
    float:left;
    `;
    return (
        <AppAggroCardContainer>
            {test}
        </AppAggroCardContainer>
    );
}
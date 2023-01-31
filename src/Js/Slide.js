import React from 'react';
import styled from 'styled-components';

const DIV = styled.img`
  width: 500px;
  height: 500px;
`;

export default function Slide({ img2 }) {
  return <DIV src={img2} />;
}
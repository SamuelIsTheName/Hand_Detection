import React, { useState,useEffect } from 'react';

const MoveBox = ({ x, y }) => {
  const [boxStyle, setBoxStyle] = useState({
    position: 'absolute',
    width: '50px',
    height: '50px',
    backgroundColor: 'blue',
    left: x + 'px',
    top: y + 'px',
    transition: 'left 0.5s, top 0.5s', // CSS transition properties
  });

  // You can update the boxStyle when x and y change
  // to trigger the animation
  useEffect(() => {
    setBoxStyle((prevStyle) => ({
      ...prevStyle,
      left: x + 'px',
      top: y + 'px',
    }));
  }, [x, y]);

  return <div style={boxStyle}></div>;
};

export default MoveBox;

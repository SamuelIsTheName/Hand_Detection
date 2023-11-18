import React, { useEffect, useState } from "react";

const MoveBox = ({ x, y }) => {
  const [boxStyle, setBoxStyle] = useState({
    position: 'absolute',
    width: '50px',
    height: '50px',
    backgroundColor: 'blue',
    left: x + 'px',
    top: y + 'px',
  });

  useEffect(() => {
    const targetPosition = { x, y };
    const duration = 500; // Animation duration in milliseconds
    let startTime;
    let requestId;

    const animateBox = (timestamp) => {
      if (!startTime) {
        startTime = timestamp;
      }

      const elapsed = timestamp - startTime;
      if (elapsed < duration) {
        const progress = elapsed / duration;
        const interpolatedX = interpolate(boxStyle.left, x + 'px', progress);
        const interpolatedY = interpolate(boxStyle.top, y + 'px', progress);

        setBoxStyle(prevStyle => ({
          ...prevStyle,
          left: interpolatedX,
          top: interpolatedY,
        }));

        requestId = requestAnimationFrame(animateBox);
      }
    };

    requestId = requestAnimationFrame(animateBox);

    return () => {
      if (requestId) {
        cancelAnimationFrame(requestId);
      }
    };
  }, [x, y]);

  // Helper function for linear interpolation
  function interpolate(start, end, progress) {
    return `calc(${start} + ${progress} * (${end} - ${start}))`;
  }

  return <div style={boxStyle}></div>;
};

export default MoveBox;

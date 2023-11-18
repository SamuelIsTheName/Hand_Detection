import React from "react";

const moveBox = ({x,y})=>{
    const boxStyle = {
        position: 'absolute',
        width: '50px',
        height: '50px',
        backgroundColor: 'blue',
        left: x + 'px',
        top: y + 'px',
    };
    
    return <div style={boxStyle}></div>;
};
export default moveBox;
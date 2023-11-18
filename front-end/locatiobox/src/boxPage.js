import { useEffect, useState } from 'react'
import style from './boxPage.module.css'
import Webcam from 'react-webcam'
import MoveBox from './BoxMovements/moveBoxV1';

function BoxPage(props) {

    const[mousePosition,setMousePosition]=useState({x:0,y:0});
    const[boxPosition,setBoxPosition]=useState({x:0,y:0});

    useEffect(()=>{

        const box = document.querySelector(`.${style.box}`);
        const boxPosition = box.getBoundingClientRect();
        setBoxPosition({
            x: boxPosition.left + window.scrollX,
            y: boxPosition.top + window.scrollY,
        });

        const HandleMouseMove =(e)=>{
            setMousePosition({x: e.clientX, y: e.clientY});
        };

        document.addEventListener('mousemove', HandleMouseMove);
        // console.log(props.boxData);
        return () =>{
            document.removeEventListener('mousemove', HandleMouseMove);
        }
    }, [])

    const move=()=>{
        alert("Clicked")
    }

    return (
        <>
      <div className={style.box} onMouseEnter={move}>
        
      </div>

      <div className={style.mousePositionBox}>
        <p>Mouse X: {mousePosition.x}</p>
        <p>Mouse Y: {mousePosition.y}</p>
      </div>

      <div className={style.boxPositionBox}>
        <p>Box X: {boxPosition.x}</p>
        <p>Box Y: {boxPosition.y}</p>
      </div>

      <div className={style.boxDataBox}>
            <p>HandData X: {props.boxData ? props.boxData[0] : 'N/A'}</p>
            <p>HandData Y: {props.boxData ? props.boxData[1] : 'N/A'}</p>
            
      </div>
      
      <MoveBox x={props.boxData[0]} y={props.boxData[1]}/>
      </>
    );
  }
  
  
  export default BoxPage;
  
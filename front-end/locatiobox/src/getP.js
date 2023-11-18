import axios from "axios";
import { useEffect, useState } from "react";
import BoxPage from "./boxPage";
import { io } from "socket.io-client";

function GetP() {

    const[data,setData]=useState(null);
    const socket = io("http://localhost:5000/hand_tracking");

    useEffect(()=>{
        const fetchData = async () =>{
            try{
                const response = await axios.get('http://127.0.0.1:5000/api/get_bbox1') 
                setData(response.data);
                console.log(response.data);
            }catch(error){
                console.error(error);
              };
        };
        
        const intervalId = setInterval(fetchData, 200);

        return () => {
            clearInterval(intervalId);
        };
    },[]);
    // useEffect(() => {
    //     socket.on("data-update", (newData) => {
    //       setData(newData);
    //     });
    
    //     return () => {
    //       socket.disconnect();
    //     };
    //   }, [socket]);

    return (
        <>
      <div>
        {data && (
            <div>
                {/* <p>X: {data[0]}, Y: {data[1]}, Width: {data[2]}, Height: {data[3]}</p> */}
                <BoxPage boxData={data}/>
            </div>
        )}
      </div>

     
      </>
    );
  }
  export default GetP;
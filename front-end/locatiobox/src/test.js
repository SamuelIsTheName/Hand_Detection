import React, { useEffect, useState } from 'react';
import socketIOClient from 'socket.io-client';

const MyTest = () => {
  const [data, setData] = useState(null);

  useEffect(() => {
    const socket = socketIOClient("http://localhost:5000/hand_tracking");
    console.log("yes yes");
    socket.on("data-update", (receivedData) => {
      // Update your component's state with the received data
      setData(receivedData);
      console.log(receivedData)
    //   if(receivedData !== null){
    //     console.log("yes");
    //   }else{console.log("no");}
    });

    // return () => {
    //   socket.disconnect();
    // };
  }, []);

  return (
    <div>
      <h2>Data from the server:</h2>
      <pre>{JSON.stringify(data, null, 2)}</pre>
    </div>
  );
};

export default MyTest;

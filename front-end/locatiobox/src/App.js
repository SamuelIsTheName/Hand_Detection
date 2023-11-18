import './App.css';
import {BrowserRouter as Router, Route, Routes } from 'react-router-dom';
import BoxPage from './boxPage'
import GetP from './getP';
import MyTest from './test';

function App() {
  return (
    <div className="App">
      <Router>
        <Routes>
            <Route element=''>
              <Route path="/blank" element={<BoxPage />}/>
              <Route path="/" element={<GetP />}/>
              <Route path="/webSock" element={<MyTest />}/>
            </Route>
        </Routes>
      </Router>
    </div>
  );
}


export default App;

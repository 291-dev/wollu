import '../Css/MainView.css';
import MainView_WolluMainImage from "../Resources/Images/MainView_WolluMainImage.svg";
import MainView_291LogoImage from "../Resources/Images/MainView_291LogoImage.svg";

function MainView() {
  return (
    <div className="MainView">
      <div id="mainSpace1"/>
      <div id="detailText"> 사장님 돈은 제가 가져갑니다</div>
      <div id="mainSpace2"/>
      <img src={MainView_WolluMainImage}/>
      <div id="mainSpace3"/>
      <img src={MainView_291LogoImage}/>
      <div id="mainSpace4"/>
    </div>
  );
}

export default MainView;
// $(document).ready(function(){
  function setBodyColor(picker) {
    document.getElementsByTagName('body')[0].style.backgroundColor = '#' + picker.toString()
  }
  function setH1Color(picker) {
    document.getElementById('userH1').style.color = '#' + picker.toString()
  }
  function setTextColor(picker) {
    document.getElementsByTagName('body')[0].style.color = '#' + picker.toString()
  }
  //This doesn't work in the .js files. 
  var color = <%= @colors.to_json %>; 
  setBodyColor(color.bodyColor);
  setH1Color(color.h1Color);
  setTextColor(color.textColor);
// })
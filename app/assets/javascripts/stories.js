$('input#place').geocomplete().bind("geocode:result", function(event, result){
  console.log(result);
});

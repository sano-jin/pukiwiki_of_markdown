const convert = () => {
  console.log(PwOfMd, PwOfMd.add(3, 4));

  const elemInput = document.getElementById("input");
  const elemOutput = document.getElementById("output");

  const inputText = elemInput.value;
  console.log(inputText);
  const outputText = PwOfMd.convert(inputText);
  console.log(outputText);
  elemOutput.innerText = outputText;
};

const copy = () => {
  // Get the text field
  const copyText = document.getElementById("output");
  const copyButton = document.getElementById("copy-button");

  // Copy the text inside the text field
  navigator.clipboard.writeText(copyText.innerText);

  // Alert the copied text
  console.log("Copied the text: " + copyText.innerText);

  copyButton.innerText = "Pukiwiki (Copyied)";

  const myCallback = () => {
    copyButton.innerText = "Pukiwiki (Click to copy)";
  };
  setInterval(myCallback, 3000);
};

window.onload = () => {
  convert();
};

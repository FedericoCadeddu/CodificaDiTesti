function toggleContent(elementId) {
    var content = document.getElementById(elementId);
        if (content.style.display === 'none' || content.style.display === '') {
            content.style.display = 'block';
        } else {
            content.style.display = 'none';
        }
    }
    

var originalText1;
var originalText2;

function gestoreLoad() {
    try {
        originalText1 = document.querySelector('#originalText1').innerHTML;
        originalText2 = document.querySelector('#originalText2').innerHTML;
        console.log(originalText2);
    } catch (e) {
        alert("gestoreLoad " + e);
    }
}

function showTag(tag, originalTextId, buttonId) {
    var originalTextElement = document.querySelector('#' + originalTextId);
    var elementsToShow = originalTextElement.querySelectorAll('.' + tag);
    var allButtons = document.querySelectorAll('.button-container button');
    console.log(elementsToShow)
    console.log("showTag called with tag:", tag, "originalTextId:", originalTextId, "buttonId:", buttonId);

    var currentButton = document.getElementById(buttonId);
    var isButtonActive = currentButton.classList.contains('active');

    if (isButtonActive) {
        originalTextElement.innerHTML = (originalTextId === 'originalText1') ? originalText1 : originalText2;
    } else {
        elementsToShow.forEach(function (element) {
          element.style.display = 'inline';
          element.classList.add('highlighted');
            element.classList.add('highlighted');
        });
    }

    currentButton.classList.toggle('active', !isButtonActive);

    allButtons.forEach(function (button) {
        if (button !== currentButton) {
            button.classList.remove('active');
        }
    });
}

window.onload = gestoreLoad;

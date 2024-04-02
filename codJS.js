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

    // Inizializza le slide dopo aver caricato il documento
    showSlide(currentSlide);
}

function showTag(tag, originalTextId, buttonId) {
    var originalTextElement = document.querySelector('#' + originalTextId);
    var elementsToShow = originalTextElement.querySelectorAll('.' + tag);
    var allButtons = document.querySelectorAll('.button-container button');

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

var currentSlide = 1;
var totalSlides = 2; // Numero totale di slide

function showSlide(slideIndex) {
    var slides = document.querySelectorAll('.slide');
    if (slideIndex < 1) {
        currentSlide = totalSlides;
    }
    if (slideIndex > totalSlides) {
        currentSlide = 1;
    }
    for (var i = 0; i < slides.length; i++) {
        slides[i].style.display = "none";
    }
    slides[currentSlide - 1].style.display = "block";

    // Verifica se la slide corrente è associata al testo originale
    var originalText1Element = document.querySelector('#originalText1');
    var originalText2Element = document.querySelector('#originalText2');
    var buttonContainer1Element = document.querySelector('.button-container1');
    var buttonContainer2Element = document.querySelector('.button-container2');

    if (slides[currentSlide - 1].classList.contains('image1')) {
        originalText1Element.style.display = "block";
        originalText2Element.style.display = "none";
        buttonContainer1Element.style.display = "block";
        buttonContainer2Element.style.display = "none";
    } else {
        originalText1Element.style.display = "none";
        originalText2Element.style.display = "block";
        buttonContainer1Element.style.display = "none";
        buttonContainer2Element.style.display = "block";
    }
}

function prevSlide() {
    showSlide(currentSlide -= 1);

    // Aggiorna il testo e i bottoni in base alla slide corrente
    if (currentSlide === 1) {
        document.querySelector('#originalText1').style.display = "block";
        document.querySelector('#originalText2').style.display = "none";
        document.querySelector('.button-container1').style.display = "block";
        document.querySelector('.button-container2').style.display = "none";
    } else {
        document.querySelector('#originalText1').style.display = "none";
        document.querySelector('#originalText2').style.display = "block";
        document.querySelector('.button-container1').style.display = "none";
        document.querySelector('.button-container2').style.display = "block";
    }
}

function nextSlide() {
    showSlide(currentSlide += 1);

    // Aggiorna il testo e i bottoni in base alla slide corrente
    if (currentSlide === 1) {
        document.querySelector('#originalText1').style.display = "block";
        document.querySelector('#originalText2').style.display = "none";
        document.querySelector('.button-container1').style.display = "block";
        document.querySelector('.button-container2').style.display = "none";
    } else {
        document.querySelector('#originalText1').style.display = "none";
        document.querySelector('#originalText2').style.display = "block";
        document.querySelector('.button-container1').style.display = "none";
        document.querySelector('.button-container2').style.display = "block";
    }
}

// Assegna l'evento onload all'unione delle funzioni
window.onload = function() {
    gestoreLoad();
    
};

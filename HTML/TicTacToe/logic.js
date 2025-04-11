let currentplayer = 'X'

function auslesen() {

    let number1 = document.getElementById('number1').value, number2 = document.getElementById('number2').value;
    let n1 = parseFloat(number1);
    let n2 = parseFloat(number2);
    let Ergebnis = n1 + n2;
    document.getElementById('Output1').innerText = 'Ergebnis: ' + Ergebnis.toString();
}

function Zeichnen(a) {
    let pressedBox = document.getElementById(a);
    if (pressedBox.innerText == 'X' || pressedBox.innerText == 'O') {
        alert('Dieses Feld ist bereits belegt')
    } else {
        pressedBox.innerText = currentplayer;
        if (currentplayer === 'X') {
            currentplayer = 'O'
        } else {
            currentplayer = 'X'
        }
    }
}

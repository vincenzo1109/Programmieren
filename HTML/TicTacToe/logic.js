function auslesen() {

    let number1 = document.getElementById('number1').value, number2 = document.getElementById('number2').value;
    let n1= parseFloat(number1);
    let n2= parseFloat(number2);
    let Ergebnis = n1 + n2;
document.getElementById('Output1').innerText = 'Ergebnis: ' + Ergebnis.toString();
}

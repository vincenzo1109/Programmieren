function auslesen(Operator) {
    let number1 = document.getElementById('number1').value, number2 = document.getElementById('number2').value;
    let n1 = parseFloat(number1);
    let n2 = parseFloat(number2);
    Operator(n1, n2);
}

function addition(n1, n2) {
    let Ergebnis = n1 + n2;
    OutPut(Ergebnis)
}

function subtraction(n1, n2) {
    let Ergebnis = n1 - n2;
    OutPut(Ergebnis)
}

function division(n1, n2) {
    let Ergebnis = n1 / n2;
    OutPut(Ergebnis)
}

function multiplication(n1, n2) {
    let Ergebnis = n1 * n2;
    OutPut(Ergebnis)
}

function Faculty(n1) {
    let Ergebnis = n1;
    for (let i = 1; i < n1; i++) {
        Ergebnis = Ergebnis * i;
    }
    OutPut(Ergebnis)
}

function squareroot(n1) {
    let Ergebnis = Math.sqrt(n1);
    OutPut(Ergebnis)
}

function Square(n1) {
    let Ergebnis = n1 * n1;
    OutPut(Ergebnis)
}

function OutPut(Ergebnis) {
    document.getElementById('Output1').innerText = 'Ergebnis: ' + Ergebnis.toString()
}

function sizing() {
    let container = document.querySelectorAll('button');
    for (let i = 0; i < container.length; i++) {
        let copyContainer = container[i];

        let size = copyContainer.clientHeight;
        copyContainer.style.fontSize = (size * 0.5) + 'px';
    }
}

window.addEventListener('resize', sizing);
sizing();
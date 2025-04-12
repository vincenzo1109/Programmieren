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
    Board_Kopieren()
}

function Board_Kopieren() {
    let fields = []
    for (let i = 0; i < 9; i++) {
        let field = document.getElementById(i).innerText;
        fields.push(field);
    }
    console.log(fields);
    Gewonnen(fields);
    Unentschieden(fields)
}

function Gewonnen(Board) {
    for (let i = 0; i < 9; i++) {
//Zeilenprüfung
        if (Board[3 * i] === Board[i * 3 + 1] && Board[i * 3 + 1] === Board[i * 3 + 2] && Board [i * 3] !== '') {
            setTimeout(function Timer() {
                if (Board[i * 3] === 'X') {
                    alert('X     hat gewonnen')
                    Reset(Board)

                } else if (Board[i * 3] === 'O') {
                    alert('O hat gewonnen')
                    Reset(Board)
                }
            }, 150)
        }
    }
}

function Reset(Board) {
    for (let j = 0; j < 9; j++) {
        Board[j] = ''
        document.getElementById(j).innerText = Board[j]
    }
}

function Unentschieden(board) {
    setTimeout(() =>{
        let a = 0
        for (let i = 0; i < 9; i++) {
            if (board[i] !== '') {
                a = a + 1
                console.log(a)
            }
        }
        if (a === 9){
            alert('Es ist ein Unentschieden')
            Reset(board)}
    }, 150)

}
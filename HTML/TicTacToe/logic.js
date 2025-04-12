alert('Falls du diese Website auf einem Handy (oder ähnlichem) besuchst, gehe bitte in das Drei-Punkte-Menu und wähle Desktop-Modus aus.' +
    'Sonst stimmen die Proportionen der Felder nicht überein. Danke :)')
currentplayer = 'X'
let a = 0
let b = 0

function auslesen() {

    let number1 = document.getElementById('number1').value, number2 = document.getElementById('number2').value;
    let n1 = parseFloat(number1);
    let n2 = parseFloat(number2);
    let Ergebnis = n1 + n2;
    document.getElementById('Output1').innerText = 'Ergebnis: ' + Ergebnis.toString();
}

function Zeichnen(a) {
    let pressedBox = document.getElementById(a);
    if (pressedBox.innerText === 'X' || pressedBox.innerText === 'O') {
        alert('Dieses Feld ist bereits belegt')
    } else {
        pressedBox.innerText = currentplayer;
        if (currentplayer === 'X') {
            currentplayer = 'O'
        } else {
            currentplayer = 'X'
        }
    }
    let Player1 = 'X'
    let Player2 = 'O'
    if (document.getElementById("player1").value !== '') {
        Player1 = document.getElementById("player1").value;
    }
    if (document.getElementById("player2").value !== '') {
        Player2 = document.getElementById("player2").value;
    }
    console.log(Player1, Player2);

    Board_Kopieren(Player1, Player2)
}

function Board_Kopieren(Player1, Player2) {
    let fields = []
    for (let i = 0; i < 9; i++) {
        let field = document.getElementById(i).innerText;
        fields.push(field);
    }
    console.log(fields);
    Gewonnen(fields, Player1, Player2);
    Unentschieden(fields);
}

function Gewonnen(Board, Player1, Player2) {
    for (let i = 0; i < 9; i++) {
//Zeilenprüfung
        if (Board[3 * i] === Board[i * 3 + 1] && Board[i * 3 + 1] === Board[i * 3 + 2] && Board [i * 3] !== '') {
            setTimeout(function Timer() {
                if (Board[i * 3] === 'X') {
                    Points(Player1)
                    a = a + 1
                    document.getElementById("Points").innerText = 'Punktestand: ' + a + ' : ' + b
                    Reset(Board)

                } else if (Board[i * 3] === 'O') {
                    Points(Player2)
                    b = b + 1
                    document.getElementById("Points").innerText = 'Punktestand: ' + a + ' : ' + b
                    Reset(Board)
                }
            }, 150)
        }
        if (Board[i] === Board[i + 3] && Board[i + 3] === Board[i + 6] && Board [i] !== '') {
            setTimeout(function Timer() {
                if (Board[i] === 'X') {
                    Points(Player1)
                    a = a + 1
                    document.getElementById("Points").innerText = 'Punktestand: ' + a + ' : ' + b
                    Reset(Board)

                } else if (Board[i] === 'O') {
                    Points(Player2)
                    b = b + 1
                    document.getElementById("Points").innerText = 'Punktestand: ' + a + ' : ' + b
                    Reset(Board)
                }
            }, 150)
        }
        if (Board[0] === Board[4] && Board[4] === Board[8] && Board [0] !== '') {
            setTimeout(function Timer() {
                if (Board[0] === 'X') {
                    Points(Player1)
                    a = a + 1
                    document.getElementById("Points").innerText = 'Punktestand: ' + a + ' : ' + b
                    Reset(Board)

                } else if (Board[0] === 'O') {
                    Points(Player2)
                    b = b + 1
                    document.getElementById("Points").innerText = 'Punktestand: ' + a + ' : ' + b
                    Reset(Board)
                }
            }, 150)

            if (Board[2] === Board[4] && Board[4] === Board[6] && Board [2] !== '') {
                setTimeout(function Timer() {
                    if (Board[2] === 'X') {
                        Points(Player1)
                        a = a + 1
                        document.getElementById("Points").innerText = 'Punktestand: ' + a + ' : ' + b
                        Reset(Board)

                    } else if (Board[2] === 'O') {
                        Points(Player2)
                        b = b + 1
                        document.getElementById("Points").innerText = 'Punktestand: ' + a + ' : ' + b
                        Reset(Board)
                    }
                }, 150)
            }
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
    setTimeout(() => {
        let c = 0
        for (let i = 0; i < 9; i++) {
            if (board[i] !== '') {
                c = c + 1
                console.log(a)
            }
        }
        if (c === 9) {
            alert('Es ist ein Unentschieden')
            Reset(board)
        }
    }, 150)
}

function Points(Player) {
    console.log('Gewinner: ' + Player);
    document.getElementById("Won").innerText = Player + ' hat gewonnen';
}

function Pointsreset() {
    a = 0
    b = 0
    document.getElementById("Points").innerText = 'Punktestand: ' + a + ' : ' + b
    document.getElementById("Won").innerText = ''
}

function FieldReset() {
    for (i = 0; i < 9; i++) {
        document.getElementById(i).innerText = ''
    }
}
// alert('Falls du diese Website auf einem Handy (oder ähnlichem) besuchst, gehe bitte in das Drei-Punkte-Menu und wähle Desktop-Modus aus und dann drehe es ins Querformat.'
//    'Sonst stimmt das Design nicht überein, da diese Website für Computer gedacht ist. Danke :) (Diese Nachricht erscheint erneut nach dem Aktualisieren, dann einfach wegdrücken)')
let currentplayerchar = 'X'
let currentplayername = 'X'
let a = 0
let b = 0
let Player1 = 'X'
let Player2 = 'O'
let x = 0

Points()

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
        pressedBox.innerText = currentplayerchar;
        if (currentplayerchar === 'X') {
            currentplayerchar = 'O'
        } else {
            currentplayerchar = 'X'
        }
        if (currentplayername === document.getElementById('player1').value) {
            currentplayername = Player2
        } else {
            currentplayername = Player1
        }
    }
    document.getElementById('Won').innerText = '';
    LabelCurrentplayer();
    Board_Kopieren();
    document.getElementById('Won').style.backgroundColor = '';
    document.getElementById('Won').style.border = '';
    document.getElementById('Won').style.borderRadius= '';
    document.getElementById('Won').style.padding= '';
}

function Board_Kopieren() {
    let fields = []
    for (let i = 0; i < 9; i++) {
        let field = document.getElementById(i).innerText;
        fields.push(field);
    }
    console.log(fields);
    Unentschieden(fields);
    Gewonnen(fields);
}

function Gewonnen(Board) {
    for (let i = 0; i < 9; i++) {
        //Zeilenprüfung
        if (Board[3 * i] === Board[i * 3 + 1] && Board[i * 3 + 1] === Board[i * 3 + 2] && Board [i * 3] !== '') {
            setTimeout(function Timer() {
                if (Board[i * 3] === 'X') {
                    Points(Player1);
                    Reset()

                } else if (Board[i * 3] === 'O') {
                    Points(Player2);
                    Reset()
                }
            }, 150)
        }
        //Spaltenprüfung
        if (Board[i] === Board[i + 3] && Board[i + 3] === Board[i + 6] && Board [i] !== '') {
            setTimeout(function Timer() {
                if (Board[i] === 'X') {
                    Points(Player1);
                    Reset()

                } else if (Board[i] === 'O') {
                    Points(Player2);
                    Reset()
                }
            }, 150)
        }
    }
    //Diagonale \
    if (Board[0] === Board[4] && Board[4] === Board[8] && Board [0] !== '') {
        setTimeout(function Timer() {
            if (Board[0] === 'X') {
                Points(Player1);
                Reset()

            } else if (Board[0] === 'O') {
                Points(Player2);
                Reset()
            }
        }, 150)
    }
    //Diagonale/
    if (Board[2] === Board[4] && Board[4] === Board[6] && Board [2] !== '') {
        {
            if (Board[2] === 'X') {
                Points(Player1);
                Reset()
            } else if (Board[2] === 'O') {
                Points(Player2);
                Reset()
            }
        }
    }
}

function Reset() {
    for (let j = 0; j < 9; j++) {
        document.getElementById(j).innerText = ''
    }
    Turn()
    currentplayerchar = 'X'

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
            document.getElementById("Won").innerText = 'Es ist ein Unentschieden'
            Reset(board)
        }
    }, 150)
}

function Points(Player) {
    console.log('Gewinner: ' + Player);
    document.getElementById("Won").innerText = Player + ' hat gewonnen';
    if (Player === Player1) {
        a = a + 1
        document.getElementById("Points").innerText = 'Punktestand: ' + a + ' : ' + b

    } else if (Player === Player2) {
        b = b + 1
        document.getElementById("Points").innerText = 'Punktestand: ' + a + ' : ' + b
    }
    document.getElementById('Won').style.backgroundColor = 'red';
    document.getElementById('Won').style.border = '3px solid Black';
    document.getElementById('Won').style.borderRadius= '10px';
    document.getElementById('Won').style.padding= '6px';
}

function Pointsreset() {
    a = 0
    b = 0
    document.getElementById("Points").innerText = 'Punktestand: ' + a + ' : ' + b
    document.getElementById("Won").innerText = ''
    document.getElementById('Won').style.backgroundColor = '';
    document.getElementById('Won').style.border = '';
    document.getElementById('Won').style.borderRadius= '';
    document.getElementById('Won').style.padding= '';
}

function LabelCurrentplayer() {
    document.getElementById('Currentplayer').innerText = currentplayername + ' ist dran';
    console.log(currentplayername + ' ist dran');
}

function FirstStart() {
    let z = 0
    for (let i = 0; i < 9; i++) {
        if (document.getElementById(i).innerText === '')
            z = z + 1
    }
    if (z === 9) {
        console.log(x);
        if (x <= 0) {
            if (document.getElementById("player1").value !== '') {
                Player1 = document.getElementById("player1").value;
            }
            if (document.getElementById("player2").value !== '') {
                Player2 = document.getElementById("player2").value;
            }
            if (currentplayername === document.getElementById('player1').value) {

            } else {
                currentplayername = Player1
            }
            document.getElementById('Currentplayer').innerText = Player1 + ' ist dran';
            document.getElementById("Points").innerText = 'Punktestand: 0 : 0'
        }

        document.getElementById('button').style.background = "#ff0000"

        document.getElementById('button').innerText = 'Erster Start (Namen speichern)'
        x = x - 1
        console.log(x);
    } else {
        x = x + 1;
        console.log(x);
        document.getElementById('button').style.background = "yellow"
        document.getElementById('button').innerText = 'Blockiert (Zuerst muss das Feld leer sein, dann wieder drauf drücken)'

    }
}

function Turn() {
    if (currentplayername === document.getElementById('player1').value) {
    } else {
        currentplayername = Player1
    }
    document.getElementById('Currentplayer').innerText = Player1 + ' ist dran';
    LabelCurrentplayer()
}

window.addEventListener('pageshow', function () {
    document.getElementById('Websites').selectedIndex = 0;
});
const cars = [
    {
        model: "Toyota Supra",
        fuel: "Benzin",
        seats: 2,
        acceleration: 4.4,
        price: 61000,
        speed: "250 km/h (abgeriegelt)",
        PS: 338,
        Antriebsart: "Heckantrieb",
        Getriebeart: "Automatik",
        Gears: 8,
        mass: 1570,
    },
    {
        model: "Ford Mustang",
        fuel: "Benzin",
        seats: 4,
        acceleration: 5.3,
        price: 46500,
        speed: "267 km/h",
        PS: 446,
        Antriebsart: "Heckantrieb",
        Getriebeart: "Automatik",
        Gears: 6,
        mass: 1818,
    },
    {
        model: "BMW M2",
        fuel: "Super",
        seats: 4,
        acceleration: 3.6,
        price: 76600,
        speed: "250 km/h (abgeriegelt)",
        PS: 480,
        Antriebsart: "Heckantrieb",
        Getriebeart: "Automatik",
        Gears: 8,
        mass: 1805,
    },
    {
        model: "Porsche GT3 RS",
        fuel: "Super",
        seats: 2,
        acceleration: 3.5,
        price: 190000,
        speed: "312 km/h",
        PS: 520,
        Antriebsart: "Heckantrieb",
        Getriebeart: "Schalter",
        Gears: 7,
        mass: 1500,
    },
    {
        model: "Porsche 718 Cayman s",
        fuel: "Super",
        seats: 2,
        acceleration: 4.3,
        price: 68000,
        speed: "285 km/h",
        PS: 350,
        Antriebsart: "Heckantrieb",
        Getriebeart: "Schalter",
        Gears: 7,
        mass: 1465,
    },
]

const Werte = {
    fuel: ["Benzin", "Super"],
    seats: [2, 5, 7],
    acceleration: [
        {min: "3m/s", max: "4m/s"},
        {min: "4m/s", max: "5m/s"},
        {min: "5m/s", max: "6m/s"}],
    price: [
        {min: "5.000€", max: "10.000€"},
        {min: "10.000€", max: "20.000€"},
        {min: "20.000€", max: "50.000€"},
        {min: "50.000€", max: "80.000€"},
        {min: "80.000€", max: "100.000€"},
        {min: "100.000€", max: "200.000€"},
        {min: "200.000€", max: "300.000€"},
    ],
    speed: [],
}

const KategorienNamen = {
    fuel: "Kraftstoff",
    seats: "Sitzplätze",
    acceleration: "Beschleunigung",
    price: "Preis",
    speed: "Geschwindigkeit",
    PS: "Leistung",
    Antriebsart: "Antriebsart",
    Getriebeart: "Getriebeart",
    Gears: "Gänge",
    mass: "Masse"
};

let a = 0;
let b = 0;

console.log(a);

function checkCheckBox() {
    const importKatgr = [];
    document.querySelectorAll('input:checked').forEach(checkbox => {
        importKatgr.push(checkbox.value);
    });
    console.log(importKatgr);
    if (importKatgr.length === 0 && a === 0) {
        alert('Du hast nichts ausgewählt stimmt das?');
        a = 1;
    } else if (importKatgr.length === 0 && a === 1) {
        a = 0;
    }
    localStorage.setItem('ImportKatgr', JSON.stringify(importKatgr));
    Fragen();
}

function Fragen() {
    window.open("Fragen.html");
}

window.addEventListener('DOMContentLoaded', function () {
    let container = document.getElementById('Auswahl-form');
    if (container) {
        Fragen_generieren();
    }
})
let gesEntscheidung = [];

function Fragen_generieren() {

    const importKatgr = JSON.parse(localStorage.getItem('ImportKatgr'));
    let container = document.getElementById('Auswahl-form');

    let Entscheidung = [];
    document.querySelectorAll('input:checked').forEach(checkbox => {
        Entscheidung.push(checkbox.value);
    })
    gesEntscheidung = gesEntscheidung.concat(Entscheidung)
    console.log(Entscheidung);
    document.querySelectorAll('input').forEach(input => {
        input.remove();
    });
    document.querySelectorAll('label').forEach(label => {
        label.remove();
    });
    if (b < importKatgr.length) {

        let Uberschrift = document.createElement('h1');
        // Uberschrift.textContent = importKatgr[b].charAt(0).toUpperCase() + importKatgr[b].slice(1);
        Uberschrift.textContent = KategorienNamen[importKatgr[b]] || importKatgr[b];
        container.appendChild(Uberschrift);

        for (let i = 0; i < Werte[importKatgr[b]].length; i++) {
            const label = document.createElement("label");
            const input = document.createElement("input");
            input.type = "checkbox";
            if (typeof Werte[importKatgr[b]][i] === "object") {
                input.value = `${Werte[importKatgr[b]][i].min} - ${Werte[importKatgr[b]][i].max}`;
                label.appendChild(input);
                label.appendChild(document.createTextNode(`${Werte[importKatgr[b]][i].min} - ${Werte[importKatgr[b]][i].max}`));
            } else {
                input.value = Werte[importKatgr[b]][i];
                label.appendChild(input);
                label.appendChild(document.createTextNode(" " + Werte[importKatgr[b]][i]));
            }

            container.appendChild(label);
        }

        b++;
    } else {
        fertiges_Auto();
    }
}

function passtZu(auto, wert) {
    // Bereichsangaben "min - max" prüfen
    if (wert.includes("-")) {
        const [minStr, maxStr] = wert.split("-").map(s => s.trim());
        const min = Number(minStr.replace(/[^\d]/g, ""));
        const max = Number(maxStr.replace(/[^\d]/g, ""));
        for (let key in auto) {
            if (typeof auto[key] === "number" && auto[key] >= min && auto[key] <= max) return true;
        }
        return false;
    }

    // exakte Übereinstimmung
    return Object.values(auto).some(v => String(v) === wert);
}

function fertiges_Auto() {
    let points = [];

    for (let i = 0; i < cars.length; i++) {
        let score = 0;
        for (let j = 0; j < gesEntscheidung.length; j++) {
            if (passtZu(cars[i], gesEntscheidung[j])) score++;
        }
        points.push({auto: cars[i].model, score});
    }
    console.log(points);
    let maxpoints = -1;
   let bestesauto;
    for (let i = 0; i < points.length; i++) {
        if (points[i].score > maxpoints) {
            maxpoints = points[i].score;
            bestesauto = points[i].auto;
        }
    }
Autoseiteaufbauen(maxpoints, bestesauto);
}

function Autoseiteaufbauen(höchsterscore, bestesauto) {
window.open("ToDolist.html");

}
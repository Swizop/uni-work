let body = document.getElementsByTagName("body")[0]; 

let div1 = document.createElement("div");

div1.setAttribute("id", "parinte");

let for1 = document.createElement("form");


for(var i = 4; i <=8; i++)
{
    l = document.createElement("input");
    l.setAttribute("type", "radio");
    
    l.id = i.toString();          //lipseste name
    l.value = i.toString();

    l.setAttribute("onclick", "funct(" + i + ");");

    if(i == 6 && localStorage.getItem("N") === null)
        l.setAttribute("checked", "");

    else if (i == localStorage.getItem("N"))
        l.setAttribute("checked", "");

    lbl = document.createElement("label");
    
    lbl.for = i.toString();
    lbl.innerHTML = i.toString();
    for1.appendChild(l);
    for1.appendChild(lbl);
    
}

div1.appendChild(for1);

div1.setAttribute("onclick", "setTimeout(penultima, 2000);");
body.appendChild(div1);

h = document.createElement("h1");
h1.innerHTML = "test";
body.appendChild(h1);


async function funct(i)
{
    localStorage.setItem('N', i);
    for1.style.display = "none";
}


async function penultima()
{
    for1.style.display = "none";
    div1.style.display = "flex";
    div1.style.flexDirection = "column";
    div1.removeAttribute("onclick");
    if(localStorage.getItem("N") !== null)
    {
        for(var j1 = 1; j1 <= localStorage.getItem("N"); j1++) {
            linie = document.createElement("div");
            linie.style.display = "flex";
            linie.style.flexDirection = "row";
            for(var j2 = 1; j2 <= localStorage.getItem("N"); j2++)
            {
                patr = document.createElement("div");
                patr.setAttribute("class", "celula");
                patr.id = "p" + j1 + j2;
                patr.style.width = patr.style.height = "2em";
                patr.setAttribute("ondblclick", "cc(" + j1 + ", " + j2 + ");")
                // patr.ondblclick = function() {
                //     node = document.createTextNode("(" + i + ", " + j  + ")");
                //     patr.appendChild(node);
                // };
                // node = document.createTextNode("(" + i + ", " + j  + ")");
                // patr.appendChild(node);
                linie.appendChild(patr);
            }
            div1.appendChild(linie);
        }
    }
}


function cc(i, j)
{
    // node = document.createTextNode("(" + i + ", " + j  + ")");
    // p.appendChild(node);
    q = document.getElementById("p" + i + j);
    i = i - 1; j = j - 1;
    node = document.createTextNode("(" + i + ", " + j  + ")"); 
    q.appendChild(node);
}
// setTimeout(async function penultima() { 
//     body.style.backgroundColor = "pink"; 
// }, 5000);
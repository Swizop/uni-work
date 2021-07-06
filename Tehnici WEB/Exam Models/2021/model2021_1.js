body = document.getElementsByTagName("body")[0];
body.style.display = "flex";

for(var i = 1; i <= 10; i++)
{
    div = document.createElement("div");
    div.setAttribute("class", "dreptunghi");
    body.appendChild(div);
}

arr = document.getElementsByClassName("dreptunghi");

color = "#" + Math.floor(Math.random()*16777215).toString(16);
hc = (Math.floor(Math.random() * 90) + 10);
h = hc.toString() + "px";
wc = (Math.floor(Math.random() * 90) + 100);
w = wc.toString() + "px";
for(i = 0; i < arr.length; i++)
{
    arr[i].style.backgroundColor = color;
    arr[i].style.borderStyle = "solid";
    arr[i].style.borderWidth = "1px";
    arr[i].style.height = h;
    arr[i].style.width = w;
    arr[i].style.marginRight = "10px";

    if(arr[i].tagName = "DIV")
    {
        // arr[i].onclick = function() {
        //     arr[i].style.height = (hc + 10).toString() + "px";
        // }
        arr[i].setAttribute("onclick", "fu(" + i + ");");
    }
}

// body.setAttribute("onclick", "gut(" + event + ", " + this + ");");  

body.onclick = function() {gut(event, this); };
function fu(x)
{
    document.getElementsByClassName("dreptunghi")[x].style.height = (hc + 10).toString() + "px";
}
let main = document.getElementsByClassName("main")[0];

newPost = document.createElement("button");
newPost.innerHTML = "Create a New Post";
main.appendChild(newPost);

postsContainer = document.createElement("div");
postsContainer.style.display = "flex";
postsContainer.style.flexDirection = "column";
postsContainer.style.overflow = "auto";
postsContainer.style.height = "653px";
postsContainer.style.width = "2000px";
main.appendChild(postsContainer);

showPosts();

function showPosts() {
    fetch('http://localhost:3000/posts')
  .then(
    function (response) {
      if (response.status !== 200) {
        console.log('Looks like there was a problem. Status Code: ' +
          response.status);
        return;
      }

      response.json().then(function (data) {
        console.log(data);
        renderPosts(data);
      });
    }
  )
  .catch(function (err) {
    console.log('Fetch Error :-S', err);
  });
}


function renderPosts(posts) {
    postsContainer.innerHTML = "";      //innerText

    /*
    let input1 = document.createElement("input");
    input1.setAttribute("type", "text");
    input1.setAttribute("id", "input1");
    input1.setAttribute("placeholder", "Name");
  
    let input2 = document.createElement("input");
    input2.setAttribute("type", "text");
    input2.setAttribute("id", "input2");
    input2.setAttribute("placeholder", "Link");
  
    body.appendChild(input1);
    body.appendChild(input2);
  
    let button = document.createElement("button");
    button.setAttribute("id", "but");
    button.innerText = "Add";
    button.setAttribute("onclick", "adddog();");
    body.append(button);
  
    let button1 = document.createElement("button");
    button1.className="upd";
    button1.setAttribute("disabled", "");
    button1.innerText = "Update";
    button1.setAttribute("onclick", "editdog(this.id);");
    body.append(button1);
  
    */

    for (let p in posts) {
      article = document.createElement('article');
      txt = document.createElement('p');
      edit = document.createElement('button');
      del = document.createElement('button');
  
      edit.innerText = "edit";
      edit.setAttribute("id", posts[p].id);
      edit.setAttribute("onclick", "placeinfo(this.id);");
  
      del.innerText = "delete";
      del.setAttribute("id", posts[p].id);
      del.setAttribute("onclick", "deldog(this.id);");
  
      node = document.createTextNode(posts[p].review);
      txt.appendChild(node);

      who = document.createElement('p');
      node = document.createTextNode(posts[p].name);
      who.appendChild(node);

      article.appendChild(who);
      article.appendChild(txt);
      article.appendChild(edit);
      article.appendChild(del);

      txt.setAttribute("style", "font-size:100px;");
      article.setAttribute("style", "display:flex; align-items:center;");
      postsContainer.appendChild(article);
      /*input = document.createElement("input");*/
    }
  }
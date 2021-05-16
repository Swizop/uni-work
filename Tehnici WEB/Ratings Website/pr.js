let main = document.getElementsByClassName("main")[0];
let modal = document.getElementsByClassName("modalPost")[0];
let close = document.getElementsByClassName("close")[0];
let done = document.getElementsByClassName("done")[0];

newPost = document.createElement("button");
newPost.innerHTML = "Create a New Post";
newPost.setAttribute("onclick", "openModal();");
done.setAttribute("onclick", "makeNewPost();")
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

    for (let p in posts.reverse()) {
      article = document.createElement('article');
      txt = document.createElement('p');
      edit = document.createElement('button');
      del = document.createElement('button');
  
      edit.innerText = "edit";
      edit.setAttribute("id", posts[p].id);
      edit.setAttribute("onclick", "openModalEdit(" + posts[p].id + ");");
  
      del.innerText = "delete";
      del.setAttribute("id", posts[p].id);
      del.setAttribute("onclick", "delart(" + posts[p].id + ");");
  
      node = document.createTextNode(posts[p].review);
      txt.appendChild(node);

      who = document.createElement('p');
      node = document.createTextNode(posts[p].name);
      who.appendChild(node);

      article.appendChild(who);
      article.appendChild(txt);
      article.appendChild(edit);
      article.appendChild(del);

      article.className = "art" + posts[p].id;
      who.className = "art" + posts[p].id;
      txt.className = "art" + posts[p].id;
      
      txt.setAttribute("style", "font-size:50px;");
      article.setAttribute("style", "display:flex; align-items:center;");
      postsContainer.appendChild(article);
      /*input = document.createElement("input");*/
    }
  }


 function openModal()
  {
    modal.style.display="block";
  }

  async function makeNewPost() {
    let np = {
        name: document.getElementById("yName").value,
        car: document.getElementById("models").value,
        rating: document.getElementById("stars").value,
        review: document.getElementsByClassName("textarea")[0].value
      };
      let response = await fetch('http://localhost:3000/posts', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json;charset=utf-8'
        },
        body: JSON.stringify(np)
      });
      let result = await response.json();
      console.log(result);

      modal.style.display="none";
  }

  close.onclick = function() {
      modal.style.display="none";
      let t = document.getElementById("modalTitle");
      t.innerText = "Create a New Post";
      done.setAttribute("onclick", "makeNewPost();");

      document.getElementById("yName").value = '';
      document.getElementById("models").value = '';
      document.getElementById("stars").value = '';
      document.getElementsByClassName("textarea")[0].value = '';
  }

  window.onclick = function(event) {
      if(event.target == modal)
      { modal.style.display="none";
      let t = document.getElementById("modalTitle");
      t.innerText = "Create a New Post";
      done.setAttribute("onclick", "makeNewPost();");

      document.getElementById("yName").value = '';
      document.getElementById("models").value = '';
      document.getElementById("stars").value = '';
      document.getElementsByClassName("textarea")[0].value = '';
        }
  }

  
  async function openModalEdit(i)
  {
    modal.style.display="block";
    let t = document.getElementById("modalTitle");
    t.innerText = "Edit Post";
    done.setAttribute("onclick", "placeinfo(" + i + ");")

    document.getElementById("yName").value = document.getElementsByClassName("art" + i)[1].innerHTML;
    //document.getElementById("models").value = result.car;
    //document.getElementById("stars").value = result.rating;
    document.getElementsByClassName("textarea")[0].value = document.getElementsByClassName("art" + i)[2].innerHTML;

  }

  async function placeinfo(i){
    console.log(i);

    let np = {
        name: document.getElementById("yName").value,
        car: document.getElementById("models").value,
        rating: document.getElementById("stars").value,
        review: document.getElementsByClassName("textarea")[0].value
      };
    let response = await fetch('http://localhost:3000/posts/' + i, {
        method: 'PUT',
        headers: {
        'Content-Type': 'application/json;charset=utf-8'
        },
        body: JSON.stringify(np)
    });

    let result = await response.json();
    console.log(result);

    modal.style.display = "none";
    document.getElementById("yName").value = '';
    document.getElementById("models").value = '';
    document.getElementById("stars").value = '';
    document.getElementsByClassName("textarea")[0].value = '';

    let t = document.getElementById("modalTitle");
    t.innerText = "Create a New Post";
    done.setAttribute("onclick", "makeNewPost();");
  }


  async function delart(i) {
    let response = await fetch('http://localhost:3000/posts/' + i, {
      method: 'DELETE'
    });
  
    let result = await response.json();
    console.log(result);
  }
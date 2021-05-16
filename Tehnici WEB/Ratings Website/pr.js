let main = document.getElementsByClassName("main")[0];
let modal = document.getElementsByClassName("modalPost")[0];
let close = document.getElementsByClassName("close")[0];
let done = document.getElementsByClassName("done")[0];

newPost = document.createElement("button");
newPost.innerHTML = "Create a New Post";
newPost.setAttribute("onclick", "openModal();");
newPost.className = "newPostButt links__link";
newPost.setAttribute("id", "newPostButt");

done.setAttribute("onclick", "makeNewPost();")
main.appendChild(newPost);

postsContainer = document.createElement("div");
postsContainer.className = "postsContainer";
postsContainer.style.display = "flex";
postsContainer.style.flexDirection = "column";
postsContainer.style.overflow = "auto";
postsContainer.style.height = "595px";
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

      who = document.createElement('div');
      node = document.createTextNode(posts[p].name);
      who.appendChild(node);

      what = document.createElement('div');
      node = document.createTextNode(posts[p].car);
      what.appendChild(node);
        
      nrOfStars = parseInt(posts[p].rating);
      var j = 1;
      starContainer = document.createElement('div');
      starContainer.className = posts[p].rating + " starContainer";
      
      
      while(j <= nrOfStars)
      {
        star = document.createElement('span');
        star.className = "fa fa-star checked";
        starContainer.appendChild(star);
        j+=1;
      }

      while(j <= 5)
      {
        star = document.createElement('span');
        star.className = "fa fa-star";
        starContainer.appendChild(star);
        j+=1;
      }
      
      firstLine = document.createElement('div');
      firstLine.className = "firstLine";
      firstLine.appendChild(who);
      firstLine.appendChild(what);

      lastLine = document.createElement('div');
      lastLine.className = "lastLine";
      lastLine.appendChild(edit);
      lastLine.appendChild(del);
      
      article.appendChild(firstLine);
      article.appendChild(starContainer);
      article.appendChild(txt);
      article.appendChild(lastLine);

      article.className = "art" + posts[p].id + " independentReview";
      who.className = "art" + posts[p].id + " who";
      txt.className = "art" + posts[p].id + " txt";
      what.className = "art" + posts[p].id + " what";
      starContainer.className += " art" + posts[p].id;
      
      
      article.setAttribute("style", "display:flex;");
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
    document.getElementById("models").value = document.getElementsByClassName("art" + i)[2].innerHTML;
    document.getElementById("stars").value = document.getElementsByClassName("art" + i)[3].className[0];
    document.getElementsByClassName("textarea")[0].value = document.getElementsByClassName("art" + i)[4].innerHTML;

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



//move to different page

b1 = document.getElementById("et7-link");
b1.setAttribute("onclick", "move(\"ET7\");");
b2 = document.getElementById("ec6-link");
b2.setAttribute("onclick", "move(\"EC6\");");
b3 = document.getElementById("es8-link");
b3.setAttribute("onclick", "move(\"ES8\");");

mainHTML = main.innerHTML;
head = document.getElementsByClassName("uph1")[0];
head.style.cursor = "pointer";
head.setAttribute("onclick", "setMain();");

function setMain()
{
    location.reload();
}


function move(i)
{
    main.innerHTML = "";


    w = document.createElement('p');
    w.innerText = "The " + i + " Model";
    w.style.fontSize="2em";
    w.style.fontWeight="bolder";
    w.style.position="relative";
    w.style.left="45%";
    w.style.color="#996688";
    main.appendChild(w);
    
    modelContainer = document.createElement('div');
    modelContainer.className = "modelContainer";
    main.appendChild(modelContainer);

    userRatingContainer = document.createElement('div');
    userRatingContainer.className = "userRatingContainer";
    modelContainer.appendChild(userRatingContainer);

    userRating = document.createElement('p');
    userRating.innerText = "Overall Rating";
    userRating.className = "overallRating";
    userRatingContainer.appendChild(userRating);

    

    img = document.createElement('img');
    if(i == "ET7")
        img.src = "https://scontent.fotp3-2.fna.fbcdn.net/v/t1.6435-9/137625796_1880152195467499_6542052258382626647_n.jpg?_nc_cat=106&ccb=1-3&_nc_sid=973b4a&_nc_ohc=45oJt4ISXCkAX_rwdcq&_nc_ht=scontent.fotp3-2.fna&oh=e0fa46619b647ca07f58530d279be3af&oe=60C5F460";
        else
            if(i == "EC6")
                img.src = "https://cdn.motor1.com/images/mgl/9Llvg/s1/nio-ec6-white-exterior.jpg";
            else
                img.src = "https://st4.depositphotos.com/21607914/23505/i/1600/depositphotos_235050660-stock-photo-nio-es8-nextev-car-display.jpg";

    img.style.maxWidth = "50%";
    img.style.height="auto";
    img.style.position="relative"; 
    img.style.right="0";
    modelContainer.appendChild(img);
}
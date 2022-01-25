import { Injectable } from '@angular/core';
import { Router } from '@angular/router';     //importam pentru a putea da redirect

@Injectable({
  providedIn: 'root'
})
export class AuthService {

  constructor(private router: Router) { }     // injectam router-ul importat in serviciu


  login() {
    // .. am fi facut un request in urma caruia am fi primit un token. il punem in localStorage ca sa fie salvat in browser 
            //ramane acolo permanent, se poate folosi pana expira token-ul
    
    localStorage.setItem('token', 'a value from an api');
    this.router.navigate(['/dashboard']);           //functia de redirect
  }

  logout() {
    localStorage.clear();   //sterge totul din localStorage
    //localStorage.removeItem('token');

    //in practica, ar trebui sa faci si un request catre api sa-ti stearga token-ul,
          // ca sa nu ti-l fi interceptat cineva cat erai logged in
    this.router.navigate(['/login']);
  }


  isAuthenticated(): boolean {
    return !!localStorage.getItem('token');   // 2 negari ca sa facem conversia de bool
  }
}

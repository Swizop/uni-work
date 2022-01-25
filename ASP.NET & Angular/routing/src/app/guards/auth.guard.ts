import { Injectable } from '@angular/core';
import { ActivatedRouteSnapshot, CanActivate, Router, RouterStateSnapshot, UrlTree } from '@angular/router';
import { Observable } from 'rxjs';
import { AuthService } from '../services/auth.service';

@Injectable({
  providedIn: 'root'
})
export class AuthGuard implements CanActivate {

  constructor(
    private authService: AuthService,      // injectam AuthService ca sa avem acces la functia isLoggedIn(), pe care
                                  //o folosim in canActivate -> sa decidem daca poate sa intre pe o pagina sau nu
    
    private router: Router        //injectam router ca sa avem acces la rute                            
  ) {}
  canActivate(
    route: ActivatedRouteSnapshot,
    state: RouterStateSnapshot): Observable<boolean | UrlTree> | Promise<boolean | UrlTree> | boolean | UrlTree {  

      //scopul e sa returnam  true sau false daca vrem sa lasam utilizatorul sa acceseze pagina asta

    if(this.authService.isAuthenticated()) {  
      return true;
    }

    this.router.navigate(['/login']);   //daca nu e autentificat, il trimitem inapoi la pagina de login
    return false;
  }
  
}

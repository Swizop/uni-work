import { Injectable } from '@angular/core';

@Injectable({
  providedIn: 'root'
})
export class DogService {

  constructor() { }

  getDogs() {
    console.log('Hello, dog service');
  }

  //callback function - promise. metoda va intoarce un promise care se va rezolva intr-un string
  workWithPromise(time: number): Promise<string> {            //time -> parametru de timp number. promise<string> tipul de returnare     
    const p = new Promise<string>(      //functie anonima, trimisa ca parametru in constructor
      (resolve, reject) => {          //resolve -> s a intors callbackul, reject -> eroare
      setTimeout(() => {
        console.log('finished waiting');
        if(time % 2 === 0) {
          resolve('numar par');
        }
        else {
          reject('numar impar');
        }
      }, time);         //dupa timpul time, se executa functia anonima de mai sus 
    });

    return p;
  }
}

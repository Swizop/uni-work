import { Component, OnInit } from '@angular/core';
import { ActivatedRoute } from '@angular/router';   //pentru a putea lua valoarea lui id din ruta (parametru)


@Component({
  selector: 'app-details',
  templateUrl: './details.component.html',
  styleUrls: ['./details.component.scss']
})
export class DetailsComponent implements OnInit {


  id: string = '';

  constructor(private route: ActivatedRoute) { }    //route cu clasa importata la inceput

  ngOnInit(): void {
    this.route.params.subscribe((params) => this.id = params['idFromUrl'])     //idFromUrl e luat exact cum e scris in dashboard.routes.ts
                          //subscriem o functie care se executa cand se termina de parsat url-ul

  }

}

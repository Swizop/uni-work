import { Component, OnInit } from '@angular/core';
import { DogService } from '../dog.service';

@Component({
  selector: 'app-dogs',
  templateUrl: './dogs.component.html',
  styleUrls: ['./dogs.component.scss']
})
export class DogsComponent implements OnInit {

  constructor(private dogService: DogService) { }

  async work()
  {
    try {
      const a = await this.dogService.workWithPromise(1000);      //daca nu am folosi await, a ar fi de tipul Promise<string>. cu await, a va fi de tipul string
                                                              //va astepta executarea inainte de orice altceva
      const b = await this.dogService.workWithPromise(1001).catch((e) =>
                                {console.warn(e); return 'some error';});
      console.log(a, b);
    } catch(e) {
      console.warn(e);
    }
  }


  ngOnInit(): void {
    this.dogService.getDogs();

    this.work();

  }

}

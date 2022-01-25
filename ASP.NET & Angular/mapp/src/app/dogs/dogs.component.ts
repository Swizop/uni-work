import { Component, OnInit } from '@angular/core';
import { DogResponse, DogService } from '../dog.service';

@Component({
  selector: 'app-dogs',
  templateUrl: './dogs.component.html',
  styleUrls: ['./dogs.component.scss']
})
export class DogsComponent implements OnInit {

  dogs: DogResponse[] = [];
  constructor(private dogService: DogService) { }



  ngOnInit(): void {
    this.dogService.getDogs().then((response => {
      this.dogs = response;
    }));


  }

}

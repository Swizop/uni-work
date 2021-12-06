import { Component, OnInit, Input } from '@angular/core';
import { DogResponse } from '../dog.service';

@Component({
  selector: 'app-individual-dog',
  templateUrl: './individual-dog.component.html',
  styleUrls: ['./individual-dog.component.scss']
})
export class IndividualDogComponent implements OnInit {

  @Input() dog?: DogResponse;
  
  constructor() { }

  ngOnInit(): void {
  }

}

import { Component, OnInit } from '@angular/core';

@Component({
  selector: 'app-demo',
  templateUrl: './demo.component.html',
  styleUrls: ['./demo.component.scss']
})
export class DemoComponent implements OnInit {

  foo: number = 0;
  values: number[] =[];

  addIsVisible: boolean = true;

  constructor() { }

  ngOnInit(): void {
    this.values = [1, 5, 10, 25];
  }

    toggleAdd() {
      this.addIsVisible = !this.addIsVisible;
    }

    add (value: number = 1) {
      this.foo += value;
    }
    remove(value: number = 1)
    {
      this.foo -= value;
    }
}

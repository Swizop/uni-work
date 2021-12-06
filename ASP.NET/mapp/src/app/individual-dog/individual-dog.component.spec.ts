import { ComponentFixture, TestBed } from '@angular/core/testing';

import { IndividualDogComponent } from './individual-dog.component';

describe('IndividualDogComponent', () => {
  let component: IndividualDogComponent;
  let fixture: ComponentFixture<IndividualDogComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ IndividualDogComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(IndividualDogComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});

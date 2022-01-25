import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { DemoComponent } from './demo/demo.component';
import { Demo2Component } from './demo2/demo2.component';
import { DogsComponent } from './dogs/dogs.component';

const routes: Routes = [
  { path: "demo1", component: DemoComponent},
  { path: "demo2", component: Demo2Component},
  
  { path: "dogs", component: DogsComponent}
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }

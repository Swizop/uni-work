import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { DemoComponent } from './demo/demo.component';
import { Demo2Component } from './demo2/demo2.component';

@NgModule({
  declarations: [
    AppComponent,
    DemoComponent,
    Demo2Component
  ],
  imports: [
    BrowserModule,
    AppRoutingModule
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }

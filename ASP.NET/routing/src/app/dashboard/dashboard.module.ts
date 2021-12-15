import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { routes } from './dashboard.routes';
import { AdminComponent } from './admin/admin.component';
import { DetailsComponent } from './details/details.component';
import { LayoutComponent } from './layout/layout.component';
import { RouterModule } from '@angular/router';



@NgModule({
  declarations: [
    AdminComponent,
    DetailsComponent,
    LayoutComponent
  ],
  imports: [
    CommonModule,
    RouterModule.forChild(routes)
  ]
})
export class DashboardModule { }

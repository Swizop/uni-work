import { Routes } from '@angular/router';
import { AdminComponent } from './admin/admin.component';
import { DetailsComponent } from './details/details.component';
import { LayoutComponent } from './layout/layout.component';

export const routes: Routes = [
    {
        path: 'dashboard',
        component: LayoutComponent,
        children: [
            { path: '', redirectTo: 'admin', pathMatch: 'full'},
            {
                path: 'admin',
                component: AdminComponent
            },
            {
                path: 'details',
                component: DetailsComponent
            }
        ]
    }
];

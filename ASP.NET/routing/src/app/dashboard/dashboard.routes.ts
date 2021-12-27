import { Routes } from '@angular/router';
import { AuthGuard } from '../guards/auth.guard';
import { AdminComponent } from './admin/admin.component';
import { DetailsComponent } from './details/details.component';
import { LayoutComponent } from './layout/layout.component';

export const routes: Routes = [
    {
        path: 'dashboard',
        component: LayoutComponent,
        canActivate: [AuthGuard], //adaugam aceasta linie => va fi nevoie de login si pt copiii lui dashboard
        children: [
            { path: '', redirectTo: 'admin', pathMatch: 'full'},
            {
                path: 'admin',
                component: AdminComponent
            },
            {
                path: 'details',
                component: DetailsComponent
            },
            {
                path: 'details/:idFromUrl',
                component: DetailsComponent
            }
        ]
    }
];

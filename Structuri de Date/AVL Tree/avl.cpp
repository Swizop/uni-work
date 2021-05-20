#include <iostream>
#include <algorithm>

using namespace std;


struct Node {
    int val, h;
    Node *l, *r;
};


Node* AVL;

int height(Node* t)
{
    if(t == NULL)
        return 0;
    else
        return t->h;
}


Node* RLrotation(Node* t)
{
    Node *x, *y, *z;            //rotation is always done on 3 nodes
    x = t;
    y = x->r;
    z = y->l;

    x->r = z->l;
    y->l = z->r;
    z->l = x;
    z->r = y;
    return z;
}

Node* RRrotation(Node* t)
{
    Node *x, *y;
    x = t;
    y = x->r;

    x->r = y->l;
    y->l = x;
    return y;
}


Node* insert(Node* curr, int x)
{
    if(curr == NULL)
    {
        curr = new Node;
        curr->r = curr->l = NULL;
        curr->val = x;
        curr->h = 1;
        return curr;
    }
    else
    {
        if(x > curr->val)
        {
            curr->r = insert(curr->r, x);
            curr->h = max(curr->h, curr->r->h + 1);
        }
        else
            if(x < curr->val)
            {
                curr->l = insert(curr->l, x);
                curr->h = max(curr->h, curr->l->h + 1);
            }
            else
                return curr;            //avl should only have distinct elements
        

        int index = height(curr->l) - height(curr->r);
        if(index < -1)
        {
            if(x < curr->r->val)
                curr = RLrotation(curr);
            else
                curr = RRrotation(curr);
        }

        return curr;
    }
}


void preord(Node* curr)
{
    if(curr != NULL)
    {
        cout << curr->val << " ";
        preord(curr->l);
        preord(curr->r);
    }
}


void inord(Node* curr)
{
    if(curr != NULL)
    {
        preord(curr->l);
        cout << curr->val << " ";
        preord(curr->r);
    }
}


void showOpt()
{
    cout << "1. Create an entirely new AVL\n";
    cout << "2. Print preorder traversal of AVL\n";
    cout << "3. Print the values in sorted order\n";
    cout << "4. Insert a single value into the AVL\n";
}


int main()
{
    int opt, n, x;

    while(true)
    {
        cout << "What do you want to do? Press 0 for all possible options.\n";
        cin >> opt;
        cout << '\n';

        switch (opt)
        {
            case 0:
                showOpt();
                break;
            case 1:
                AVL = NULL;
                cout << "How many values do you want to insert in the AVL?\n";
                cin >> n;
                cout << '\n';

                for(int i = 1; i <= n; i++)
                {
                    cout << "Insert value.\n";
                    cin >> x;
                    AVL = insert(AVL, x);
                }
                break;

            case 2:
                preord(AVL);
                cout << "\n";
                break;
            
            case 3:
                inord(AVL);
                cout << "\n";
                break;

            case 4:
                cout << "Insert value.\n";
                cin >> x;
                AVL = insert(AVL, x);
                break;
            default:
                return 0;
                break;
        }
    }
    return 0;
}
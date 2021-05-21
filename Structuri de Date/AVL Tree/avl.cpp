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
    x->h = max(height(x->r), height(x->l)) + 1;

    y->l = z->r;
    y->h = max(height(y->r), height(y->l)) + 1;

    z->l = x;
    z->r = y;
    z->h = max(height(z->r), height(z->l)) + 1;
    return z;
}

Node* RRrotation(Node* t)
{
    Node *x, *y;
    x = t;
    y = x->r;

    x->r = y->l;
    x->h = max(height(x->r), height(x->l)) + 1;

    y->l = x;
    y->h = max(height(y->l), height(y->r)) + 1;
    return y;
}

Node* LRrotation(Node* t)
{
    Node *x, *y, *z;            //rotation is always done on 3 nodes
    x = t;
    y = x->l;
    z = y->r;

    x->l = z->r;
    x->h = max(height(x->r), height(x->l)) + 1;

    y->r = z->l;
    y->h = max(height(y->r), height(y->l)) + 1;

    z->r = x;
    z->l = y;
    z->h = max(height(z->r), height(z->l)) + 1;
    return z;
}

Node* LLrotation(Node* t)
{
    Node *x, *y;
    x = t;
    y = x->l;

    x->l = y->r;
    x->h = max(height(x->r), height(x->l)) + 1;

    y->r = x;
    y->h = max(height(y->l), height(y->r)) + 1;
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
            curr->h = max(height(curr->l), height(curr->r)) + 1;
        }
        else
            if(x < curr->val)
            {
                curr->l = insert(curr->l, x);
                curr->h = max(height(curr->l), height(curr->r)) + 1;
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
        if(index > 1)
        {
            if(x < curr->l->val)
                curr = LLrotation(curr);
            else
                curr = LRrotation(curr);
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
        inord(curr->l);
        cout << curr->val << " ";
        inord(curr->r);
    }
}


Node* srch(Node* curr, int v)
{
    if(curr == NULL || curr->val == v)
        return curr;
    if(curr->val < v)
        return srch(curr->r, v);
    return srch(curr->l, v);
}


Node* succ(Node* root, Node* t)
{
    Node* i;
    if(t->r != NULL)
    {
        i = t->r;
        while(i->l != NULL)
            i = i->l;
        return i;
    }

    Node* res = t;
    i = root;
    while(i != NULL && i->val != t->val)
        if(i->val > t->val)
        {
            res = i;
            i = i->l;
        }
        else
            i = i->r;
    
    return res;
}


Node* pred(Node* root, Node* t)
{
    Node* i;
    if(t->l != NULL)
    {
        i = t->l;
        while(i->r != NULL)
            i = i->r;
        return i;
    }

    Node* res = t;
    i = root;
    while(i != NULL && i->val != t->val)
        if(i->val > t->val)
            i = i->l;
        else
        {
            res = i;
            i = i->r;
        }
    return res;
}


Node* del(Node* curr, int x)
{
    if(curr->l == NULL && curr->r == NULL)
    {
        delete curr;
        return NULL;
    }

    if(curr->val < x)
    {
        curr->r = del(curr->r, x);
        // return curr;
    }
    else
        if(curr->val > x)
        {
            curr->l = del(curr->l, x);
            // return curr;
        }
        else
        {
            if(curr->l != NULL)
            {
                Node* p = pred(AVL, curr);
                curr->val = p->val;
                curr->l = del(curr->l, p->val);
            }
            else
            {
                Node* s = succ(AVL, curr);
                curr->val = s->val;
                curr->r = del(curr->r, s->val);
            }
        }

    
    curr->h = max(height(curr->r), height(curr->l)) + 1;

    int index = height(curr->l) - height(curr->r);
    if(index > 1 && height(curr->l->l) - height(curr->l->r) >= 0)
        curr = LLrotation(curr);
    else
        if(index > 1 && height(curr->l->l) - height(curr->l->r) < 0)
            curr = LRrotation(curr);
        else
            if(index < -1 && height(curr->r->l) - height(curr->r->r) <= 0)
                curr = RRrotation(curr);
            else
                if(index < -1 && height(curr->r->l) - height(curr->r->r) > 0)
                    curr = RLrotation(curr);
                        
    return curr;
}
void showOpt()
{
    cout << "1. Create an entirely new AVL\n";
    cout << "2. Print preorder traversal of AVL\n";
    cout << "3. Print the values in sorted order\n";
    cout << "4. Insert a single value into the AVL\n";
    cout << "5. Search for a specific value\n";
    cout << "6. Search for successor of a specific value\n";
    cout << "7. Search for predecessor of a specific value\n";
    cout << "8. Delete node by value\n";
    cout << "9. Exit program.\n";
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

            case 5:
                cout << "Value to search for:\n";
                cin >> x;
                if(srch(AVL, x) != NULL)
                    cout << x << " is in the AVL.\n";
                else
                    cout << x << " is not in the AVL.\n";
                break;

            case 6:
            {
                cout << "Value you want the successor of:\n";
                cin >> x;
                Node* w = srch(AVL, x);
                Node* r = succ(AVL, w);
                if(r == w)
                    cout << "The node has no successor.\n";
                else
                    cout << r->val << '\n';
                break;
            }

            case 7:
            {
                cout << "Value you want the predecessor of:\n";
                cin >> x;
                Node* w = srch(AVL, x);
                Node* r = pred(AVL, w);
                if(r == w)
                    cout << "The node has no predecessor.\n";
                else
                    cout << r->val << '\n';
                break;
            }

            case 8:
            {
                cout << "Value you want to delete:\n";
                cin >> x;
                if(srch(AVL, x) == NULL)
                {
                    cout << x << " is not in the AVL.\n";
                    break;
                }

                AVL = del(AVL, x);
                break;
            }
            
            case 9:
                return 0;
                break;

            default:
                cout << "Wrong index!\n";
                break;
        }
    }
    return 0;
}

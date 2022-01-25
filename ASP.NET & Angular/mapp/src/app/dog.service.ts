import { Injectable } from '@angular/core';

export interface DogImage {
  id: string;
  width: number;
  height: number
  url: string;
};

export interface DogWithoutImage {
  weight: {
    imperial: string;
    metric: string;
  };
  height: {
    imperial: string;
    metric: string;
  };
  id: number;
  name: string;
  bred_for: string;
  breed_group: string;
  life_span: string;
  temperament: string;
  origin: string;
  reference_image_id: string;
}

export interface DogResponse extends DogWithoutImage {
  image: DogImage;
}


@Injectable({
  providedIn: 'root'
})
export class DogService {
  private apiKey = 'f66e847d-80f5-4013-a50f-ce8cfc0e446f';
  private apiUrl = 'https://api.thedogapi.com/v1';      //chiar daca url ul pe site e https://api.thedogapi.com/v1/breeds, noi il scriem fara breeds
  private limit = 20;

  constructor() { }

  getDogs(): Promise<DogResponse[]> {
    return fetch(`${this.apiUrl}/breeds?limit=${this.limit}`, {
      headers: {
        'x-api-key': this.apiKey
      }
    }).then(response => response.json());
  }

  async search(query: string): Promise<DogResponse[]> {
    const result: DogWithoutImage[] = await fetch(`${this.apiUrl}/breeds/search?q=${query}`, {
      headers: {
        'x-api-key': this.apiKey
      }
    }).then(response => response.json());

    const promises = result.map(
      (breed: DogWithoutImage): Promise<DogResponse> => {
        return (
          this.loadImage(breed.reference_image_id)
            .then((image) => ({
              ...breed,
              image
            })).catch(() => ({
              ...breed,
              image: {
                id: breed.reference_image_id,
                height: 0,
                width: 0,
                url: ''
              }
            }))
        )
      });

    return Promise.all(promises);
  }

  loadImage(imageId: string): Promise<DogImage> {
    return fetch(`${this.apiUrl}/images/${imageId}`, {
      headers: {
        'x-api-key': this.apiKey
      }
    }).then(response => response.json()).then((data): DogImage => ({
      height: data.height,
      id: data.id,
      url: data.url,
      width: data.width,
    }));
  }
}

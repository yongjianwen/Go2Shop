import { HttpResponse } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { AbstractControl, FormControl } from '@angular/forms';
import { ActivatedRoute, Router } from '@angular/router';
import { LoginUser } from 'app/auth/authentication.model';
import { AuthenticationService } from 'app/auth/authentication.service';
import { IShoppingCartProduct, ShoppingCartProduct } from 'app/pages/cart/cart.model';
import { ShoppingCartService } from 'app/pages/cart/shopping-cart.service';
import { IProduct, IProductImage, IProductReview } from '../../product.model';

@Component({
  selector: 'go2shop-product-information',
  templateUrl: './product-information.component.html',
  styleUrls: ['./product-information.component.css']
})
export class ProductInformationComponent implements OnInit {

  constructor(
        private route: ActivatedRoute,
        private authService: AuthenticationService,
        private router: Router,
        private cartService: ShoppingCartService
  ) {}

    public product: IProduct;
    public quantity: AbstractControl = new FormControl(null);
    public maxRatingSize = 5;
    public rating = 0;

    ngOnInit(): void {
      this.route.data.subscribe(
        data => {
          this.product = data.product;
          if(this.product && this.product.productImages) {
            this.product.productImages.forEach((img: IProductImage) => img.url = 'assets/images/products/' + img.url);
          }
          console.log(this.product);
          this.calculateRatings();
        }
      );
      this.quantity.setValue(1);
    }

    deductQuantity(): void {
      if(this.quantity.value > 1) {
        this.quantity.setValue(this.quantity.value - 1);
      }
    }

    addQuantity(): void {
      if(this.product.stock > this.quantity.value) {
        this.quantity.setValue(this.quantity.value + 1);
      }
    }

    addToCart(): void {
      if(this.verifyLogin()) {
        this.cartService.createShoppingCartProduct(this.buildShoppingCartProduct()).subscribe(
          (res: HttpResponse<IShoppingCartProduct>) => {
            if(res && res.body) {
              this.cartService.updateCartSize();
            }
          }
        );
      } 
    }

    buyNow(): void {
      if(this.verifyLogin()) {
        // this.cartService.createShoppingCartProduct(this.buildUserToProduct()).subscribe(
        //   (res: HttpResponse<IShoppingCartProduct>) => console.log(res.body)
        // );
      } 
    }

    private verifyLogin(): boolean {
      if(!this.authService.isLoggedIn()) {
        this.router.navigate(['/user', 'login']);
        return false;
      }
      return true;
    }

    private buildShoppingCartProduct(): IShoppingCartProduct {
      const user: LoginUser = this.authService.getCurrentUser();
      return new ShoppingCartProduct(null, user.cartId, this.product.id, this.quantity.value);
    }

    private calculateRatings(): void {
      if(this.product.productReviews && this.product.productReviews.length > 0) {
        let count = 0;
        this.product.productReviews.forEach(
          (review: IProductReview) => count += review.rating
        );
        this.rating = count / this.product.productReviews.length;
      } 
    }
}
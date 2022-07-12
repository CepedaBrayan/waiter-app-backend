import { IsNumber, IsString } from 'class-validator';

export class CreateInvoiceDto {
  @IsNumber()
  auth_code: number;

  @IsString()
  client_name: string;

  @IsNumber()
  waiter_id: number;

  @IsNumber()
  tabl_id: number;

  @IsString()
  products_description: string;

  @IsNumber()
  cost: number;
}

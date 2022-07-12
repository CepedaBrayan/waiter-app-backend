import { IsNumber } from 'class-validator';

export class PrintInvoiceDto {
  @IsNumber()
  auth_code: number;

  @IsNumber()
  tabl_id: number;
}

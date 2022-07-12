import { Controller, Post, Body } from '@nestjs/common';
import { InvoicesService } from './invoices.service';
import { CreateInvoiceDto } from './dto/create-invoice.dto';
import { PrintInvoiceDto } from './dto/print-invoice.dto';

@Controller('invoices')
export class InvoicesController {
  constructor(private readonly invoicesService: InvoicesService) {}

  @Post('create')
  create(@Body() createInvoiceDto: CreateInvoiceDto) {
    return this.invoicesService.create(createInvoiceDto);
  }

  @Post('print-per-table')
  printPerTable(@Body() printInvoiceDto: PrintInvoiceDto) {
    return this.invoicesService.printPerTable(printInvoiceDto);
  }
}

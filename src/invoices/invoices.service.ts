import {
  Injectable,
  NotFoundException,
  UnauthorizedException,
} from '@nestjs/common';
import { PrismaClient, Prisma } from '@prisma/client';
import { CreateInvoiceDto } from './dto/create-invoice.dto';
import { PrintInvoiceDto } from './dto/print-invoice.dto';

const prisma = new PrismaClient();

@Injectable()
export class InvoicesService {
  async create(createInvoiceDto: CreateInvoiceDto) {
    const auth = await prisma.auth.findMany({
      where: {
        auth_code: createInvoiceDto.auth_code,
      },
    });
    if (!auth[0]) throw new UnauthorizedException('Invalid auth code');

    const client = await prisma.client.findMany({
      where: {
        name: createInvoiceDto.client_name,
      },
    });
    if (!client[0]) throw new NotFoundException('Client not found');

    const waiter = await prisma.waiter.findUnique({
      where: {
        id: createInvoiceDto.waiter_id,
      },
    });
    if (!waiter) throw new NotFoundException('Waiter invalid');

    const tabl = await prisma.tabl.findUnique({
      where: {
        id: createInvoiceDto.tabl_id,
      },
    });
    if (!tabl) throw new NotFoundException('Table not found');

    if (createInvoiceDto.cost < 0) throw new NotFoundException('Cost invalid');
    const plustip = (createInvoiceDto.cost / 100) * auth[0].tip_percentage;
    await prisma.invoice.create({
      data: {
        client_id: client[0].id,
        waiter_id: waiter.id,
        tabl_id: tabl.id,
        products_description: createInvoiceDto.products_description,
        tip: auth[0].tip_percentage,
        total_without_tip: createInvoiceDto.cost,
        total_with_tip: createInvoiceDto.cost + plustip,
        payed: false,
      },
    });

    return { message: 'Ok' };
  }

  async printPerTable(printInvoiceDto: PrintInvoiceDto) {
    const auth = await prisma.auth.findMany({
      where: {
        auth_code: printInvoiceDto.auth_code,
      },
    });
    if (!auth[0]) throw new UnauthorizedException('Invalid auth code');

    const tabl = await prisma.tabl.findUnique({
      where: {
        id: printInvoiceDto.tabl_id,
      },
    });
    if (!tabl) throw new NotFoundException('Table not found');

    const invoices = await prisma.invoice.findMany({
      where: {
        tabl_id: printInvoiceDto.tabl_id,
      },
      include: {
        client: {
          select: {
            name: true,
          },
        },
        waiter: {
          select: {
            name: true,
          },
        },
        tabl: {
          select: {
            location: true,
          },
        },
      },
    });
    if (!invoices[0])
      throw new NotFoundException('Invoices not found for this table');
    return { tabl: printInvoiceDto.tabl_id, invoices: invoices };
  }
}

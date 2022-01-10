//+------------------------------------------------------------------+
//|                                         Breakout_V0_20220107.mq4 |
//|                        Copyright 2022, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

input double Lots = 0.1;
input int    MovingPeriod  =3;
input int    MovingShift   =2;
input int    Test = 10;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+

int OnInit()
  {
//---
   string datetime_str = TimeToString(TimeCurrent(), TIME_SECONDS);
   
   printf("This is Test on time " + datetime_str);
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {
  
   double ma;
   datetime current;
   bool check, check_2;
   int ticket;
//---
   ma=iMA(NULL,0,MovingPeriod,MovingShift,MODE_SMA,PRICE_CLOSE,1);
   
   
   current = iTime(NULL, PERIOD_CURRENT, 0);
   
   //printf( TimeToString(current) );
   
   check = ( Close[0] > ma ) && ( Close[1] <= ma );
   
   //printf( "Buy Condition " + IntegerToString(check) );
   //printf( "MA Value " + DoubleToString(ma) );
   //printf( "Open Value " + DoubleToString(Open[0]) );
   //printf( "Close Value " + DoubleToString(Close[1]) );
   
   if ( check == True )

      {
      
         printf( "In Check Condition");
         printf( "MA Value " + DoubleToString(ma) );
         printf( "Open Value " + DoubleToString(Open[0]) );
         printf( "Close Value " + DoubleToString(Close[1]) );
               
         int buys=0,sells=0;
         
         //---
         for(int i=0;i<OrdersTotal();i++)
           {
            if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false) break;
            if(OrderSymbol()==Symbol() && OrderMagicNumber()==16384)
              {
               if(OrderType()==OP_BUY)  buys++;
               if(OrderType()==OP_SELL) sells++;
              }
           }
           
         printf("Order Buy = " + IntegerToString(buys) + " Order Sell = " + IntegerToString(sells) );
         
         if ( buys == 0 && sells == 0)
         
         {
         
            ticket = OrderSend(Symbol(),OP_BUY,0.01, Ask,3,0,0,"My Test Buy order",16384,0,clrGreen);
   
            if(ticket<0)
               {
                  Print("OrderSend failed with error #",GetLastError());
               }
            else
                  Print("OrderSend placed successfully");
                  
         }
         
         if ( buys == 0 && sells == 1 )
         
         {
         
            for(int i=0;i<OrdersTotal();i++)
            
              {
              
               if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false) break;
               if(OrderMagicNumber()!= 16384 || OrderSymbol()!=Symbol()) continue;
               //--- check order type 
               if(OrderType()== OP_SELL)
               
                  {
                  
                     if( OrderClose(OrderTicket(),OrderLots(),Ask,3,White) == false)
               
                     Print("OrderClose error ",GetLastError());
                     
                  }
               
              }
              
         }

      }
      
   check_2 = ( Close[0] < ma ) && ( Close[1] >= ma );
   
   //printf( "Sell Condition " + IntegerToString(check_2) );
   
   if ( check_2 == True )
   
      {
         
         printf( "In Check 2 Condition");
         printf( "MA Value " + DoubleToString(ma) );
         printf( "Open Value " + DoubleToString(Open[0]) );
         printf( "Close Value " + DoubleToString(Close[1]) );
         
         int buys=0,sells=0;
         
         //---
         for(int i=0;i<OrdersTotal();i++)
           {
            if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false) break;
            if(OrderSymbol()==Symbol() && OrderMagicNumber()==16384)
              {
               if(OrderType()==OP_BUY)  buys++;
               if(OrderType()==OP_SELL) sells++;
              }
           }
           
         printf("Order Buy = " + IntegerToString(buys) + " Order Sell = " + IntegerToString(sells) );
         
         if ( sells == 0 && buys == 0)
         
         {
         
            ticket = OrderSend(Symbol(),OP_SELL,0.01,Bid,3,0,0,"My Test Sell order",16384,0,clrRed);
            
            if(ticket<0)
               {
                  Print("OrderSend failed with error #",GetLastError());
               }
            else
                  Print("OrderSend placed successfully");
                  
         }
         
         if ( buys == 1 && sells == 0 )
         
         {
         
            for(int i=0;i<OrdersTotal();i++)
            
              {
              
               if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false) break;
               if(OrderMagicNumber()!= 16384 || OrderSymbol()!=Symbol()) continue;
               //--- check order type 
               if(OrderType()== OP_BUY)
               
                  {
                  
                     if( OrderClose(OrderTicket(),OrderLots(),Bid,3,White) == false)
               
                     Print("OrderClose error ",GetLastError());
                     
                  }
               
              }
              
         }
            
      }
      
 
   }  
//+------------------------------------------------------------------+

//void CheckForClose()
//  {
//   double ma;
//   
////---
//   for(int i=0;i<OrdersTotal();i++)
//     {
//      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false) break;
//      if(OrderMagicNumber()!=MAGICMA || OrderSymbol()!=Symbol()) continue;
//      //--- check order type 
//      if(OrderType()==OP_BUY)
//        {
//         if(Open[1]>ma && Close[1]<ma)
//           {
//            if(!OrderClose(OrderTicket(),OrderLots(),Bid,3,White))
//               Print("OrderClose error ",GetLastError());
//           }
//         break;
//        }
//      if(OrderType()==OP_SELL)
//        {
//         if(Open[1]<ma && Close[1]>ma)
//           {
//            if(!OrderClose(OrderTicket(),OrderLots(),Ask,3,White))
//               Print("OrderClose error ",GetLastError());
//           }
//         break;
//        }
//     }
////---
//  }
//  
////---
//
//int CalculateCurrentOrders(string symbol)
//  {
//   int buys=0,sells=0;
////---
//   for(int i=0;i<OrdersTotal();i++)
//     {
//      if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES)==false) break;
//      if(OrderSymbol()==Symbol() && OrderMagicNumber()==MAGICMA)
//        {
//         if(OrderType()==OP_BUY)  buys++;
//         if(OrderType()==OP_SELL) sells++;
//        }
//     }
////--- return orders volume
//   if(buys>0) return(buys);
//   else       return(-sells);
//  }
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
         
         ticket = OrderSend(Symbol(),OP_BUY,1,1.12800,3,0,0,"My Test Buy order",16384,0,clrGreen);

         if(ticket<0)
            {
               Print("OrderSend failed with error #",GetLastError());
            }
         else
               Print("OrderSend placed successfully");
               
      }
      
   check_2 = ( Close[0] < ma ) && ( Close[1] >= ma );
   
   //printf( "Sell Condition " + IntegerToString(check_2) );
   
   if ( check_2 == True )
   
      {
         
         printf( "In Check 2 Condition");
         printf( "MA Value " + DoubleToString(ma) );
         printf( "Open Value " + DoubleToString(Open[0]) );
         printf( "Close Value " + DoubleToString(Close[1]) );
         
         ticket = OrderSend(Symbol(),OP_SELL,1,1.13300,3,0,0,"My Test Sell order",16384,0,clrRed);
         
         if(ticket<0)
            {
               Print("OrderSend failed with error #",GetLastError());
            }
         else
               Print("OrderSend placed successfully");
            
      }
      
 
   }  
//+------------------------------------------------------------------+

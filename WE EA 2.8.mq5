#property copyright "Copyright 2021, WetradeInvestment."
#property link      "https://www.wetradecapital.com"
#property version   "2.8"
/*#include <Indicators/Trend.mqh>
CiIchimoku* ichimoku;*/
#include <Trade/Trade.mqh>
CTrade trade;
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit(){

if(!TerminalInfoInteger(TERMINAL_CONNECTED))
{
   Alert("LE TERMINAL DE TRADING N'EST PAS CONNECTE");
   ExpertRemove();
}
return(INIT_SUCCEEDED);

}

void OnDeinit(const int reason){
}

void OnTick(){

static datetime timestamp;
datetime time= iTime(_Symbol,Period(),0);

if(timestamp != time){
   timestamp = time;
   
   /*********************/ 
   static int M1_WiSto14 = iStochastic (_Symbol,PERIOD_M1,14,3,3,MODE_SMA,STO_LOWHIGH);
   double M1_WiSto14_Array[];CopyBuffer(M1_WiSto14,0,0,3,M1_WiSto14_Array);ArraySetAsSeries(M1_WiSto14_Array,true);

   static int M1_WiRsi14 = iRSI (_Symbol,PERIOD_M1,14,PRICE_OPEN);
   double M1_WiRsi14_Array[];CopyBuffer(M1_WiRsi14,0,0,3,M1_WiRsi14_Array);ArraySetAsSeries(M1_WiRsi14_Array,true);
                
   static int M1_WiRsi40 = iRSI (_Symbol,PERIOD_M1,40,PRICE_OPEN);
   double M1_WiRsi40_Array[];CopyBuffer(M1_WiRsi40,0,0,3,M1_WiRsi40_Array);ArraySetAsSeries(M1_WiRsi40_Array,true);
   
   double M1WiRsi14Value=NormalizeDouble(M1_WiRsi14_Array[0],0);
   double M1WiSto14Value=NormalizeDouble(M1_WiSto14_Array[0],0);
   double M1WiRsi40Value=NormalizeDouble(M1_WiRsi40_Array[0],0);

   double lot_min = SymbolInfoDouble(_Symbol,SYMBOL_VOLUME_MIN);
   double  Bid = SymbolInfoDouble(_Symbol,SYMBOL_BID);
   double  Ask = SymbolInfoDouble(_Symbol,SYMBOL_ASK);
     
   /*Comment("Lot_min",lot_min,
            "Sl",sl);*/
      
   /*********************/
   if( Symbol()== "Crash 1000 Index"||Symbol()== "Crash 500 Index" )
   {
      if( ((M1_WiRsi14_Array[0]>=85)&&(M1_WiRsi14_Array[1]<85))||((M1_WiRsi14_Array[0]>=95)&&(M1_WiRsi14_Array[1]<95))||((M1_WiRsi14_Array[0]>=99)&&(M1_WiRsi14_Array[1]<99)) )
        {Alert("RSI(14) supérieur à ",M1WiRsi14Value," || "," STOCHASTIC(14) = ",M1WiSto14Value);}
        
      if( ((M1_WiRsi40_Array[0]>=75)&&(M1_WiRsi40_Array[1]<75))||((M1_WiRsi40_Array[0]>=80)&&(M1_WiRsi40_Array[1]<80)) )
        {Alert("RSI(40) supérieur à ",M1WiRsi40Value," || "," RSI(14) = ",M1WiRsi14Value);}    
   }
   if( Symbol()== "Boom 1000 Index"||Symbol()== "Boom 500 Index" )
   {
      if( ((M1_WiRsi14_Array[0]<=15)&&(M1_WiRsi14_Array[1]>15))||((M1_WiRsi14_Array[0]<=5)&&(M1_WiRsi14_Array[1]>5))||((M1_WiRsi14_Array[0]<=1)&&(M1_WiRsi14_Array[1]>1)) )
        {Alert("RSI(14) inférieur à ",M1WiRsi14Value," || "," STOCHASTIC(14) = ",M1WiSto14Value);}

      if( ((M1_WiRsi40_Array[0]<=25)&&(M1_WiRsi40_Array[1]>25))||((M1_WiRsi40_Array[0]<=20)&&(M1_WiRsi40_Array[1]>20)) )
        {Alert("RSI(40) inférieur à ",M1WiRsi40Value," || "," RSI(14) = ",M1WiRsi14Value);}
   }
   /*********************/
   double rsi_sl= (3/0.3);

   if( ((M1_WiRsi14_Array[0]>=99)&&(M1_WiRsi14_Array[1]<99)&&(Symbol()== "Crash 1000 Index"))||((M1_WiRsi14_Array[0]>=98)&&(M1_WiRsi14_Array[1]<98)&&(Symbol()== "Crash 500 Index")) )
     {trade.Sell(0.3,_Symbol,Bid,Bid+rsi_sl,NULL);Alert("TRADE OUVERT RSI(14) SELL ",M1WiRsi14Value);}

   if( ((M1_WiRsi14_Array[0]<=1)&&(M1_WiRsi14_Array[1]>1)&&(Symbol()== "Boom 1000 Index"))||((M1_WiRsi14_Array[0]<=2)&&(M1_WiRsi14_Array[1]>2)&&(Symbol()== "Boom 500 Index")) )
     {trade.Buy(0.3,_Symbol,Ask,Ask-rsi_sl,NULL);Alert("TRADE OUVERT RSI(14) BUY ",M1WiRsi14Value);}
        
   /*********************/
   MqlRates MarketPrice[];ArraySetAsSeries(MarketPrice,true);
   int Data = CopyRates(Symbol(),Period(),0,Bars(Symbol(),Period() ),MarketPrice);     
   
   static int WiEma200 = iMA (_Symbol,PERIOD_CURRENT,200,0,MODE_EMA,PRICE_OPEN);
   double WiEma200_Array[];ArraySetAsSeries(WiEma200_Array,true);CopyBuffer(WiEma200,0,0,3,WiEma200_Array);

   static int WiEma7 = iMA (_Symbol,PERIOD_CURRENT,7,0,MODE_EMA,PRICE_OPEN);
   double WiEma7_Array[];ArraySetAsSeries(WiEma7_Array,true);CopyBuffer(WiEma7,0,0,3,WiEma7_Array);

   /*********************/
   if( (MarketPrice[0].close < WiEma200_Array[0])&&(MarketPrice[1].open > WiEma200_Array[1]))
      {Alert("EMA(200) est en haut du marché");}

   if( (MarketPrice[0].close > WiEma200_Array[0])&&(MarketPrice[1].open < WiEma200_Array[1]))
      {Alert("EMA(200) est en bas du marché");}
      
   /*********************/
   double sl= (5/lot_min);
            
   if( (_Symbol != "Step Index")&&(_Period != PERIOD_M1)&&(WiEma7_Array[0] < WiEma200_Array[0])&&(WiEma7_Array[1] > WiEma200_Array[1]) ){
      trade.Sell(lot_min,_Symbol,Bid,Bid+sl,NULL);
      Alert("TRADE OUVERT EMA(200) SELL ");
   }
   if( (_Symbol != "Step Index")&&(_Period != PERIOD_M1)&&(WiEma7_Array[0] > WiEma200_Array[0])&&(WiEma7_Array[1] < WiEma200_Array[1]) ){
      trade.Buy(lot_min,_Symbol,Ask,Ask-sl,NULL);
      Alert("TRADE OUVERT EMA(200) BUY ");
   }

   /*********************/
   double step_sl= ((5/lot_min)/10);    
   if( (_Symbol == "Step Index")&&(_Period != PERIOD_M1)&&(WiEma7_Array[0] < WiEma200_Array[0])&&(WiEma7_Array[1] > WiEma200_Array[1]) ){
      trade.Sell(lot_min,_Symbol,Bid,Bid+step_sl,NULL);
      Alert("TRADE OUVERT EMA(200) SELL ");
   }
   if( (_Symbol == "Step Index")&&(_Period != PERIOD_M1)&&(WiEma7_Array[0] > WiEma200_Array[0])&&(WiEma7_Array[1] < WiEma200_Array[1]) ){
      trade.Buy(lot_min,_Symbol,Ask,Ask-step_sl,NULL);
      Alert("TRADE OUVERT EMA(200) BUY ");
   }
   
   //*************************************************************//
   /*ichimoku = new CiIchimoku();
   ichimoku.Create(_Symbol,PERIOD_CURRENT,9,26,52);
   ichimoku.Refresh(-1);
   
   if( (MarketPrice[0].close > ichimoku.SenkouSpanB(-26))
     &&(ichimoku.ChinkouSpan(26) > ichimoku.SenkouSpanB(-26))
     &&(ichimoku.KijunSen(0) > ichimoku.SenkouSpanB(-26))   )
     {Alert("Ichimoku : buy");}
     
   if( (ichimoku.SenkouSpanA(-26) > ichimoku.SenkouSpanB(-26))
     &&(ichimoku.SenkouSpanA(-16) > ichimoku.SenkouSpanB(-16))
     &&(ichimoku.SenkouSpanA(-16) > ichimoku.SenkouSpanA(-26))
     &&(ichimoku.SenkouSpanB(-16) > ichimoku.SenkouSpanB(-26)) )
     {Alert("Ichimoku : Nuage allongé vers le haut");} **/
  }
}
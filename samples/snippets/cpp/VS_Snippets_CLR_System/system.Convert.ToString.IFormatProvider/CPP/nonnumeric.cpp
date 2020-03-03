
//<Snippet2>
// Example of Convert::ToString( non-numeric types, IFormatProvider ).
using namespace System;
using namespace System::Globalization;

#define null (Object^)0

// An instance of this class can be passed to methods that require 
// an IFormatProvider.
ref class DummyProvider: public IFormatProvider
{
public:

   // Normally, GetFormat returns an object of the requested type
   // (usually itself) if it is able; otherwise, it returns Nothing. 
   virtual Object^ GetFormat( Type^ argType )
   {
      // Here, the type of argType is displayed, and GetFormat
      // always returns Nothing.
      Console::Write( "{0,-40}", argType->ToString() );
      return null;
   }
};

int main()
{
   // Create an instance of the IFormatProvider.
   DummyProvider^ provider = gcnew DummyProvider;
   String^ converted;

   // Convert these values using DummyProvider.
   int Int32A = -252645135;
   double DoubleA = 61680.3855;
   Object^ ObjDouble =  -98765.4321;
   DateTime DayTimeA = DateTime(2001,9,11,13,45,0);
   bool BoolA = true;
   String^ StringA = "Qwerty";
   Char CharA = '$';
   TimeSpan TSpanA = TimeSpan(0,18,0);
   Object^ ObjOther = static_cast<Object^>(provider);
   Console::WriteLine( "This example of "
   "Convert::ToString( non-numeric, IFormatProvider* ) \n"
   "generates the following output. The provider type, "
   "argument type, \nand argument value are displayed." );
   Console::WriteLine( "\nNote: The IFormatProvider object is "
   "not called for Boolean, String, \nChar, TimeSpan, "
   "and non-numeric Object." );

   // The format provider is called for these conversions.
   Console::WriteLine();
   converted = Convert::ToString( Int32A, provider );
   Console::WriteLine( "int      {0}", converted );
   converted = Convert::ToString( DoubleA, provider );
   Console::WriteLine( "double   {0}", converted );
   converted = Convert::ToString( ObjDouble, provider );
   Console::WriteLine( "Object   {0}", converted );
   converted = Convert::ToString( DayTimeA, provider );
   Console::WriteLine( "DateTime {0}", converted );

   // The format provider is not called for these conversions.
   Console::WriteLine();
   converted = Convert::ToString( BoolA, provider );
   Console::WriteLine( "bool     {0}", converted );
   converted = Convert::ToString( StringA, provider );
   Console::WriteLine( "String   {0}", converted );
   converted = Convert::ToString( CharA, provider );
   Console::WriteLine( "Char     {0}", converted );
   converted = Convert::ToString( TSpanA, provider );
   Console::WriteLine( "TimeSpan {0}", converted );
   converted = Convert::ToString( ObjOther, provider );
   Console::WriteLine( "Object   {0}", converted );
}

/*
This example of Convert::ToString( non-numeric, IFormatProvider* )
generates the following output. The provider type, argument type,
and argument value are displayed.

Note: The IFormatProvider object is not called for Boolean, String,
Char, TimeSpan, and non-numeric Object.

System.Globalization.NumberFormatInfo   int      -252645135
System.Globalization.NumberFormatInfo   double   61680.3855
System.Globalization.NumberFormatInfo   Object   -98765.4321
System.Globalization.DateTimeFormatInfo DateTime 9/11/2001 1:45:00 PM

bool     True
String   Qwerty
Char     $
TimeSpan 00:18:00
Object   DummyProvider
*/
//</Snippet2>

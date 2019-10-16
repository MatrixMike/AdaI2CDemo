with MicroBit.Display; use MicroBit.Display;
with MicroBit.Time;    use MicroBit.Time;
with MicroBit.I2C;     use MicroBit.I2C;
with HAL.I2C;          use HAL.I2C;

procedure Main is
begin

   MicroBit.I2C.Initialize (S400kbps);   --  Change to desired speed.

   declare    
      Ctrl   : constant Any_I2C_Port := MicroBit.I2C.Controller;
      Addr   : constant I2C_Address := 16#08#;    --  Change to correct address.
      Data   : I2C_Data (0 .. 0);
      Status : I2C_Status;
   begin
      loop

         --  Data to be send (here: character 'x').
         Data (0) := Character'Pos ('x');

         --  Display a dot to indicate where we are.
         Display ('.');

         --  Send 1 byte of data (length of Data array is 1).
         Ctrl.Master_Transmit (Addr, Data, Status);

         --  Additional status checking could be done here....

         --  Display a colon to indicate where we are.
         Display (':');

         --  Wait for response (1 byte as the length of the Data array is 1).         
         Ctrl.Master_Receive (Addr, Data, Status);

         --  Check status, and display character if OK.
         if Status = Ok then
            Display (Character'Val (Data (0)));
         else
            Display ('!');
         end if;

         -- Take a short nap (time in milliseconds).
         Sleep (250);

      end loop;
   end;

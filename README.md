# xlsx2FuelCon

#### Convert Excel spreadsheets into xml files for the FuelCon Evaluator B test bench sequencer

xlsx2FuelCon can be used to convert battery tests described in Excel spreadsheets to xml files which can be imported and executed on FuelCon Evaluator B battery test benches. Users can specify all setpoints for tags, switching conditions, register conditions and loops. An example how to implement the IEC 62660 norm test in Excel can be found in the folder `examples`.

#### Features of xlsx2FuelCon
* Simple description of the test regime in Excel, so that even people who are not familiar with the test bench can implement test cases.
* Easy way to integrate drive cycles for battery tests e.g. IEC62660, UDDS, US06, NYCC HWFET...
* Fast adaption of test cases for different cell types and sizes.
* Offline implementation of test sequences, TestWorks is not needed for implementation.

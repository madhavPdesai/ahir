#include <Aa2C.h>
typedef struct Access_Address_State__
{
  pointer req;
  uint_8 addr;
  unsigned Access_Address_entry:1;
  unsigned Access_Address_in_progress:1;
  unsigned Access_Address_exit:1;
} Access_Address_State;
int Access_Address (pointer, uint_8 *);
typedef struct Access_Data_State__
{
  pointer req;
  uint_32 data;
  unsigned Access_Data_entry:1;
  unsigned Access_Data_in_progress:1;
  unsigned Access_Data_exit:1;
} Access_Data_State;
int Access_Data (pointer, uint_32 *);
typedef struct Fetch_State__
{
  pointer req;
  unsigned Fetch_entry:1;
  unsigned Fetch_in_progress:1;
  unsigned Fetch_exit:1;
} Fetch_State;
int Fetch (pointer *);
typedef struct Is_Read_Access_State__
{
  pointer req;
  uint_1 flag;
  unsigned Is_Read_Access_entry:1;
  unsigned Is_Read_Access_in_progress:1;
  unsigned Is_Read_Access_exit:1;
} Is_Read_Access_State;
int Is_Read_Access (pointer, uint_1 *);
typedef struct Read_Hit_State__
{
  uint_8 addr;
  uint_32 data;
  unsigned Read_Hit_entry:1;
  unsigned Read_Hit_in_progress:1;
  unsigned Read_Hit_exit:1;
} Read_Hit_State;
int Read_Hit (uint_8, uint_32);
typedef struct Read_Miss_State__
{
  uint_8 addr;
  unsigned Read_Miss_entry:1;
  unsigned Read_Miss_in_progress:1;
  unsigned Read_Miss_exit:1;
} Read_Miss_State;
int Read_Miss (uint_8);
typedef struct Write_Hit_State__
{
  uint_8 addr;
  unsigned Write_Hit_entry:1;
  unsigned Write_Hit_in_progress:1;
  unsigned Write_Hit_exit:1;
} Write_Hit_State;
int Write_Hit (uint_8);
typedef struct Write_Miss_State__
{
  uint_8 addr;
  unsigned Write_Miss_entry:1;
  unsigned Write_Miss_in_progress:1;
  unsigned Write_Miss_exit:1;
} Write_Miss_State;
int Write_Miss (uint_8);
typedef struct cachememory_State__
{
  uint_8 addr_array[4];
  uint_1 valid_array[4];
  uint_32 data_array[4];
  uint_8 map_mask;
  uint_8 write_address_pipe;
  unsigned int write_address_pipe_valid__:1;
  uint_32 write_data_pipe;
  unsigned int write_data_pipe_valid__:1;
  uint_8 read_address_pipe;
  unsigned int read_address_pipe_valid__:1;
  struct _init__
  {
    uint_2 I;
    unsigned int init_entry:1;
    unsigned int init_exit:1;
    unsigned int init_in_progress:1;
    unsigned int _merge_line_38_entry:1;
    unsigned int _merge_line_38_exit:1;
    unsigned int _merge_line_38_in_progress:1;
    unsigned int _merge_line_38_from_entry:1;
    unsigned int _assign_line_39_entry:1;
    unsigned int _assign_line_39_in_progress:1;
    unsigned int _assign_line_39_exit:1;
    unsigned int _assign_line_40_entry:1;
    unsigned int _assign_line_40_in_progress:1;
    unsigned int _assign_line_40_exit:1;
    unsigned int _assign_line_41_entry:1;
    unsigned int _assign_line_41_in_progress:1;
    unsigned int _assign_line_41_exit:1;
    unsigned int _if_line_10309976_entry:1;
    unsigned int _if_line_10309976_in_progress:1;
    unsigned int _if_line_10309976_exit:1;
    unsigned int _assign_line_43_entry:1;
    unsigned int _assign_line_43_in_progress:1;
    unsigned int _assign_line_43_exit:1;
    unsigned int loopback:1;
    unsigned int _place_line_44_entry:1;
  } init;
  struct _p1__
  {
    unsigned int p1_entry:1;
    unsigned int p1_exit:1;
    unsigned int p1_in_progress:1;
    struct _reader__
    {
      unsigned int reader_entry:1;
      unsigned int reader_exit:1;
      unsigned int reader_in_progress:1;
      unsigned int _merge_line_52_entry:1;
      unsigned int _merge_line_52_exit:1;
      unsigned int _merge_line_52_in_progress:1;
      unsigned int _merge_line_52_from_entry:1;
      unsigned int _call_line_53_entry:1;
      unsigned int _call_line_53_in_progress:1;
      unsigned int _call_line_53_exit:1;
      pointer req_pointer;
      Fetch_State *_call_line_53_called_fn_struct;
      unsigned int _call_line_55_entry:1;
      unsigned int _call_line_55_in_progress:1;
      unsigned int _call_line_55_exit:1;
      uint_1 is_read;
      Is_Read_Access_State *_call_line_55_called_fn_struct;
      unsigned int _if_line_56_entry:1;
      unsigned int _if_line_56_in_progress:1;
      unsigned int _if_line_56_exit:1;
      unsigned int _call_line_57_entry:1;
      unsigned int _call_line_57_in_progress:1;
      unsigned int _call_line_57_exit:1;
      Access_Address_State *_call_line_57_called_fn_struct;
      struct _extwrite__
      {
	unsigned int extwrite_entry:1;
	unsigned int extwrite_exit:1;
	unsigned int extwrite_in_progress:1;
	unsigned int _call_line_60_entry:1;
	unsigned int _call_line_60_in_progress:1;
	unsigned int _call_line_60_exit:1;
	Access_Address_State *_call_line_60_called_fn_struct;
	unsigned int _call_line_61_entry:1;
	unsigned int _call_line_61_in_progress:1;
	unsigned int _call_line_61_exit:1;
	Access_Data_State *_call_line_61_called_fn_struct;
      } extwrite;
      unsigned int loopback:1;
      unsigned int _place_line_64_entry:1;
    } reader;
    struct _writeport__
    {
      uint_32 write_data;
      uint_8 write_address;
      unsigned int writeport_entry:1;
      unsigned int writeport_exit:1;
      unsigned int writeport_in_progress:1;
      unsigned int _merge_line_71_entry:1;
      unsigned int _merge_line_71_exit:1;
      unsigned int _merge_line_71_in_progress:1;
      unsigned int _merge_line_71_from_entry:1;
      struct _getdetails__
      {
	unsigned int getdetails_entry:1;
	unsigned int getdetails_exit:1;
	unsigned int getdetails_in_progress:1;
	unsigned int _assign_line_73_entry:1;
	unsigned int _assign_line_73_in_progress:1;
	unsigned int _assign_line_73_exit:1;
	unsigned int _assign_line_74_entry:1;
	unsigned int _assign_line_74_in_progress:1;
	unsigned int _assign_line_74_exit:1;
      } getdetails;
      unsigned int _assign_line_76_entry:1;
      unsigned int _assign_line_76_in_progress:1;
      unsigned int _assign_line_76_exit:1;
      uint_8 addr;
      unsigned int _if_line_77_entry:1;
      unsigned int _if_line_77_in_progress:1;
      unsigned int _if_line_77_exit:1;
      unsigned int _if_line_78_entry:1;
      unsigned int _if_line_78_in_progress:1;
      unsigned int _if_line_78_exit:1;
      unsigned int _assign_line_80_entry:1;
      unsigned int _assign_line_80_in_progress:1;
      unsigned int _assign_line_80_exit:1;
      unsigned int _call_line_81_entry:1;
      unsigned int _call_line_81_in_progress:1;
      unsigned int _call_line_81_exit:1;
      Write_Hit_State *_call_line_81_called_fn_struct;
      unsigned int _call_line_84_entry:1;
      unsigned int _call_line_84_in_progress:1;
      unsigned int _call_line_84_exit:1;
      Write_Miss_State *_call_line_84_called_fn_struct;
      unsigned int _assign_line_88_entry:1;
      unsigned int _assign_line_88_in_progress:1;
      unsigned int _assign_line_88_exit:1;
      unsigned int _assign_line_89_entry:1;
      unsigned int _assign_line_89_in_progress:1;
      unsigned int _assign_line_89_exit:1;
      unsigned int _assign_line_90_entry:1;
      unsigned int _assign_line_90_in_progress:1;
      unsigned int _assign_line_90_exit:1;
      unsigned int _call_line_91_entry:1;
      unsigned int _call_line_91_in_progress:1;
      unsigned int _call_line_91_exit:1;
      Write_Hit_State *_call_line_91_called_fn_struct;
      unsigned int loopback:1;
      unsigned int _place_line_93_entry:1;
    } writeport;
    struct _readport__
    {
      uint_8 read_address;
      unsigned int readport_entry:1;
      unsigned int readport_exit:1;
      unsigned int readport_in_progress:1;
      unsigned int _merge_line_99_entry:1;
      unsigned int _merge_line_99_exit:1;
      unsigned int _merge_line_99_in_progress:1;
      unsigned int _merge_line_99_from_entry:1;
      unsigned int _assign_line_100_entry:1;
      unsigned int _assign_line_100_in_progress:1;
      unsigned int _assign_line_100_exit:1;
      unsigned int _assign_line_101_entry:1;
      unsigned int _assign_line_101_in_progress:1;
      unsigned int _assign_line_101_exit:1;
      uint_8 addr;
      unsigned int _if_line_102_entry:1;
      unsigned int _if_line_102_in_progress:1;
      unsigned int _if_line_102_exit:1;
      unsigned int _if_line_103_entry:1;
      unsigned int _if_line_103_in_progress:1;
      unsigned int _if_line_103_exit:1;
      unsigned int _call_line_105_entry:1;
      unsigned int _call_line_105_in_progress:1;
      unsigned int _call_line_105_exit:1;
      Read_Hit_State *_call_line_105_called_fn_struct;
      unsigned int _call_line_108_entry:1;
      unsigned int _call_line_108_in_progress:1;
      unsigned int _call_line_108_exit:1;
      Read_Miss_State *_call_line_108_called_fn_struct;
      unsigned int _call_line_112_entry:1;
      unsigned int _call_line_112_in_progress:1;
      unsigned int _call_line_112_exit:1;
      Read_Miss_State *_call_line_112_called_fn_struct;
      unsigned int loopback:1;
      unsigned int _place_line_114_entry:1;
    } readport;
  } p1;
  unsigned cachememory_entry:1;
  unsigned cachememory_in_progress:1;
  unsigned cachememory_exit:1;
} cachememory_State;
cachememory_State *cachememory_ (cachememory_State *);
int cachememory ();

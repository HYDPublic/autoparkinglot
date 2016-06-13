/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;

char *IEEE_P_2592010699;
char *STD_STANDARD;
char *STD_TEXTIO;
char *XILINXCORELIB_P_1837083571;
char *IEEE_P_3499444699;
char *IEEE_P_3620187407;
char *XILINXCORELIB_P_2147798235;
char *XILINXCORELIB_P_0914797037;
char *XILINXCORELIB_P_0558180590;
char *XILINXCORELIB_P_3350621131;
char *IEEE_P_1242562249;
char *XILINXCORELIB_P_3155556343;
char *XILINXCORELIB_P_3743709326;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    ieee_p_2592010699_init();
    std_textio_init();
    xilinxcorelib_p_1837083571_init();
    ieee_p_3499444699_init();
    ieee_p_3620187407_init();
    xilinxcorelib_p_2147798235_init();
    xilinxcorelib_p_0914797037_init();
    xilinxcorelib_p_0558180590_init();
    xilinxcorelib_p_3350621131_init();
    ieee_p_1242562249_init();
    xilinxcorelib_p_3155556343_init();
    xilinxcorelib_p_3743709326_init();
    xilinxcorelib_a_1030805177_3212880686_init();
    xilinxcorelib_a_3639502287_3212880686_init();
    xilinxcorelib_a_1459934909_3212880686_init();
    xilinxcorelib_a_2996463051_3212880686_init();
    xilinxcorelib_a_0761139177_3212880686_init();
    xilinxcorelib_a_3454027907_3212880686_init();
    xilinxcorelib_a_3236658251_3212880686_init();
    work_a_0046038515_4092050824_init();
    work_a_2409194749_2372691052_init();


    xsi_register_tops("work_a_2409194749_2372691052");

    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    STD_TEXTIO = xsi_get_engine_memory("std_textio");
    XILINXCORELIB_P_1837083571 = xsi_get_engine_memory("xilinxcorelib_p_1837083571");
    IEEE_P_3499444699 = xsi_get_engine_memory("ieee_p_3499444699");
    IEEE_P_3620187407 = xsi_get_engine_memory("ieee_p_3620187407");
    XILINXCORELIB_P_2147798235 = xsi_get_engine_memory("xilinxcorelib_p_2147798235");
    XILINXCORELIB_P_0914797037 = xsi_get_engine_memory("xilinxcorelib_p_0914797037");
    XILINXCORELIB_P_0558180590 = xsi_get_engine_memory("xilinxcorelib_p_0558180590");
    XILINXCORELIB_P_3350621131 = xsi_get_engine_memory("xilinxcorelib_p_3350621131");
    IEEE_P_1242562249 = xsi_get_engine_memory("ieee_p_1242562249");
    XILINXCORELIB_P_3155556343 = xsi_get_engine_memory("xilinxcorelib_p_3155556343");
    XILINXCORELIB_P_3743709326 = xsi_get_engine_memory("xilinxcorelib_p_3743709326");

    return xsi_run_simulation(argc, argv);

}

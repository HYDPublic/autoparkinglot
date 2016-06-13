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
char *IEEE_P_3499444699;
char *IEEE_P_3620187407;
char *XILINXCORELIB_P_1837083571;
char *XILINXCORELIB_P_2147798235;
char *XILINXCORELIB_P_0914797037;
char *XILINXCORELIB_P_0558180590;
char *IEEE_P_3564397177;
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
    ieee_p_3499444699_init();
    ieee_p_3620187407_init();
    std_textio_init();
    ieee_p_3564397177_init();
    xilinxcorelib_a_0554008015_2959432447_init();
    xilinxcorelib_a_2554465728_2959432447_init();
    xilinxcorelib_a_1171575509_1709443946_init();
    xilinxcorelib_a_1273191060_0543512595_init();
    xilinxcorelib_a_2172033089_3212880686_init();
    work_a_3671351595_0456468052_init();
    xilinxcorelib_p_1837083571_init();
    xilinxcorelib_p_2147798235_init();
    xilinxcorelib_p_0914797037_init();
    xilinxcorelib_p_0558180590_init();
    xilinxcorelib_p_3350621131_init();
    ieee_p_1242562249_init();
    xilinxcorelib_p_3155556343_init();
    xilinxcorelib_p_3743709326_init();
    xilinxcorelib_a_1030805177_3212880686_init();
    xilinxcorelib_a_3639502287_3212880686_init();
    xilinxcorelib_a_2794748374_3212880686_init();
    xilinxcorelib_a_1124780704_3212880686_init();
    xilinxcorelib_a_4266474058_3212880686_init();
    xilinxcorelib_a_0519273760_3212880686_init();
    xilinxcorelib_a_1508471766_3212880686_init();
    work_a_0046038515_4092050824_init();
    work_a_0091327676_3212880686_init();
    work_a_2933981886_2372691052_init();


    xsi_register_tops("work_a_2933981886_2372691052");

    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    STD_TEXTIO = xsi_get_engine_memory("std_textio");
    IEEE_P_3499444699 = xsi_get_engine_memory("ieee_p_3499444699");
    IEEE_P_3620187407 = xsi_get_engine_memory("ieee_p_3620187407");
    XILINXCORELIB_P_1837083571 = xsi_get_engine_memory("xilinxcorelib_p_1837083571");
    XILINXCORELIB_P_2147798235 = xsi_get_engine_memory("xilinxcorelib_p_2147798235");
    XILINXCORELIB_P_0914797037 = xsi_get_engine_memory("xilinxcorelib_p_0914797037");
    XILINXCORELIB_P_0558180590 = xsi_get_engine_memory("xilinxcorelib_p_0558180590");
    IEEE_P_3564397177 = xsi_get_engine_memory("ieee_p_3564397177");
    XILINXCORELIB_P_3350621131 = xsi_get_engine_memory("xilinxcorelib_p_3350621131");
    IEEE_P_1242562249 = xsi_get_engine_memory("ieee_p_1242562249");
    XILINXCORELIB_P_3155556343 = xsi_get_engine_memory("xilinxcorelib_p_3155556343");
    XILINXCORELIB_P_3743709326 = xsi_get_engine_memory("xilinxcorelib_p_3743709326");

    return xsi_run_simulation(argc, argv);

}

/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx = 4; /* border pixel of windows */
static const Gap default_gap = {.isgap = 1, .realgap = 15, .gappx = 15};
static const unsigned int snap = 32; /* snap pixel */
static const int showbar = 1;        /* 0 means no bar */
static const int topbar = 1;         /* 0 means bottom bar */
static const char *fonts[] = {"UbuntuMono Nerd:size=10"};
static const char dmenufont[] = "UbuntuMono Nerd:size=10";
/* static const char col_gray1[]       = "#000000";
  static const char col_gray2[]       = "#1e1e1e";
  static const char col_gray3[]       = "#ffffff";
  static const char col_gray4[]       = "#ffffff";*/
static const char col_cyan[] = "#000000";
static const unsigned int baralpha = 0xc0;
static const unsigned int borderalpha = OPAQUE;
/*static const char *colors[][3]      = {*/
/*               fg         bg         border   */
/*	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
        [SchemeSel]  = { col_gray4, col_cyan,  col_gray3  },
        };*/
#include "/home/mario/.cache/wal/colors-wal-dwm.h"
static const unsigned int alphas[][3] = {
    /*               fg      bg        border     */
    [SchemeNorm] = {OPAQUE, baralpha, borderalpha},
    [SchemeSel] = {OPAQUE, OPAQUE, borderalpha},
};

/* tagging */
static const char *tags[] = {
    "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX",
};

static const Rule rules[] = {
    /* xprop(1):
     *	WM_CLASS(STRING) = instance, class
     *	WM_NAME(STRING) = title
     */
    /* class               instance    title      tags mask  switchtotag
       isfloating monitor */
    /*{ "tabbed",            NULL,	   NULL,	   1<<2,    1, 0, -1
       },*/
    {"Firefox", NULL, NULL, 1 << 2, 1, 0, -1},
    {"Tor Browser", NULL, NULL, 1 << 2, 1, 0, -1},
    {NULL, NULL, "mocp", 1 << 7, 1, 0, -1},
    {NULL, NULL, "vifm", 1 << 1, 1, 0, -1},
    {"mpv", NULL, NULL, 1 << 8, 1, 0, -1},
    {NULL, NULL, "calcurse", 1 << 6, 1, 0, -1},
    {NULL, NULL, "neomutt", 1 << 4, 1, 0, -1},
    {NULL, NULL, "newsboat", 1 << 3, 1, 0, -1},
    {"Signal", NULL, NULL, 1 << 5, 1, 0, -1},
    {"TelegramDesktop", NULL, NULL, 1 << 5, 1, 0, -1},
    {NULL, NULL, "pulsemixer", NULL, 0, 1, -1},
    {NULL, NULL, "/home/mario/.local/bin/scripts/updatewal.sh", NULL, 0, 1, -1},
    {"Emacs", NULL, NULL, 1 << 0, 1, 0, -1},
    {"zoom", NULL, NULL, 1 << 8, 1, 0, -1},

};

/* layout(s) */
static const float mfact = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;    /* number of clients in master area */
static const int resizehints =
    0; /* 1 means respect size hints in tiled resizals */

static const Layout layouts[] = {
    /* symbol     arrange function */
    {"tile", tile},  /* first entry is default */
    {"float", NULL}, /* no layout function means floating behavior */
    {"[M]", monocle},
    {"|M|", centeredmaster},
};

/* key definitions */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY, TAG)                                                      \
  {MODKEY, KEY, comboview, {.ui = 1 << TAG}},                                  \
      {MODKEY | ControlMask, KEY, toggleview, {.ui = 1 << TAG}},               \
      {MODKEY | ShiftMask, KEY, combotag, {.ui = 1 << TAG}},                   \
      {MODKEY | ControlMask | ShiftMask, KEY, toggletag, {.ui = 1 << TAG}},

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd)                                                             \
  {                                                                            \
    .v = (const char *[]) { "/bin/sh", "-c", cmd, NULL }                       \
  }

/* commands */
static char dmenumon[2] =
    "0"; /* component of dmenucmd, manipulated in spawn() */
// static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn",
// dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf",
// col_gray4, "-l", "15", "-g", "3", "-c", NULL };
static const char *dmenucmd[] = {"dmenu_run", "-m", dmenumon, "-fn",
                                 dmenufont,   "-l", "15",     "-g",
                                 "3",         "-c", NULL};
// static const char *dmenucmd[] = { "/home/mario/.local/bin/scripts/dmen.sh",
// NULL }; //Dmenu pywal colors
static const char *termcmd[] = {"st", NULL};

static Key keys[] = {
    /* modifier                     key        function        argument */
    {MODKEY, XK_semicolon, spawn, {.v = dmenucmd}},
    {MODKEY | ShiftMask, XK_b, togglebar, {0}},
    {MODKEY | ShiftMask, XK_j, rotatestack, {.i = +1}},
    {MODKEY | ShiftMask, XK_k, rotatestack, {.i = -1}},
    {MODKEY, XK_j, focusstack, {.i = +1}},
    {MODKEY, XK_k, focusstack, {.i = -1}},
    {MODKEY, XK_i, incnmaster, {.i = +1}},
    {MODKEY, XK_u, incnmaster, {.i = -1}},
    {MODKEY, XK_h, setmfact, {.f = -0.05}},
    {MODKEY, XK_l, setmfact, {.f = +0.05}},
    {MODKEY, XK_space, zoom, {0}},
    {MODKEY, XK_Tab, view, {0}},
    {MODKEY, XK_d, killclient, {0}},
    {MODKEY, XK_w, setlayout, {.v = &layouts[0]}},
    {MODKEY | ShiftMask, XK_space, setlayout, {.v = &layouts[1]}},
    {MODKEY, XK_e, setlayout, {.v = &layouts[2]}},
    {MODKEY, XK_c, setlayout, {.v = &layouts[3]}},
    {MODKEY, XK_q, togglefloating, {0}},
    {MODKEY, XK_0, view, {.ui = ~0}},
    {MODKEY | ShiftMask, XK_0, tag, {.ui = ~0}},
    {MODKEY, XK_comma, focusmon, {.i = -1}},
    {MODKEY, XK_period, focusmon, {.i = +1}},
    {MODKEY | ShiftMask, XK_comma, tagmon, {.i = -1}},
    {MODKEY | ShiftMask, XK_period, tagmon, {.i = +1}},
    {MODKEY | ControlMask, XK_minus, setgaps, {.i = -5}},
    {MODKEY | ControlMask, XK_equal, setgaps, {.i = +5}},
    {MODKEY | ShiftMask, XK_minus, setgaps, {.i = GAP_RESET}},
    {MODKEY | ControlMask, XK_0, setgaps, {.i = GAP_TOGGLE}},
    {MODKEY, XK_v, focusmaster, {0}},
    TAGKEYS(XK_1, 0) TAGKEYS(XK_2, 1) TAGKEYS(XK_3, 2) TAGKEYS(XK_4, 3)
        TAGKEYS(XK_5, 4) TAGKEYS(XK_6, 5) TAGKEYS(XK_7, 6) TAGKEYS(XK_8, 7)
            TAGKEYS(XK_9, 8){MODKEY | ShiftMask, XK_q, quit, {0}},
    {MODKEY | ShiftMask, XK_r, quit, {1}},
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle,
 * ClkClientWin, or ClkRootWin */
static Button buttons[] = {
    /* click                event mask      button          function argument
     */
    {ClkLtSymbol, 0, Button1, setlayout, {0}},
    {ClkLtSymbol, 0, Button3, setlayout, {.v = &layouts[2]}},
    {ClkWinTitle, 0, Button2, zoom, {0}},
    {ClkStatusText, 0, Button2, spawn, {.v = termcmd}},
    {ClkClientWin, MODKEY, Button1, movemouse, {0}},
    {ClkClientWin, MODKEY, Button2, togglefloating, {0}},
    {ClkClientWin, MODKEY, Button3, resizemouse, {0}},
    {ClkTagBar, 0, Button1, view, {0}},
    {ClkTagBar, 0, Button3, toggleview, {0}},
    {ClkTagBar, MODKEY, Button1, tag, {0}},
    {ClkTagBar, MODKEY, Button3, toggletag, {0}},
};
#ifndef TQUICKGLOBAL_H
#define TQUICKGLOBAL_H

#include <QObject>

//qml type TStateType.
namespace TQuick_State {
Q_NAMESPACE
enum TQuickStateType {
    Normal = 0x0,
    Hover = 0x1,
    Pressed = 0x2,
    Checked = 0x3
};
Q_ENUMS(TQuickStateType);
}

//qml type TPositionType.
namespace TQuick_Position {
Q_NAMESPACE
enum TQuickPositionType {
    Left,
    Reght,
    Top,
    Bottom,
    Center,
    Only,
    };
Q_ENUMS(TQuickPositionType);
}

//qml type TIconType.
namespace TQuick_Icon {
Q_NAMESPACE
enum TQuickIconType {
    Awesome,
    SVG,
    };
Q_ENUMS(TQuickIconType);
}

//qml type TTimePreset.
namespace TQuick_Time {
Q_NAMESPACE
enum class TQuickTimePreset {
    DevilTime3600s = 500,   // :)
    T1s = 1 * 1000,
    T2s = 2 * 1000,
    T3s = 3 * 1000,
    T4s = 4 * 1000,
    T5s = 5 * 1000,
    T6s = 6 * 1000,
    T7s = 7 * 3000,
    T8s = 8 * 5000,
    T9s = 9 * 5000,
    ShortTime2s =  T2s,
    LongTime4s =  T4s,
    };
Q_ENUMS(TQuickTimePreset);
}

//h1=32px h2=24px h3=19px h4=16px h5=14px h6=12px
//qml type TTimePreset.
namespace TQuick_PixelSize {
Q_NAMESPACE
enum class TQuickPixelSizePreset {
    PH1 = 32,
    PH2 = 24,
    PH3 = 19,
    PH4 = 16,
    PH5 = 14,
    PH6 = 12,
    PH7 = 10,
    PH8 = 8
};
Q_ENUMS(TQuickPixelSizePreset);
}

//qml type TAwesomeType.
//已经支持最新的4.7.0   785个图标
//http://www.fontawesome.com.cn/faicons/
namespace TQuick_Awesome {
Q_NAMESPACE
enum class TQuickAwesomeType{
    FA_glass = 0xf000,
    FA_music = 0xf001,
    FA_search = 0xf002,
    FA_envelope_o = 0xf003,
    FA_heart = 0xf004,
    FA_star = 0xf005,
    FA_star_o = 0xf006,
    FA_user = 0xf007,
    FA_film = 0xf008,
    FA_th_large = 0xf009,
    FA_th = 0xf00a,
    FA_th_list = 0xf00b,
    FA_check = 0xf00c,
    FA_remove = 0xf00d,
    FA_close = 0xf00d,
    FA_times = 0xf00d,
    FA_search_plus = 0xf00e,
    FA_search_minus = 0xf010,
    FA_power_off = 0xf011,
    FA_signal = 0xf012,
    FA_gear = 0xf013,
    FA_cog = 0xf013,
    FA_trash_o = 0xf014,
    FA_home = 0xf015,
    FA_file_o = 0xf016,
    FA_clock_o = 0xf017,
    FA_road = 0xf018,
    FA_download = 0xf019,
    FA_arrow_circle_o_down = 0xf01a,
    FA_arrow_circle_o_up = 0xf01b,
    FA_inbox = 0xf01c,
    FA_play_circle_o = 0xf01d,
    FA_rotate_right = 0xf01e,
    FA_repeat = 0xf01e,
    FA_refresh = 0xf021,
    FA_list_alt = 0xf022,
    FA_lock = 0xf023,
    FA_flag = 0xf024,
    FA_headphones = 0xf025,
    FA_volume_off = 0xf026,
    FA_volume_down = 0xf027,
    FA_volume_up = 0xf028,
    FA_qrcode = 0xf029,
    FA_barcode = 0xf02a,
    FA_tag = 0xf02b,
    FA_tags = 0xf02c,
    FA_book = 0xf02d,
    FA_bookmark = 0xf02e,
    FA_print = 0xf02f,
    FA_camera = 0xf030,
    FA_font = 0xf031,
    FA_bold = 0xf032,
    FA_italic = 0xf033,
    FA_text_height = 0xf034,
    FA_text_width = 0xf035,
    FA_align_left = 0xf036,
    FA_align_center = 0xf037,
    FA_align_right = 0xf038,
    FA_align_justify = 0xf039,
    FA_list = 0xf03a,
    FA_dedent = 0xf03b,
    FA_outdent = 0xf03b,
    FA_indent = 0xf03c,
    FA_video_camera = 0xf03d,
    FA_photo = 0xf03e,
    FA_image = 0xf03e,
    FA_picture_o = 0xf03e,
    FA_pencil = 0xf040,
    FA_map_marker = 0xf041,
    FA_adjust = 0xf042,
    FA_tint = 0xf043,
    FA_edit = 0xf044,
    FA_pencil_square_o = 0xf044,
    FA_share_square_o = 0xf045,
    FA_check_square_o = 0xf046,
    FA_arrows = 0xf047,
    FA_step_backward = 0xf048,
    FA_fast_backward = 0xf049,
    FA_backward = 0xf04a,
    FA_play = 0xf04b,
    FA_pause = 0xf04c,
    FA_stop = 0xf04d,
    FA_forward = 0xf04e,
    FA_fast_forward = 0xf050,
    FA_step_forward = 0xf051,
    FA_eject = 0xf052,
    FA_chevron_left = 0xf053,
    FA_chevron_right = 0xf054,
    FA_plus_circle = 0xf055,
    FA_minus_circle = 0xf056,
    FA_times_circle = 0xf057,
    FA_check_circle = 0xf058,
    FA_question_circle = 0xf059,
    FA_info_circle = 0xf05a,
    FA_crosshairs = 0xf05b,
    FA_times_circle_o = 0xf05c,
    FA_check_circle_o = 0xf05d,
    FA_ban = 0xf05e,
    FA_arrow_left = 0xf060,
    FA_arrow_right = 0xf061,
    FA_arrow_up = 0xf062,
    FA_arrow_down = 0xf063,
    FA_mail_forward = 0xf064,
    FA_share = 0xf064,
    FA_expand = 0xf065,
    FA_compress = 0xf066,
    FA_plus = 0xf067,
    FA_minus = 0xf068,
    FA_asterisk = 0xf069,
    FA_exclamation_circle = 0xf06a,
    FA_gift = 0xf06b,
    FA_leaf = 0xf06c,
    FA_fire = 0xf06d,
    FA_eye = 0xf06e,
    FA_eye_slash = 0xf070,
    FA_warning = 0xf071,
    FA_exclamation_triangle = 0xf071,
    FA_plane = 0xf072,
    FA_calendar = 0xf073,
    FA_random = 0xf074,
    FA_comment = 0xf075,
    FA_magnet = 0xf076,
    FA_chevron_up = 0xf077,
    FA_chevron_down = 0xf078,
    FA_retweet = 0xf079,
    FA_shopping_cart = 0xf07a,
    FA_folder = 0xf07b,
    FA_folder_open = 0xf07c,
    FA_arrows_v = 0xf07d,
    FA_arrows_h = 0xf07e,
    FA_bar_chart_o = 0xf080,
    FA_bar_chart = 0xf080,
    FA_twitter_square = 0xf081,
    FA_facebook_square = 0xf082,
    FA_camera_retro = 0xf083,
    FA_key = 0xf084,
    FA_gears = 0xf085,
    FA_cogs = 0xf085,
    FA_comments = 0xf086,
    FA_thumbs_o_up = 0xf087,
    FA_thumbs_o_down = 0xf088,
    FA_star_half = 0xf089,
    FA_heart_o = 0xf08a,
    FA_sign_out = 0xf08b,
    FA_linkedin_square = 0xf08c,
    FA_thumb_tack = 0xf08d,
    FA_external_link = 0xf08e,
    FA_sign_in = 0xf090,
    FA_trophy = 0xf091,
    FA_github_square = 0xf092,
    FA_upload = 0xf093,
    FA_lemon_o = 0xf094,
    FA_phone = 0xf095,
    FA_square_o = 0xf096,
    FA_bookmark_o = 0xf097,
    FA_phone_square = 0xf098,
    FA_twitter = 0xf099,
    FA_facebook_f = 0xf09a,
    FA_facebook = 0xf09a,
    FA_github = 0xf09b,
    FA_unlock = 0xf09c,
    FA_credit_card = 0xf09d,
    FA_feed = 0xf09e,
    FA_rss = 0xf09e,
    FA_hdd_o = 0xf0a0,
    FA_bullhorn = 0xf0a1,
    FA_bell = 0xf0f3,
    FA_certificate = 0xf0a3,
    FA_hand_o_right = 0xf0a4,
    FA_hand_o_left = 0xf0a5,
    FA_hand_o_up = 0xf0a6,
    FA_hand_o_down = 0xf0a7,
    FA_arrow_circle_left = 0xf0a8,
    FA_arrow_circle_right = 0xf0a9,
    FA_arrow_circle_up = 0xf0aa,
    FA_arrow_circle_down = 0xf0ab,
    FA_globe = 0xf0ac,
    FA_wrench = 0xf0ad,
    FA_tasks = 0xf0ae,
    FA_filter = 0xf0b0,
    FA_briefcase = 0xf0b1,
    FA_arrows_alt = 0xf0b2,
    FA_group = 0xf0c0,
    FA_users = 0xf0c0,
    FA_chain = 0xf0c1,
    FA_link = 0xf0c1,
    FA_cloud = 0xf0c2,
    FA_flask = 0xf0c3,
    FA_cut = 0xf0c4,
    FA_scissors = 0xf0c4,
    FA_copy = 0xf0c5,
    FA_files_o = 0xf0c5,
    FA_paperclip = 0xf0c6,
    FA_save = 0xf0c7,
    FA_floppy_o = 0xf0c7,
    FA_square = 0xf0c8,
    FA_navicon = 0xf0c9,
    FA_reorder = 0xf0c9,
    FA_bars = 0xf0c9,
    FA_list_ul = 0xf0ca,
    FA_list_ol = 0xf0cb,
    FA_strikethrough = 0xf0cc,
    FA_underline = 0xf0cd,
    FA_table = 0xf0ce,
    FA_magic = 0xf0d0,
    FA_truck = 0xf0d1,
    FA_pinterest = 0xf0d2,
    FA_pinterest_square = 0xf0d3,
    FA_google_plus_square = 0xf0d4,
    FA_google_plus = 0xf0d5,
    FA_money = 0xf0d6,
    FA_caret_down = 0xf0d7,
    FA_caret_up = 0xf0d8,
    FA_caret_left = 0xf0d9,
    FA_caret_right = 0xf0da,
    FA_columns = 0xf0db,
    FA_unsorted = 0xf0dc,
    FA_sort = 0xf0dc,
    FA_sort_down = 0xf0dd,
    FA_sort_desc = 0xf0dd,
    FA_sort_up = 0xf0de,
    FA_sort_asc = 0xf0de,
    FA_envelope = 0xf0e0,
    FA_linkedin = 0xf0e1,
    FA_rotate_left = 0xf0e2,
    FA_undo = 0xf0e2,
    FA_legal = 0xf0e3,
    FA_gavel = 0xf0e3,
    FA_dashboard = 0xf0e4,
    FA_tachometer = 0xf0e4,
    FA_comment_o = 0xf0e5,
    FA_comments_o = 0xf0e6,
    FA_flash = 0xf0e7,
    FA_bolt = 0xf0e7,
    FA_sitemap = 0xf0e8,
    FA_umbrella = 0xf0e9,
    FA_paste = 0xf0ea,
    FA_clipboard = 0xf0ea,
    FA_lightbulb_o = 0xf0eb,
    FA_exchange = 0xf0ec,
    FA_cloud_download = 0xf0ed,
    FA_cloud_upload = 0xf0ee,
    FA_user_md = 0xf0f0,
    FA_stethoscope = 0xf0f1,
    FA_suitcase = 0xf0f2,
    FA_bell_o = 0xf0a2,
    FA_coffee = 0xf0f4,
    FA_cutlery = 0xf0f5,
    FA_file_text_o = 0xf0f6,
    FA_building_o = 0xf0f7,
    FA_hospital_o = 0xf0f8,
    FA_ambulance = 0xf0f9,
    FA_medkit = 0xf0fa,
    FA_fighter_jet = 0xf0fb,
    FA_beer = 0xf0fc,
    FA_h_square = 0xf0fd,
    FA_plus_square = 0xf0fe,
    FA_angle_double_left = 0xf100,
    FA_angle_double_right = 0xf101,
    FA_angle_double_up = 0xf102,
    FA_angle_double_down = 0xf103,
    FA_angle_left = 0xf104,
    FA_angle_right = 0xf105,
    FA_angle_up = 0xf106,
    FA_angle_down = 0xf107,
    FA_desktop = 0xf108,
    FA_laptop = 0xf109,
    FA_tablet = 0xf10a,
    FA_mobile_phone = 0xf10b,
    FA_mobile = 0xf10b,
    FA_circle_o = 0xf10c,
    FA_quote_left = 0xf10d,
    FA_quote_right = 0xf10e,
    FA_spinner = 0xf110,
    FA_circle = 0xf111,
    FA_mail_reply = 0xf112,
    FA_reply = 0xf112,
    FA_github_alt = 0xf113,
    FA_folder_o = 0xf114,
    FA_folder_open_o = 0xf115,
    FA_smile_o = 0xf118,
    FA_frown_o = 0xf119,
    FA_meh_o = 0xf11a,
    FA_gamepad = 0xf11b,
    FA_keyboard_o = 0xf11c,
    FA_flag_o = 0xf11d,
    FA_flag_checkered = 0xf11e,
    FA_terminal = 0xf120,
    FA_code = 0xf121,
    FA_mail_reply_all = 0xf122,
    FA_reply_all = 0xf122,
    FA_star_half_empty = 0xf123,
    FA_star_half_full = 0xf123,
    FA_star_half_o = 0xf123,
    FA_location_arrow = 0xf124,
    FA_crop = 0xf125,
    FA_code_fork = 0xf126,
    FA_unlink = 0xf127,
    FA_chain_broken = 0xf127,
    FA_question = 0xf128,
    FA_info = 0xf129,
    FA_exclamation = 0xf12a,
    FA_superscript = 0xf12b,
    FA_subscript = 0xf12c,
    FA_eraser = 0xf12d,
    FA_puzzle_piece = 0xf12e,
    FA_microphone = 0xf130,
    FA_microphone_slash = 0xf131,
    FA_shield = 0xf132,
    FA_calendar_o = 0xf133,
    FA_fire_extinguisher = 0xf134,
    FA_rocket = 0xf135,
    FA_maxcdn = 0xf136,
    FA_chevron_circle_left = 0xf137,
    FA_chevron_circle_right = 0xf138,
    FA_chevron_circle_up = 0xf139,
    FA_chevron_circle_down = 0xf13a,
    FA_html5 = 0xf13b,
    FA_css3 = 0xf13c,
    FA_anchor = 0xf13d,
    FA_unlock_alt = 0xf13e,
    FA_bullseye = 0xf140,
    FA_ellipsis_h = 0xf141,
    FA_ellipsis_v = 0xf142,
    FA_rss_square = 0xf143,
    FA_play_circle = 0xf144,
    FA_ticket = 0xf145,
    FA_minus_square = 0xf146,
    FA_minus_square_o = 0xf147,
    FA_level_up = 0xf148,
    FA_level_down = 0xf149,
    FA_check_square = 0xf14a,
    FA_pencil_square = 0xf14b,
    FA_external_link_square = 0xf14c,
    FA_share_square = 0xf14d,
    FA_compass = 0xf14e,
    FA_toggle_down = 0xf150,
    FA_caret_square_o_down = 0xf150,
    FA_toggle_up = 0xf151,
    FA_caret_square_o_up = 0xf151,
    FA_toggle_right = 0xf152,
    FA_caret_square_o_right = 0xf152,
    FA_euro = 0xf153,
    FA_eur = 0xf153,
    FA_gbp = 0xf154,
    FA_dollar = 0xf155,
    FA_usd = 0xf155,
    FA_rupee = 0xf156,
    FA_inr = 0xf156,
    FA_cny = 0xf157,
    FA_rmb = 0xf157,
    FA_yen = 0xf157,
    FA_jpy = 0xf157,
    FA_ruble = 0xf158,
    FA_rouble = 0xf158,
    FA_rub = 0xf158,
    FA_won = 0xf159,
    FA_krw = 0xf159,
    FA_bitcoin = 0xf15a,
    FA_btc = 0xf15a,
    FA_file = 0xf15b,
    FA_file_text = 0xf15c,
    FA_sort_alpha_asc = 0xf15d,
    FA_sort_alpha_desc = 0xf15e,
    FA_sort_amount_asc = 0xf160,
    FA_sort_amount_desc = 0xf161,
    FA_sort_numeric_asc = 0xf162,
    FA_sort_numeric_desc = 0xf163,
    FA_thumbs_up = 0xf164,
    FA_thumbs_down = 0xf165,
    FA_youtube_square = 0xf166,
    FA_youtube = 0xf167,
    FA_xing = 0xf168,
    FA_xing_square = 0xf169,
    FA_youtube_play = 0xf16a,
    FA_dropbox = 0xf16b,
    FA_stack_overflow = 0xf16c,
    FA_instagram = 0xf16d,
    FA_flickr = 0xf16e,
    FA_adn = 0xf170,
    FA_bitbucket = 0xf171,
    FA_bitbucket_square = 0xf172,
    FA_tumblr = 0xf173,
    FA_tumblr_square = 0xf174,
    FA_long_arrow_down = 0xf175,
    FA_long_arrow_up = 0xf176,
    FA_long_arrow_left = 0xf177,
    FA_long_arrow_right = 0xf178,
    FA_apple = 0xf179,
    FA_windows = 0xf17a,
    FA_android = 0xf17b,
    FA_linux = 0xf17c,
    FA_dribbble = 0xf17d,
    FA_skype = 0xf17e,
    FA_foursquare = 0xf180,
    FA_trello = 0xf181,
    FA_female = 0xf182,
    FA_male = 0xf183,
    FA_gittip = 0xf184,
    FA_gratipay = 0xf184,
    FA_sun_o = 0xf185,
    FA_moon_o = 0xf186,
    FA_archive = 0xf187,
    FA_bug = 0xf188,
    FA_vk = 0xf189,
    FA_weibo = 0xf18a,
    FA_renren = 0xf18b,
    FA_pagelines = 0xf18c,
    FA_stack_exchange = 0xf18d,
    FA_arrow_circle_o_right = 0xf18e,
    FA_arrow_circle_o_left = 0xf190,
    FA_toggle_left = 0xf191,
    FA_caret_square_o_left = 0xf191,
    FA_dot_circle_o = 0xf192,
    FA_wheelchair = 0xf193,
    FA_vimeo_square = 0xf194,
    FA_turkish_lira = 0xf195,
    FA_try = 0xf195,
    FA_plus_square_o = 0xf196,
    FA_space_shuttle = 0xf197,
    FA_slack = 0xf198,
    FA_envelope_square = 0xf199,
    FA_wordpress = 0xf19a,
    FA_openid = 0xf19b,
    FA_institution = 0xf19c,
    FA_bank = 0xf19c,
    FA_university = 0xf19c,
    FA_mortar_board = 0xf19d,
    FA_graduation_cap = 0xf19d,
    FA_yahoo = 0xf19e,
    FA_google = 0xf1a0,
    FA_reddit = 0xf1a1,
    FA_reddit_square = 0xf1a2,
    FA_stumbleupon_circle = 0xf1a3,
    FA_stumbleupon = 0xf1a4,
    FA_delicious = 0xf1a5,
    FA_digg = 0xf1a6,
    FA_pied_piper_pp = 0xf1a7,
    FA_pied_piper_alt = 0xf1a8,
    FA_drupal = 0xf1a9,
    FA_joomla = 0xf1aa,
    FA_language = 0xf1ab,
    FA_fax = 0xf1ac,
    FA_building = 0xf1ad,
    FA_child = 0xf1ae,
    FA_paw = 0xf1b0,
    FA_spoon = 0xf1b1,
    FA_cube = 0xf1b2,
    FA_cubes = 0xf1b3,
    FA_behance = 0xf1b4,
    FA_behance_square = 0xf1b5,
    FA_steam = 0xf1b6,
    FA_steam_square = 0xf1b7,
    FA_recycle = 0xf1b8,
    FA_automobile = 0xf1b9,
    FA_car = 0xf1b9,
    FA_cab = 0xf1ba,
    FA_taxi = 0xf1ba,
    FA_tree = 0xf1bb,
    FA_spotify = 0xf1bc,
    FA_deviantart = 0xf1bd,
    FA_soundcloud = 0xf1be,
    FA_database = 0xf1c0,
    FA_file_pdf_o = 0xf1c1,
    FA_file_word_o = 0xf1c2,
    FA_file_excel_o = 0xf1c3,
    FA_file_powerpoint_o = 0xf1c4,
    FA_file_photo_o = 0xf1c5,
    FA_file_picture_o = 0xf1c5,
    FA_file_image_o = 0xf1c5,
    FA_file_zip_o = 0xf1c6,
    FA_file_archive_o = 0xf1c6,
    FA_file_sound_o = 0xf1c7,
    FA_file_audio_o = 0xf1c7,
    FA_file_movie_o = 0xf1c8,
    FA_file_video_o = 0xf1c8,
    FA_file_code_o = 0xf1c9,
    FA_vine = 0xf1ca,
    FA_codepen = 0xf1cb,
    FA_jsfiddle = 0xf1cc,
    FA_life_bouy = 0xf1cd,
    FA_life_buoy = 0xf1cd,
    FA_life_saver = 0xf1cd,
    FA_support = 0xf1cd,
    FA_life_ring = 0xf1cd,
    FA_circle_o_notch = 0xf1ce,
    FA_ra = 0xf1d0,
    FA_resistance = 0xf1d0,
    FA_rebel = 0xf1d0,
    FA_ge = 0xf1d1,
    FA_empire = 0xf1d1,
    FA_git_square = 0xf1d2,
    FA_git = 0xf1d3,
    FA_y_combinator_square = 0xf1d4,
    FA_yc_square = 0xf1d4,
    FA_hacker_news = 0xf1d4,
    FA_tencent_weibo = 0xf1d5,
    FA_qq = 0xf1d6,
    FA_wechat = 0xf1d7,
    FA_weixin = 0xf1d7,
    FA_send = 0xf1d8,
    FA_paper_plane = 0xf1d8,
    FA_send_o = 0xf1d9,
    FA_paper_plane_o = 0xf1d9,
    FA_history = 0xf1da,
    FA_circle_thin = 0xf1db,
    FA_header = 0xf1dc,
    FA_paragraph = 0xf1dd,
    FA_sliders = 0xf1de,
    FA_share_alt = 0xf1e0,
    FA_share_alt_square = 0xf1e1,
    FA_bomb = 0xf1e2,
    FA_soccer_ball_o = 0xf1e3,
    FA_futbol_o = 0xf1e3,
    FA_tty = 0xf1e4,
    FA_binoculars = 0xf1e5,
    FA_plug = 0xf1e6,
    FA_slideshare = 0xf1e7,
    FA_twitch = 0xf1e8,
    FA_yelp = 0xf1e9,
    FA_newspaper_o = 0xf1ea,
    FA_wifi = 0xf1eb,
    FA_calculator = 0xf1ec,
    FA_paypal = 0xf1ed,
    FA_google_wallet = 0xf1ee,
    FA_cc_visa = 0xf1f0,
    FA_cc_mastercard = 0xf1f1,
    FA_cc_discover = 0xf1f2,
    FA_cc_amex = 0xf1f3,
    FA_cc_paypal = 0xf1f4,
    FA_cc_stripe = 0xf1f5,
    FA_bell_slash = 0xf1f6,
    FA_bell_slash_o = 0xf1f7,
    FA_trash = 0xf1f8,
    FA_copyright = 0xf1f9,
    FA_at = 0xf1fa,
    FA_eyedropper = 0xf1fb,
    FA_paint_brush = 0xf1fc,
    FA_birthday_cake = 0xf1fd,
    FA_area_chart = 0xf1fe,
    FA_pie_chart = 0xf200,
    FA_line_chart = 0xf201,
    FA_lastfm = 0xf202,
    FA_lastfm_square = 0xf203,
    FA_toggle_off = 0xf204,
    FA_toggle_on = 0xf205,
    FA_bicycle = 0xf206,
    FA_bus = 0xf207,
    FA_ioxhost = 0xf208,
    FA_angellist = 0xf209,
    FA_cc = 0xf20a,
    FA_shekel = 0xf20b,
    FA_sheqel = 0xf20b,
    FA_ils = 0xf20b,
    FA_meanpath = 0xf20c,
    FA_buysellads = 0xf20d,
    FA_connectdevelop = 0xf20e,
    FA_dashcube = 0xf210,
    FA_forumbee = 0xf211,
    FA_leanpub = 0xf212,
    FA_sellsy = 0xf213,
    FA_shirtsinbulk = 0xf214,
    FA_simplybuilt = 0xf215,
    FA_skyatlas = 0xf216,
    FA_cart_plus = 0xf217,
    FA_cart_arrow_down = 0xf218,
    FA_diamond = 0xf219,
    FA_ship = 0xf21a,
    FA_user_secret = 0xf21b,
    FA_motorcycle = 0xf21c,
    FA_street_view = 0xf21d,
    FA_heartbeat = 0xf21e,
    FA_venus = 0xf221,
    FA_mars = 0xf222,
    FA_mercury = 0xf223,
    FA_intersex = 0xf224,
    FA_transgender = 0xf224,
    FA_transgender_alt = 0xf225,
    FA_venus_double = 0xf226,
    FA_mars_double = 0xf227,
    FA_venus_mars = 0xf228,
    FA_mars_stroke = 0xf229,
    FA_mars_stroke_v = 0xf22a,
    FA_mars_stroke_h = 0xf22b,
    FA_neuter = 0xf22c,
    FA_genderless = 0xf22d,
    FA_facebook_official = 0xf230,
    FA_pinterest_p = 0xf231,
    FA_whatsapp = 0xf232,
    FA_server = 0xf233,
    FA_user_plus = 0xf234,
    FA_user_times = 0xf235,
    FA_hotel = 0xf236,
    FA_bed = 0xf236,
    FA_viacoin = 0xf237,
    FA_train = 0xf238,
    FA_subway = 0xf239,
    FA_medium = 0xf23a,
    FA_yc = 0xf23b,
    FA_y_combinator = 0xf23b,
    FA_optin_monster = 0xf23c,
    FA_opencart = 0xf23d,
    FA_expeditedssl = 0xf23e,
    FA_battery_4 = 0xf240,
    FA_battery = 0xf240,
    FA_battery_full = 0xf240,
    FA_battery_3 = 0xf241,
    FA_battery_three_quarters = 0xf241,
    FA_battery_2 = 0xf242,
    FA_battery_half = 0xf242,
    FA_battery_1 = 0xf243,
    FA_battery_quarter = 0xf243,
    FA_battery_0 = 0xf244,
    FA_battery_empty = 0xf244,
    FA_mouse_pointer = 0xf245,
    FA_i_cursor = 0xf246,
    FA_object_group = 0xf247,
    FA_object_ungroup = 0xf248,
    FA_sticky_note = 0xf249,
    FA_sticky_note_o = 0xf24a,
    FA_cc_jcb = 0xf24b,
    FA_cc_diners_club = 0xf24c,
    FA_clone = 0xf24d,
    FA_balance_scale = 0xf24e,
    FA_hourglass_o = 0xf250,
    FA_hourglass_1 = 0xf251,
    FA_hourglass_start = 0xf251,
    FA_hourglass_2 = 0xf252,
    FA_hourglass_half = 0xf252,
    FA_hourglass_3 = 0xf253,
    FA_hourglass_end = 0xf253,
    FA_hourglass = 0xf254,
    FA_hand_grab_o = 0xf255,
    FA_hand_rock_o = 0xf255,
    FA_hand_stop_o = 0xf256,
    FA_hand_paper_o = 0xf256,
    FA_hand_scissors_o = 0xf257,
    FA_hand_lizard_o = 0xf258,
    FA_hand_spock_o = 0xf259,
    FA_hand_pointer_o = 0xf25a,
    FA_hand_peace_o = 0xf25b,
    FA_trademark = 0xf25c,
    FA_registered = 0xf25d,
    FA_creative_commons = 0xf25e,
    FA_gg = 0xf260,
    FA_gg_circle = 0xf261,
    FA_tripadvisor = 0xf262,
    FA_odnoklassniki = 0xf263,
    FA_odnoklassniki_square = 0xf264,
    FA_get_pocket = 0xf265,
    FA_wikipedia_w = 0xf266,
    FA_safari = 0xf267,
    FA_chrome = 0xf268,
    FA_firefox = 0xf269,
    FA_opera = 0xf26a,
    FA_internet_explorer = 0xf26b,
    FA_tv = 0xf26c,
    FA_television = 0xf26c,
    FA_contao = 0xf26d,
    FA_amazon = 0xf270,
    FA_calendar_plus_o = 0xf271,
    FA_calendar_minus_o = 0xf272,
    FA_calendar_times_o = 0xf273,
    FA_calendar_check_o = 0xf274,
    FA_industry = 0xf275,
    FA_map_pin = 0xf276,
    FA_map_signs = 0xf277,
    FA_map_o = 0xf278,
    FA_map = 0xf279,
    FA_commenting = 0xf27a,
    FA_commenting_o = 0xf27b,
    FA_houzz = 0xf27c,
    FA_vimeo = 0xf27d,
    FA_black_tie = 0xf27e,
    FA_fonticons = 0xf280,
    FA_reddit_alien = 0xf281,
    FA_edge = 0xf282,
    FA_credit_card_alt = 0xf283,
    FA_codiepie = 0xf284,
    FA_modx = 0xf285,
    FA_fort_awesome = 0xf286,
    FA_usb = 0xf287,
    FA_product_hunt = 0xf288,
    FA_mixcloud = 0xf289,
    FA_scribd = 0xf28a,
    FA_pause_circle = 0xf28b,
    FA_pause_circle_o = 0xf28c,
    FA_stop_circle = 0xf28d,
    FA_stop_circle_o = 0xf28e,
    FA_shopping_bag = 0xf290,
    FA_shopping_basket = 0xf291,
    FA_hashtag = 0xf292,
    FA_bluetooth = 0xf293,
    FA_bluetooth_b = 0xf294,
    FA_percent = 0xf295,
    FA_gitlab = 0xf296,
    FA_wpbeginner = 0xf297,
    FA_wpforms = 0xf298,
    FA_envira = 0xf299,
    FA_universal_access = 0xf29a,
    FA_wheelchair_alt = 0xf29b,
    FA_question_circle_o = 0xf29c,
    FA_blind = 0xf29d,
    FA_audio_description = 0xf29e,
    FA_volume_control_phone = 0xf2a0,
    FA_braille = 0xf2a1,
    FA_assistive_listening_systems = 0xf2a2,
    FA_asl_interpreting = 0xf2a3,
    FA_american_sign_language_interpreting = 0xf2a3,
    FA_deafness = 0xf2a4,
    FA_hard_of_hearing = 0xf2a4,
    FA_deaf = 0xf2a4,
    FA_glide = 0xf2a5,
    FA_glide_g = 0xf2a6,
    FA_signing = 0xf2a7,
    FA_sign_language = 0xf2a7,
    FA_low_vision = 0xf2a8,
    FA_viadeo = 0xf2a9,
    FA_viadeo_square = 0xf2aa,
    FA_snapchat = 0xf2ab,
    FA_snapchat_ghost = 0xf2ac,
    FA_snapchat_square = 0xf2ad,
    FA_pied_piper = 0xf2ae,
    FA_first_order = 0xf2b0,
    FA_yoast = 0xf2b1,
    FA_themeisle = 0xf2b2,
    FA_google_plus_circle = 0xf2b3,
    FA_google_plus_official = 0xf2b3,
    FA_fa = 0xf2b4,
    FA_font_awesome = 0xf2b4,
    FA_handshake_o = 0xf2b5,
    FA_envelope_open = 0xf2b6,
    FA_envelope_open_o = 0xf2b7,
    FA_linode = 0xf2b8,
    FA_address_book = 0xf2b9,
    FA_address_book_o = 0xf2ba,
    FA_vcard = 0xf2bb,
    FA_address_card = 0xf2bb,
    FA_vcard_o = 0xf2bc,
    FA_address_card_o = 0xf2bc,
    FA_user_circle = 0xf2bd,
    FA_user_circle_o = 0xf2be,
    FA_user_o = 0xf2c0,
    FA_id_badge = 0xf2c1,
    FA_drivers_license = 0xf2c2,
    FA_id_card = 0xf2c2,
    FA_drivers_license_o = 0xf2c3,
    FA_id_card_o = 0xf2c3,
    FA_quora = 0xf2c4,
    FA_free_code_camp = 0xf2c5,
    FA_telegram = 0xf2c6,
    FA_thermometer_4 = 0xf2c7,
    FA_thermometer = 0xf2c7,
    FA_thermometer_full = 0xf2c7,
    FA_thermometer_3 = 0xf2c8,
    FA_thermometer_three_quarters = 0xf2c8,
    FA_thermometer_2 = 0xf2c9,
    FA_thermometer_half = 0xf2c9,
    FA_thermometer_1 = 0xf2ca,
    FA_thermometer_quarter = 0xf2ca,
    FA_thermometer_0 = 0xf2cb,
    FA_thermometer_empty = 0xf2cb,
    FA_shower = 0xf2cc,
    FA_bathtub = 0xf2cd,
    FA_s15 = 0xf2cd,
    FA_bath = 0xf2cd,
    FA_podcast = 0xf2ce,
    FA_window_maximize = 0xf2d0,
    FA_window_minimize = 0xf2d1,
    FA_window_restore = 0xf2d2,
    FA_times_rectangle = 0xf2d3,
    FA_window_close = 0xf2d3,
    FA_times_rectangle_o = 0xf2d4,
    FA_window_close_o = 0xf2d4,
    FA_bandcamp = 0xf2d5,
    FA_grav = 0xf2d6,
    FA_etsy = 0xf2d7,
    FA_imdb = 0xf2d8,
    FA_ravelry = 0xf2d9,
    FA_eercast = 0xf2da,
    FA_microchip = 0xf2db,
    FA_snowflake_o = 0xf2dc,
    FA_superpowers = 0xf2dd,
    FA_wpexplorer = 0xf2de,
    FA_meetup = 0xf2e0
};
Q_ENUMS(TQuickAwesomeType)
}

#endif // TQUICKGLOBAL_H

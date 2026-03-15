<script setup lang="ts">
import { Head, Link, usePage } from '@inertiajs/vue3';
import { ref, onMounted, onUnmounted, computed } from 'vue';

interface LandingImage {
    id: number;
    section: string;
    title: string | null;
    description: string | null;
    image_url: string;
    sort_order: number;
    is_active: boolean;
    event_type: string | null;
}

const props = withDefaults(
    defineProps<{
        canRegister: boolean;
        heroImages?: LandingImage[];
        eventTypes?: LandingImage[];
        galleryImages?: LandingImage[];
    }>(),
    {
        canRegister: true,
        heroImages: () => [],
        eventTypes: () => [],
        galleryImages: () => [],
    },
);

const eventImages = computed(() => props.heroImages || []);
const showModal = ref(false);
const selectedEventType = ref<string | null>(null);
const activeHeroSlide = ref(0);
let heroSlideInterval: number | null = null;
const page = usePage<{
    flash?: {
        success?: string;
        error?: string;
        receipt?: {
            number?: string;
            url?: string;
        };
    };
}>();
const flashSuccess = computed(() => page.props.flash?.success || '');
const flashError = computed(() => page.props.flash?.error || '');
const flashReceipt = computed(() => page.props.flash?.receipt || null);

// Gallery images for each event type
const birthdayImages = [
    'https://scontent.fmnl3-3.fna.fbcdn.net/v/t39.30808-6/593597460_707971052384219_6491328660644942059_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeF_gYZZyZfENLMKeT9O8EuodYBmKb0CSwB1gGYpvQJLAB2VOLPWDxWAePOSeJOw2MCMvK9GQHWRrNjj_cvMWnri&_nc_ohc=PDlvKrLnWLYQ7kNvwGx8gLu&_nc_oc=AdluZ4MvpEwDjix8JV46xpmt0w0uNmZk_4sy-Gf3Chwq5aMlUDpyFenuvjL6GRbMobo&_nc_zt=23&_nc_ht=scontent.fmnl3-3.fna&_nc_gid=rhiMQfAwuBLIYJXix-T9xQ&oh=00_AfkeZ2PhgFyxikXc3dwkBgkBwoiIw0XMCZYY2mrxDjNVHg&oe=693761F6',
    'https://scontent.fmnl3-1.fna.fbcdn.net/v/t39.30808-6/592324553_707970939050897_7541427964929990478_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeFgoTxWzC_Imcd8PjFUuPuiVCRF60el599UJEXrR6Xn36nUEuZ5q6WlkdXmH22ESRZu3smsi4bgBYPmXRihkjs8&_nc_ohc=zDSrqKlpBksQ7kNvwGuuxt-&_nc_oc=AdmYgtZe-yaAYFpAEsi3hrXhVTjw5xPtcVxGE72czJ2AOXWOve3qrQiWuHnCqTbO23o&_nc_zt=23&_nc_ht=scontent.fmnl3-1.fna&_nc_gid=sNBl2KIjcEnxhPIWgt1ojQ&oh=00_AflJdLTypaFTWbRlkbXSMZ6rktRXJbr25FzmKLLVh3i2gQ&oe=69377A10',
    'https://scontent.fmnl37-2.fna.fbcdn.net/v/t39.30808-6/593890200_707970915717566_5694920761750409906_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeFGEUniTRtUm8jV6grd_qeHCPl2f9l5EkYI-XZ_2XkSRrL4xY7Wz0SwcaN4U1iwnWxgFKoNjQlKLEzmg9NRtALE&_nc_ohc=kJ6a4QGmpkIQ7kNvwGRYBcM&_nc_oc=Adk5tBcxtdQvV5vt2TU5cxPLKPZEH6R3XH0z4FYwCjtNs0_bIDQva7zd1_6IIvUAwzc&_nc_zt=23&_nc_ht=scontent.fmnl37-2.fna&_nc_gid=JXZoFiT6Ogm4lnuq1QuWBA&oh=00_AfmslRVkT6QaGQsKrqpf5sRJsiww1XsffXBNPOreZ223HQ&oe=69376E12',
    'https://scontent.fmnl37-1.fna.fbcdn.net/v/t39.30808-6/593925789_707970862384238_624442582400828828_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeFnYg7pu6vRLEDtbzW6Cs3WQXPkvwsxHKBBc-S_CzEcoDtwNrA2zQZur-BiMKuer0K_VPjCv4__3_kjZMZpHvAT&_nc_ohc=W8X-iEN5wecQ7kNvwE33XGb&_nc_oc=AdnK3xW8t-LFT_o1lWOhb0izYQULMm6dKUVhkAmgxq_6mAPBMezCwb9XgAPKj0Ipp_8&_nc_zt=23&_nc_ht=scontent.fmnl37-1.fna&_nc_gid=5s0ZZAhS0fpmvGv7yK619Q&oh=00_AflvfDexD-O193Nftyz4QLcKMOeyQM3Qk3mOlobIv1T6Fw&oe=69376849',
    'https://scontent.fmnl3-1.fna.fbcdn.net/v/t39.30808-6/594294016_707970839050907_1009224423709395265_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeFHutRIyHChZXaaUmUja4GQfZMrOrk3pX99kys6uTelf3Id7V2FSH0GYgQtqktqdI1ljBA5NuTlDlrroiocUOoO&_nc_ohc=M5fy4nhN6X8Q7kNvwF-GNXo&_nc_oc=Adkr4eacNDJD5zwqvGJa4OkrjtYoxgJXXBDlzS_eJo9iO3MwRk05C36qIbOFV24T1s8&_nc_zt=23&_nc_ht=scontent.fmnl3-1.fna&_nc_gid=84J52en8Vd60g_2ewfYbug&oh=00_Afl-wWaf86X4FWzGQwTXygOVIoTPrR6XMsBjzC1TjH8DTQ&oe=69376C9D',
    'https://scontent.fmnl3-2.fna.fbcdn.net/v/t39.30808-6/593810295_707970822384242_5406146985306565200_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeEIDihT9ZuQfL6Wz5e9oDrzWQU_7PnvRflZBT_s-e9F-dva5Xs-VCoIb-U97Fxui6UXO5Tuo0l5cUuCdcows6Bm&_nc_ohc=3CRW0TgAVG0Q7kNvwHiz0No&_nc_oc=AdlURh6h-Y--JCdF4k-ojoSf0YjUYdC8oRq2-HJFNyAQXutShA4KUJzXoZxo0h8T3gw&_nc_zt=23&_nc_ht=scontent.fmnl3-2.fna&_nc_gid=Ccd0mj9ML8e0ipasIFESXA&oh=00_AfmKHcauA9A5FX-85cvJCjE2OOJkdUmF0IH9T2b4HOidSQ&oe=69376D80',
    'https://scontent.fmnl3-2.fna.fbcdn.net/v/t39.30808-6/592372059_707969492384375_2844507763053891596_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeGFkx-GscL44xncdkRl4iTPniOSCsKxp9KeI5IKwrGn0oVfLbVYRmhXxEHSYyKqD5ZrOUu_KHAr0OZD3flQPeUX&_nc_ohc=9T8hJC4ZWI8Q7kNvwEeBVNe&_nc_oc=Adnwfe9yX_sLMz-extGcOlwLoyVOVBs3TOtoe6CQHnoNxk1MPZpyIrlQ0u7Z0I0KCGM&_nc_zt=23&_nc_ht=scontent.fmnl3-2.fna&_nc_gid=cqqGP_Mc-Voy5l_4Pxn07A&oh=00_AfkxCyLKLsg_cVHRgd2HXvM1nfmoNYoU7dbGrWkVKWR_tw&oe=6937665E',
    'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/539565715_626640830517242_5149035476530240583_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeHV4E1eler3lQdnAc3wJuS5hTdNDK09QxGFN00MrT1DESzGz8kNQ8fA1kTnEY5JbURog5QhnTJE8ynW7LpmlzIE&_nc_ohc=xbWbL67KzcEQ7kNvwELMvVn&_nc_oc=AdnuwueRCpL5boIODpsrVMJp5yOvt-_OtgV0G_3eMcsITyZIGojndyIQxmWPa7BanFs&_nc_zt=23&_nc_ht=scontent.fmnl4-7.fna&_nc_gid=SXnwhFv9KC1xT7qiYcky9g&oh=00_Afl6k-5N6nUIzcYGX0kIYVOTCcLXdHT9rxTXf43rsw6N4g&oe=6939A984',
'https://scontent.fmnl4-3.fna.fbcdn.net/v/t39.30808-6/538186956_624967527351239_6948197561752104094_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeEsG_JpmEvrlUad2RFRjTTWlseySwFnGNeWx7JLAWcY1x8c7AHho5vMr5eued3iz3hSp9dx0CKBPrwugU54yBTL&_nc_ohc=ZrtFzjbSsGoQ7kNvwEmV9pY&_nc_oc=AdmevX-wEyWJhcv3yQUH7QFAkYVUs1iUbWUohFrieeZSIArIG7Xzqqg17uI43UBmU1U&_nc_zt=23&_nc_ht=scontent.fmnl4-3.fna&_nc_gid=-QKglnc3legkDMKhP_2y_Q&oh=00_AfkYWSBamy9MUHjjULC5BKSlKMNdXRmI1hBgKUtjdut5NQ&oe=6939AF98',
'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/539933210_626642227183769_5544793474364962250_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeEF_LVTV3AoD4FmuMYeZFIa_FfC-FJbehf8V8L4Ult6F9ONwFwfab3Mu8lEW36CfKIxS4lItvqWUS8nxFJUKNvL&_nc_ohc=BC_pPl6o5YwQ7kNvwG6D9lY&_nc_oc=Adl0kJ1ivDS1UJZipTz7maIP_ma3vyhCR7wObrsdIomnlsgFR8ZnSPsiojAc3X0X-Pg&_nc_zt=23&_nc_ht=scontent.fmnl4-2.fna&_nc_gid=opTUal8UcoXTEFk1HDfsyw&oh=00_AfmNbekDKFHWGPbTeXcgxJMjmfJpvgm--gOa4q6caQ3GSg&oe=69399413',
'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/538380132_626642753850383_917290920511535895_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeG2Q3Zdo9D6jsPEsW5HXxWtYVjbEqq_u3BhWNsSqr-7cITTcCc36ZGTfuTOid89HjlDJGbp16IDGNRn_lcJDLUM&_nc_ohc=DYy_KhmmqkoQ7kNvwHOsc4L&_nc_oc=AdnBOmsYTSqiFMfQ_79A63--KyBr_9aORUEesS-OcA50eBetb-v2BOR01d1MZ-yY81A&_nc_zt=23&_nc_ht=scontent.fmnl4-7.fna&_nc_gid=sCY9ohVefbfA8P_fcmQsQg&oh=00_AfmQsrYLThnLtWbps9v3su6GHlrroNXE5vA9JVVmWvitmA&oe=6939A3A3',
'https://scontent.fmnl4-1.fna.fbcdn.net/v/t39.30808-6/518277919_592094223971903_5919806890594963748_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeFXL6ecN5VYmq6D2b95g4gChOND7hWK0MWE40PuFYrQxWBcx1gtWjyj0BsCD7FHzHtcByv55_PgCeQe0_dTmkGM&_nc_ohc=nICV5L8QXtUQ7kNvwF1T7Ie&_nc_oc=AdleGMJn3ITYIZaY9m5Po2MeoCfUklipy1CyXi7wkv9gFSjcrb-DVOzXRZK6XLwxBlE&_nc_zt=23&_nc_ht=scontent.fmnl4-1.fna&_nc_gid=ra-L7hNPtn0spUs2Zv1aIQ&oh=00_Afk_fL1nSdWL79e_NRbjtxVtavCcZHvBHU8zduGro6_FRw&oe=6939B4AB',
'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/518337327_592094150638577_571136157081392729_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeEugqAu8rHmF2QhGS2t8IYofp6qcQGylVZ-nqpxAbKVVml4ABpw7HYgYwhWEX0_l7zgVndBcanCZY54gCUmL1yo&_nc_ohc=ZL5C3CyHEb8Q7kNvwHCwlKR&_nc_oc=AdmEdNZWN__0iiQMxQvdQSgq5Ut9o2hsYE3yNzXfKp_0uKRNFTS1TQk6Wh7vvtIJTeE&_nc_zt=23&_nc_ht=scontent.fmnl4-2.fna&_nc_gid=CuT63n1FkiED3vwPy-LS5g&oh=00_AfmWnecB7C_Sj3TFiJjTvjeidHFXx1l-O1oG-Rdprrmuhw&oe=6939C924',
'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/518296472_592094073971918_3351476805610873176_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeGEANUQ0g13zPK0kPpMmtu1iBBcfAvYvlKIEFx8C9i-UrsAxnCgd0PzqGvQdPcTqHn1cmHUXUTyqh6WedEX40Pv&_nc_ohc=fxV6gZCAPOwQ7kNvwF-bRaA&_nc_oc=AdkhpvuOosKYV0OzRQsXm2cpfw7oLJm43KPYVEKTKRYDAHf_9PqmKXWpfLwkq4vL1Z0&_nc_zt=23&_nc_ht=scontent.fmnl4-4.fna&_nc_gid=CzYtiWNccT_Wd63idm3bQg&oh=00_Afl8jW-Zpk8zqxDTwt9YJ348LjWNvXEPBs-HWvpwgEWjUA&oe=6939A1B7',
'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/540435127_626642740517051_3770864136422935902_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeEShbiWt27thDm99FMWtXTwvj1rPDYxRzK-PWs8NjFHMlC5D4qv4aDwWW-LvHmAb_RJCTZE7FaR21xxIeK_ilQ_&_nc_ohc=jz4yAP-wouAQ7kNvwE0ai6h&_nc_oc=Admt19lDTD15chjQDmCEeEni0H0AouT4JlCTdei-HzwyHC3ZQc3vZhXBg24LS0IydoQ&_nc_zt=23&_nc_ht=scontent.fmnl4-7.fna&_nc_gid=awPHkHvHNDKo89sPb1a5HA&oh=00_AfmC-PPiviyDAkgfs5fizOBLDfaPyEO4gFguf2VKwjelvA&oe=6939A198',
'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/539532610_626642650517060_4290163856733936743_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeFrzPhwdQmLN6yztk4x7H2e16icWGC-2jLXqJxYYL7aMjaCG7fib7MjcX5plTnTevdm9C4dD4LH4CtFeXRrctFk&_nc_ohc=kkPdws1uNswQ7kNvwEnxHe3&_nc_oc=AdmAmjlE-yV5iRj-PipqcVxJ5edf__4g169k4bKGK5xNXVF1zZ7xWqyHrMJjojIWRBM&_nc_zt=23&_nc_ht=scontent.fmnl4-7.fna&_nc_gid=MwZ61vXdaqomvvc-1JPDmg&oh=00_Afl5kiYg_kBqE-9vTZjLztFqwL21BDXMEEaWc3bJjn3GPg&oe=693999CD',
'https://scontent.fmnl4-3.fna.fbcdn.net/v/t39.30808-6/539603179_626642630517062_7562709880071092462_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeHUIvGogsKjg3gP5vWvxEsiNDZC1_I1Apg0NkLX8jUCmOWneMREPVPJBIHFn-mdpwDkCK2I5jBNmpyFvC45KNWx&_nc_ohc=J65-v5G6t0wQ7kNvwE3nguz&_nc_oc=AdkTCuKASUmWA62yJwY_Ny9cYHA0aZmcYX1xEbbOWI-agFlg_Ou6Ba74fnLewnb7aEY&_nc_zt=23&_nc_ht=scontent.fmnl4-3.fna&_nc_gid=nTUFW0nbnIVxInGdmnWOkQ&oh=00_AfnyOwG-DWb0rST6Cz65FAOAGgE17CjiPB-W35_4Lly8ng&oe=6939B67D',
'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/539608904_626642510517074_2698606547691102118_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeGqnwoA-s7qNVLm7oA_WhFkRi44dohDHF9GLjh2iEMcX7U_07Vx9aaiV79YERpWu113tu--pnH4T-Fd1WoiYFEq&_nc_ohc=drpIwrLUxsEQ7kNvwEUM-xb&_nc_oc=Adl_Y2iYDixkn6vIpxVF2fnoAepADSEALznOEwU2xbEsGGCQ2E2Xe8uMlV68LgHyZms&_nc_zt=23&_nc_ht=scontent.fmnl4-7.fna&_nc_gid=FNX1CiV1EXsv86QtCS6-cw&oh=00_AfmPneKmchvVTv7YrAjl8DwkjBKtrR117SmGpfrQAr-h1w&oe=6939A8B3',
'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/539173148_626642440517081_8651947030216833645_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeFg_a5ptmtT0jHo17G7TbYccIl4gkjTBvxwiXiCSNMG_EfBS6i0NjdMJlcd6VALyvtuxqFcTufpUvmYPHl7dqdz&_nc_ohc=zukaIu1ayCEQ7kNvwG9GyWj&_nc_oc=AdnIkUx__JpwAgyjqjWOvlbJcokbc4f7AdNfN2pQoRtCv2XivHULY3sLR8WjtjEy1O8&_nc_zt=23&_nc_ht=scontent.fmnl4-7.fna&_nc_gid=6nPcuezPFxFQ0INV2Dtjbw&oh=00_AfmW1ekuYaPJraKB7mtcwx5d8wH-7iT36ve0KMBegpreMQ&oe=6939ADD5',
'https://scontent.fmnl4-1.fna.fbcdn.net/v/t39.30808-6/538295942_626642437183748_97394935619845280_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeEdL-N7qY_6fYulJViKMSeVr5eMg4RkzA2vl4yDhGTMDTe4A0-apBj82978-3LYFlbDWZggUsqzX7Er0tBJWrEC&_nc_ohc=RQ0xuLHvOYwQ7kNvwHLQcEy&_nc_oc=Admju1b74o1ScVH9xeqjMv0JHU1W0FivJBXQvGCJY23k6Ze9prHZ9gD7djQHbQJREKU&_nc_zt=23&_nc_ht=scontent.fmnl4-1.fna&_nc_gid=WafXvnD3AtUVbFmEaz8MYg&oh=00_Afk_CVNTAWeBOZExnzrENx0rmFmemRGjSDK5tEyuoR21yQ&oe=6939B2DB',
'https://scontent.fmnl4-1.fna.fbcdn.net/v/t39.30808-6/540589570_626642383850420_9147814804175584750_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeGxZ7Q5XXjmDgUjfRl7WpXpYV9gAvRC_k1hX2AC9EL-TaWWBM_niw7USYKbnENvbD4XmrDnvw3jlYboLTapdi1p&_nc_ohc=0VnF5XJXZXQQ7kNvwEvBAvd&_nc_oc=AdkWtwdNjrQx0cTTNv5ZNfgQTUZt0UPeCCKSTL5bXFBYBNuQ6IDrKbqJB6lLa6Slaho&_nc_zt=23&_nc_ht=scontent.fmnl4-1.fna&_nc_gid=uxL2e8_wxlG-_qUbOFx_DA&oh=00_AflMXIwDLPDoK6bzpW4AgqeUywxOmleKyZV2im5uAz_8Dw&oe=6939B0D2',


    
 
    
];

const weddingImages = [
    'https://scontent.fmnl37-2.fna.fbcdn.net/v/t39.30808-6/594057338_707130325801625_2225830086015596082_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeFaZmfza8tSD3YAQnGc_ECYxsICJl-E7xnGwgImX4TvGdLZxcLPPQ5sxcB52fNQ4UBIBqYa6KnAdeC4vt09h1o2&_nc_ohc=jDjk5y_o4qUQ7kNvwFYnE7w&_nc_oc=AdlfJvn0Ys2vxzbxHo-MmgGJ_SrdBteWjfcyeDriJFJAPc0Tz4aqbpp43OfZF6RmH2c&_nc_zt=23&_nc_ht=scontent.fmnl37-2.fna&_nc_gid=cqqGP_Mc-Voy5l_4Pxn07A&oh=00_AfkDXFs2_eWFlwtdPRmYHtTpy5lVr0g4cdYL-5wE024-LQ&oe=693764DB',
    'https://scontent.fmnl3-4.fna.fbcdn.net/v/t39.30808-6/592283924_707130299134961_7773379418725962126_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeFOD2IOg7oqaE2LsoxeuKyoF1dtj49S5mcXV22Pj1LmZ17S4TmYNtK9Kb2C7dOrDDVPptFFCjH7HzTlqPqvwKRp&_nc_ohc=ZAn8M6KvzJQQ7kNvwEfFZrr&_nc_oc=AdlwmftFlJmtjVFaxmrDhijEow1VKhggwWUsE9QsI3nuR7ozNskUQpLJ--FOclwhKe4&_nc_zt=23&_nc_ht=scontent.fmnl3-4.fna&_nc_gid=8iOkmlNjkRvqAbJJsCCAbw&oh=00_AfmBZxI6OOpPGdd6uGDbpiH05KrOg7gRhyR_pgwTEHrQCQ&oe=69375EC6',
    'https://scontent.fmnl37-2.fna.fbcdn.net/v/t39.30808-6/591379210_707130259134965_4218291847551701027_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeFCcDKwhbE1lWCvguoWQxNO7BeAj3LKG43sF4CPcsobjVNgCtn7LjZL4-W7IKsg80yFhHSkIWsE6JO1edY_VkYj&_nc_ohc=YptfXn7lOH8Q7kNvwGjwWUs&_nc_oc=AdlNKqGcnyfmAbKsWTIZq_4r3ZtC7n-VCQ2ov-7oGe5r2KSOfx56mkBO9--QzXzsn5g&_nc_zt=23&_nc_ht=scontent.fmnl37-2.fna&_nc_gid=AGWDpUOowvIbD08TsOTQyw&oh=00_AflAySK3m82E7RUNLDYamxoEluvoHWV0m9ApCGcNR9gcSw&oe=69378D2C',
    'https://scontent.fmnl37-1.fna.fbcdn.net/v/t39.30808-6/592257640_707130232468301_4432349736547171283_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeFyFKXvMDIo3tMiFAR26mCeIygSz9b9jdMjKBLP1v2N01BmEGiCJfGW6APu3p6BoyHOOro3z-saA8Pw7bQfU7Rb&_nc_ohc=zEHhyXqqsf0Q7kNvwHpJwbP&_nc_oc=AdlP1s_nhiYHGfeP8i-AdiVmENKiAZeUA7k6xmdM8SBIT2kHWVsi1coZW8iF7lccR3o&_nc_zt=23&_nc_ht=scontent.fmnl37-1.fna&_nc_gid=Fm9icShjz3MqesbPBshF1g&oh=00_AfkD1Rs20vhwOET2M8fQovCpfhkJncdD7py5WLOue4b9fw&oe=69378DE5',
    'https://scontent.fmnl3-4.fna.fbcdn.net/v/t39.30808-6/581954088_694519200396071_4973645000010688349_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeEqoq4WYcPGzYV7Hzv8qOiIYvLZs0VYiwpi8tmzRViLCh1KOtLD-Bsyec8H5m4ElGz4gDAo7KJIWvaRfTm4QZ55&_nc_ohc=0NG4L5dLcGAQ7kNvwHGe-ze&_nc_oc=AdkK-iNdFeb72XqNHwSl7R_9eguUZHbftjBBDNAiDM88at8gnxR_TbzGoubnECgVDBo&_nc_zt=23&_nc_ht=scontent.fmnl3-4.fna&_nc_gid=MD1XN8slugR2NDMnpn9yHQ&oh=00_Aflh2IZcf4BnrMfPSo5kDeGrQQofNG8R0I_iM6vOKUBESQ&oe=69378EE1',
    'https://scontent.fmnl4-3.fna.fbcdn.net/v/t39.30808-6/568642760_673168232531168_1417650960465084784_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeFsstIQZ3ScYs-QzHlTwec5JiP9wJ6BUAMmI_3AnoFQA9JuHYGQyWBunj5vq0qAhCvMZOwTr6b5JC-joWTQpYi9&_nc_ohc=zvAhFfAY3MsQ7kNvwFCugZS&_nc_oc=AdkbV5jNnM9aQ_jTNk120-fs16HyttBKCrL8FhkejItOjOKUVExqQ49-M3pfsM4DQpc&_nc_zt=23&_nc_ht=scontent.fmnl4-3.fna&_nc_gid=uRAX8XZSTjPWW7WGjSplBQ&oh=00_AfkElkX32QDn7m1kDOg4CxY6IH_qEyf0FltMqnZGlSZwXw&oe=6939B703',
'https://scontent.fmnl4-3.fna.fbcdn.net/v/t39.30808-6/561230134_665443269970331_3061877230486969309_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeH3FKMsuLeqogYV3gKNeD-1rzR1dPCD4_qvNHV08IPj-nv8XWohnGQ9YjZFDz3QzREMFPtZaoXZCAlHzOu2zZPq&_nc_ohc=5A8ec137UnQQ7kNvwFkWZ67&_nc_oc=Adm_Kyx2920H7pKt8P21Tqq5Jlo9vmgWOJ94XQ43JbaPDnq0ixTivSnp7jQBsNNN1G0&_nc_zt=23&_nc_ht=scontent.fmnl4-3.fna&_nc_gid=Z4mRFzoGeFm_PKieSmvV_g&oh=00_AflvxgWwQGqFcpFvtcpBUwqXQxKzltiQpCfc07rfgiTzBw&oe=6939ADAC',
'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/559055694_665442583303733_5533764010837298467_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeFVo56GoZbTj5UGMna0456OWxntJnZWxUBbGe0mdlbFQLMAGx5eUlxrOQAlErLalzjA68n9-sAb5IV8Xo_vGPJq&_nc_ohc=oGPnF8z_HFUQ7kNvwH8Gn8d&_nc_oc=AdmaOu-bZvJn00HdMsnntopxbZ3U2uRyPkBREsZuU79sgCLTtFukgWj-ayo-ZBOdd5M&_nc_zt=23&_nc_ht=scontent.fmnl4-4.fna&_nc_gid=RFS_6CLyy-kKYrKftNKuNw&oh=00_AfnQbgeB5R57LHQlgemXuhYd5q8l0iKyhCK8x9SaL0a4RQ&oe=6939A772',
'https://scontent.fmnl4-1.fna.fbcdn.net/v/t39.30808-6/559352737_665440149970643_6637819718771123783_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeErXxFJByljf4II4N7jNERHHbWf5Mkpau4dtZ_kySlq7vMY8IfF50rlBPow04gxVTCDc_FeAxmtCauodVe7saCl&_nc_ohc=S7z_S1BWsVcQ7kNvwERsSEJ&_nc_oc=AdlJxbymin3Rs2s-LnjHAM9A3QbIBvuoYiBTmSEKwckN3kiy1IQcpdbmg2r0lkTyZmo&_nc_zt=23&_nc_ht=scontent.fmnl4-1.fna&_nc_gid=qODvtX25kQ1dFYENq1hiXA&oh=00_AfnPagY8zFBnVS_XpEtO4uF8HIhmOsqyLpZJTSPm9nxbww&oe=6939A9D2',
'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/555692291_652014114646580_5626409543538233357_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeEFNL1z1UxOjpFDz_BkNNYNAWe5xyblKwoBZ7nHJuUrChwpptzR3-kvPMuIYnj7Y3nhgqC19gB_sZG4EQVP57TL&_nc_ohc=ItwOm_EgTgYQ7kNvwGUZ2W2&_nc_oc=AdkjnyreuNfXRI7p0C9VE61hXa039S9IoUc9s8606myTNSUBLrL3b1bGL-WTwQ14JEE&_nc_zt=23&_nc_ht=scontent.fmnl4-4.fna&_nc_gid=-u4lFENvGtdcGN9d2seqpw&oh=00_AfmHUXAZGBnmwVGl9buW1nje45tJg8GdpRkh0TelFVymPQ&oe=69399494',
'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/535485874_620559744458684_6060841887195150704_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeHcU7JJ_JND8_Cg2L0aJSx1ntARwX32oV-e0BHBffahX_LXZ9Fmwh-SsoGo5-n2VPhvL4D8ifrQ6vOajoXhWJRs&_nc_ohc=4doue4i4XXMQ7kNvwFkAVeE&_nc_oc=AdnuH2QMZbwn6r5-Ta4uMux-NVV87CR1dXAyqveS7Ji4qEYQ39_uUTqja90T4NimmZ0&_nc_zt=23&_nc_ht=scontent.fmnl4-2.fna&_nc_gid=OrAghF6QUfnv242VsmHWoQ&oh=00_AfnCvN9_xPZIzvbn9bjAgBMahEenA7wSYHoYoRIbeVjURA&oe=69399767',
'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/536467638_620559657792026_3287640787875126216_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeGV8arr0RMr_5DmcDNXQA8B4wIEyXO8GH7jAgTJc7wYfkpezXoCHLgSfSdPdAwmtjfr_gs3BXufqlEURYn_KpZw&_nc_ohc=63y9430xOJAQ7kNvwG4Rb_d&_nc_oc=Adn7CBGyq4YWaCrEhtwM_ne0vtoJkAmPkLReSw5C5F66F3GtUoc8SY3QkaGry8b8OV4&_nc_zt=23&_nc_ht=scontent.fmnl4-7.fna&_nc_gid=CYaiuEcr14-7pe21sEhPmw&oh=00_AfnzVfNzfjqVlxLSFIrmOltxBdg5o2o3rv750mg_95me4Q&oe=69399D48',
'https://scontent.fmnl4-1.fna.fbcdn.net/v/t39.30808-6/535610895_620559581125367_6290926791254590054_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeEJP0HmDRtOK8FEHPHX28Q0WP1C0TuO4_VY_ULRO47j9dxsXba7cjclOKVNoJG5Z3Z4I2SZ1fUOC-kD2coweIlr&_nc_ohc=FQK-aLUngwIQ7kNvwEyWl8t&_nc_oc=AdmGfPqTXz1uNsBk4eBmqOJk_-FbEX2xI_vc8r9luRqrzuTSGmU9sIJCnS5EONQyxmo&_nc_zt=23&_nc_ht=scontent.fmnl4-1.fna&_nc_gid=dpO7yFdW68me-D3vO63jmg&oh=00_AflpR7LPOestrnsDNafhbf7EknxUjNOmKZnNE0wp_ZQsPg&oe=6939B8ED',
'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/536706878_620559551125370_2738585772463080361_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeEOlKBhLqByspeFKt395hLoaXfOqNIvPeBpd86o0i894ECluuv8cplCeLBm2Fv85cNhYdpAO1nIlcjwMVI3aNhG&_nc_ohc=aeWGBL8rEFsQ7kNvwFgaOus&_nc_oc=AdnNvgDbpX_4U7Omqw0q_xuwmkQZUIHWjDGncDMz19MgF4D3jvV3Rb9jJa8HojuJQSY&_nc_zt=23&_nc_ht=scontent.fmnl4-7.fna&_nc_gid=zJ8Pv9RF2IGW7hb05ESUGA&oh=00_AfmSnDJ7yJULy_lOKCTkrTehTscxSa16v3xYsiVx2p2T6g&oe=6939B44D',
'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/536252972_620559487792043_862734837922858345_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeEDmwWOSYXict38V3X1ZYLY2_6TAKcZpbjb_pMApxmluJpGuZEq51hjCsfnCOsZ79rw56EpAnYktIX1UrqlOGy7&_nc_ohc=4Y3v5Y_9KUAQ7kNvwHg-DxY&_nc_oc=AdlTQFLyIhswmxu-sjPMA1k5BAVY7U4xwRpYgFWCZ6FGiSN9rNpFe6j3cZJ1DswiFM0&_nc_zt=23&_nc_ht=scontent.fmnl4-2.fna&_nc_gid=15yywDSDUbeuY3geV_zraA&oh=00_AfkSiExvlmAmpqi2HBchwrixKAjBxZRpTQyl0_H4uokv0w&oe=69399648',
'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/537299010_620559454458713_8625893308217404814_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeEHUHQIdKKrwBkNgjmY6PvIj85lwNmvhS-PzmXA2a-FL9KqOti19fMwsEeAHdbkk5MB-IzNz7WbkkRVvQfpckqB&_nc_ohc=51cP9oSgjbwQ7kNvwGcexsk&_nc_oc=AdmhOURKZuVI4jIZBZ0BLfrzgWNKZLLiffD_XaCF3_TRgp_7J0HnfZQ5ZGKP6Y-GcY4&_nc_zt=23&_nc_ht=scontent.fmnl4-4.fna&_nc_gid=qgLjbnvvD-uMpO6AQ5-mFg&oh=00_AfnhXm5y8BUjkbQpysRApO_OI5Jx0lrrG15eXvC_JB8XWw&oe=6939A223',
'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/536365257_620559327792059_543456850559047898_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeGHc4j6idlYKbA9O-DoAy7v6qDT4KMHfljqoNPgowd-WHuZ2Vfr242Ckjlss_I6qjhF_kv-kGbGYH685P6e1dpv&_nc_ohc=mFsXMomrMZsQ7kNvwHlhAQ4&_nc_oc=AdmywFzxiIjyZyJGvdH5GGKTXHv4WASUWUr0V_u2XJczTJ6P2yXd-vB_yTyx3ibs4fk&_nc_zt=23&_nc_ht=scontent.fmnl4-2.fna&_nc_gid=x40zNlbh721aUr_n4NAvKA&oh=00_Afn9CUj4042hpCcJ7DmZVGja8V3oaOI7vO8aYGSFdNq3wg&oe=6939ACA8',
'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/535178066_620559331125392_3664029334105345635_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeGPcvSl8at0vWs3xc5n-8cHvqxNoJx-jVu-rE2gnH6NWxvG6TfW4nYNOdBFpvPhozZnT6vHNLa4f0udNsBzUCJ2&_nc_ohc=fDy22T4VYzUQ7kNvwFv8EVz&_nc_oc=Adl3Lmk94uALP5UUPpQA1VsBGQtvihkFoGTrPISfF4oYYneJG5_miJZ2hIXFBPJxYBE&_nc_zt=23&_nc_ht=scontent.fmnl4-4.fna&_nc_gid=FQeqg_3MDwjFoaxTfxTTNw&oh=00_AfnmZfBprLFMQMaYB5VE42bhoy7pxmKE3aW4eLQ9WijBDw&oe=6939C20A',
'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/535000553_620559254458733_8495711517130600171_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeHby_5c5sZSV6M9C9RZ_WGrnAGK9KFk-ZycAYr0oWT5nLCCooR5g6sXzXwRl4ewcrTjqkfJ6oJ4uic-ElsFnSMb&_nc_ohc=TQAJYcT2VyQQ7kNvwEFG9YH&_nc_oc=AdntD9TQbeckymuznmm6WG_yrcG7prDviPtRBzHTAJTfUwBlUxxazw18Jx5uUTp45rE&_nc_zt=23&_nc_ht=scontent.fmnl4-4.fna&_nc_gid=8ve4hwwiXxVGo2R08cU94w&oh=00_AflRFcn1JWKs7GoMS1U_k_gwQ58YzQIhlZ3nPGS8kw6vGA&oe=6939B260',
'https://scontent.fmnl4-3.fna.fbcdn.net/v/t39.30808-6/535678207_620559234458735_4922867935093295583_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeH8lbg5Isqbce6mPKg1rFMjUuXgUai5PdVS5eBRqLk91cvdr3yJPiFeuX65pzvo5JBveTskVwag1PlSPv8ZMs5z&_nc_ohc=E1Hu4jZ9XsIQ7kNvwGAhyr1&_nc_oc=AdnPFMPvhW_dfdt2yJao7TqoesXSnHBMTxcP5y7Ihri_iOgYoHKq1LNZW7SUl1neZrs&_nc_zt=23&_nc_ht=scontent.fmnl4-3.fna&_nc_gid=dUfEmvBar2TlR-SgOaMlVw&oh=00_AfkDKfS4GNHlFeCxjrpi7KIYFVK9ekXoM-sYzGGONNP1qA&oe=69399E3F',
'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/535004763_620559201125405_8258268020115992210_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeF2l-mkw2LtAcKBuD4NHgWJ1kiMVR9EihbWSIxVH0SKFl8cDOHdq568Ld_lnUDacov83kuGBziu9Rps7hhI2kjl&_nc_ohc=n6i8Ii9jxVUQ7kNvwF-5kHq&_nc_oc=Adlld4KjYeHj7NS4MO1OESrOIFtQdJKnZmC5H-auUbj5-ePozu3Ipqv36GVxL0wpD9I&_nc_zt=23&_nc_ht=scontent.fmnl4-2.fna&_nc_gid=wrpVrOGa-KgOdJ_9oqBwHw&oh=00_AfkTdU3y5WqaqR7N9yWPFRYdTN9sc6OCQpjg4krZwBZXlQ&oe=6939A3F8',
'https://scontent.fmnl4-1.fna.fbcdn.net/v/t39.30808-6/536990343_620559101125415_363505970353355219_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeHolUYylCtySCWVozOn-YExCWf3shPkyAQJZ_eyE-TIBPfIiUFazZxS9xML9iOBzY8oB1KT_NctNe79gMvZ2ska&_nc_ohc=E6vgx7Se4zcQ7kNvwEt53mu&_nc_oc=AdkLW0oU_0EW6PVvdSXic2SZLWkf5fWjzo_WelSvucd9pT29jjCB3TlLUYN3itYY-QM&_nc_zt=23&_nc_ht=scontent.fmnl4-1.fna&_nc_gid=bAI58-V86ipLG-3ni97Dgw&oh=00_AfmpcgGgnM1U5QvUm10U4xz69G2xOv-pSnTnG_hr9y1zpQ&oe=6939BB6E',
'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/528800204_610845555430103_7266194999876930677_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeHuXWPNEFXRvZHkAFDI_2eA2juF56WnXkzaO4XnpadeTMRcQP5MR39KauZzMcUNhviTEnV9s5HngGZi1fZshV5Q&_nc_ohc=LBeIJAwOKSgQ7kNvwHtXsjK&_nc_oc=Adnsgz0M5Dtl23GYTXeMAM7SpHdNytXbJW3z7kiVoWkaOiciGopd4SgSkDUcEsDvUt8&_nc_zt=23&_nc_ht=scontent.fmnl4-7.fna&_nc_gid=OmLS-in5ZvSsYZlXAM_8GA&oh=00_AfkZqYv4G6KVXkX17k5yQaICw_60lTjVglOUkdSIFcQo6g&oe=6939C97E',
'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/529375990_610845525430106_4196491048959915107_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeGBYz79gxboVaFJ0e9vUmXWj4qUabG0jz-PipRpsbSPP-Cb_kRn-5csHK9b0w5CTv3OB_C4GN802xmgGly8tk_1&_nc_ohc=QJ4S05SdiiEQ7kNvwEDGfAk&_nc_oc=Adm0myLGj6bKSarJCkcNkZMFr4WLdoaKeGF1tfZ4LuZPL7qkvNNxL2mlCbTZnOD7rhk&_nc_zt=23&_nc_ht=scontent.fmnl4-2.fna&_nc_gid=ytrr1kEwsE2mbkZn_sZckw&oh=00_Afknyb6kIoC5y1cpDMUmtCo58A9kR2r5cHas0zpQQrjLzg&oe=6939BEC3',
'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/529146996_610843768763615_9150079216182675399_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeE7tVz3h-GF4L4gLypQPeiwnd-hMSHhIfid36ExIeEh-KrWvebz3hTWmtcYc5HXibGduSXuTYqTziy9KHIZrSgN&_nc_ohc=s2UVBrF7kcwQ7kNvwExklqX&_nc_oc=AdmdMC1sy5MXp3P1i2ht07RY0RFiuEWAs-mMVU1UUs7Ph80aFAd8T87mhWvZXot84S4&_nc_zt=23&_nc_ht=scontent.fmnl4-2.fna&_nc_gid=OsIoYsFhkr_zstEX-zWpbg&oh=00_Afk6l0biCNFagvGVrtPxXBwO6yd9WsRDgz_JkyzBkNX9YA&oe=6939B1CF',
'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/530223671_610843748763617_4388509517588818138_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeHH_5brVOL0t-Xu2FjbE0TZNerhsIfMBAM16uGwh8wEAydyrzECqR1aspHFsHg4Xw6YU5x2i680bqCaL-BK9KS5&_nc_ohc=NWp2F3ATWj0Q7kNvwFH849C&_nc_oc=AdmGdfQCdS5f2kqcWXEIEr7CcFanNjxKBuAOQHnfYr4LOiu82qDX4e-UUx74OgJg6Gs&_nc_zt=23&_nc_ht=scontent.fmnl4-7.fna&_nc_gid=fS9DE8RyWJXm5TP1HikoNg&oh=00_AfnYB5eiQYftBkNfD2aQ4Z3SboQt-5YvSnGKiKCN8BhEUA&oe=6939BDF9',
'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/526992816_604116062769719_4587610352471678462_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeGeLPnIL2nctwf0VQh8NCdD01WqrIALYWPTVaqsgAthY9s43eazustwJiKv23fDw0PAJbsFTG3EpGhN44cXZfbV&_nc_ohc=RHpEeBZXOkUQ7kNvwFegXmK&_nc_oc=Adluo6Jcym4CKlH0DMExCZcev1oAhzxGbYZEmK-A6OKxfn8QpcOXpFbGHxZvUjN6LZY&_nc_zt=23&_nc_ht=scontent.fmnl4-7.fna&_nc_gid=K4UF9q5_98MOJwDRCH4caA&oh=00_AflahsPkKho-EGfVSjainIFJjFauwUB-69cHI6aQx0gZXA&oe=69399F0E',
'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/514274787_582619471586045_7453619898862418804_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeELMlKu8Xh-s65Jl0aqyb9lrK2uSfkPXHWsra5J-Q9cdRuwcdSxD5aq34y8do3n9mVKhExk44ihFEVMBiuQmxdz&_nc_ohc=EpECRuJNuBMQ7kNvwHjqg2a&_nc_oc=AdmUfLVLaAp3q_2FqUzyUAdRBAs8s8H3c9MwbRzlWXwdnfsDBJWdfrIX61ooXZK5EIw&_nc_zt=23&_nc_ht=scontent.fmnl4-7.fna&_nc_gid=fN1f4EtbHBtZYhr3SlIzWA&oh=00_Afltfrp2zabAlWlbcH1HPeUhCFHJlQniovi6xBiSx2SF_w&oe=6939B402',
'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/514325671_582619401586052_8916874832313209284_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeGYWDWw7fS_cIQ5RJhR6WiQr8a7tU_FeI6vxru1T8V4jsVG7EdbDW-T0CUKOXvlOxT64uw5KRNvTwjhwRi5x94l&_nc_ohc=od6_k9F5dTMQ7kNvwFpYjT-&_nc_oc=AdmakXZT5jAbUE2lfu2A-5x4x0UF9CGhp3HQ_-A73x4XY4gLGyiaSl4H4XAjrsaEQHs&_nc_zt=23&_nc_ht=scontent.fmnl4-4.fna&_nc_gid=nvg1uAfVvPY2zPHL45ovUw&oh=00_Afl9fIGF_vg8fVSDSwUf3d4jJQSMBA5fU8oSL3sJ0l5Zmg&oe=6939CDA5',
'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/515012239_582619298252729_2979024811767650680_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeFU5L0liSa8zJxIspxr4o8KjjrflQB9aY-OOt-VAH1pj7p_Dbn2nIO5DJdl9SLcrH3nS1UZjskqR16WIchzBdI4&_nc_ohc=XoWL0TlTNfsQ7kNvwERnkxY&_nc_oc=AdlDagcl655l6RcuPPgId59Hj7LtAUp0ZaRZrubnPFhF_QSCY_-EBqU9JkTfC4_BDFE&_nc_zt=23&_nc_ht=scontent.fmnl4-4.fna&_nc_gid=r79ZIFAbUzudm3XRfmxP7A&oh=00_AfluaEdf7SHKT4CgJG3bhxb0VDjr6LrrZm3pUe4rGJrUcg&oe=6939C825'

];

const creativeCommunityEventImages = [
    'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/499770255_553153661199293_7145838422785367342_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeEY5rtRMMAznkfoPsDDH3W0iEHsHqVu0UOIQewepW7RQ1WiL_eQFmIKHjYdMm8hOXBPUj82NTXFMRxqo7VzJY-j&_nc_ohc=68HqwdO_RkMQ7kNvwF-wOqO&_nc_oc=AdlE__yUOqJr9Xe3xP-ck9sbxYNYf1e3of3iWUuDEMsI_u3ADYtT-esEHzvc0TyZFPc&_nc_zt=23&_nc_ht=scontent.fmnl4-7.fna&_nc_gid=q16rGnoUiFpXJMNW8qx7WQ&oh=00_AfmeYXrpUTx0J-WEjm-YB29boHalHUn3ZnNNdOBAdEbQ9A&oe=6939A914',
'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/499897926_553153157866010_7937707302290700563_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeFKvzM8AFfi9FH05MmBmjW1foBT_bMLEMx-gFP9swsQzOkirmv_yINx8NBKJB0C7o6yMbWmRpA5SOtLu75KSTrS&_nc_ohc=d7JKOn5Cw7sQ7kNvwF6cbcE&_nc_oc=Adl-GetwYIjSNBZU2Zxv2WccuFU4CJVe4BLaXoJVRm6x-_vIHx49Dak-5vP2ORCcNiU&_nc_zt=23&_nc_ht=scontent.fmnl4-7.fna&_nc_gid=1h-73mzK-rHgU7185gUDog&oh=00_AfkOzcS9BzwsDbE1uth4S9ZhietVpM0jgc1u02il9ebutA&oe=6939CF5C',
'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/499998630_553153684532624_931969341900758434_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeGiFKfKd6mbnHbRgx3ddJslqJ70EwaNJ6SonvQTBo0npFRospuTwDsj7FWFwTfO7QjpdunyVZtTobow67H5Oavu&_nc_ohc=-tysUlvbaecQ7kNvwHPnpEt&_nc_oc=AdkWwr-7z91HrZ4WA8euapchSV_O1lxTrJsxDjdI5FZ1h0AjfaSj9AuOcAYBTJpyhVM&_nc_zt=23&_nc_ht=scontent.fmnl4-4.fna&_nc_gid=m4i0IGkkIr6bpf3hSbYTfQ&oh=00_AflzwqERNbgFzxZvPNyE0eFiTiWzhdk61wLTyxJbohdnPA&oe=6939A18F',
'https://scontent.fmnl4-3.fna.fbcdn.net/v/t39.30808-6/540692011_630406046807387_5016209864029455979_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeE9ysEQ2-hJ7KRSP3rkatyrw30vZmkheFDDfS9maSF4UIg9StjHrhBt-lrQDoJ2pjBjnze2ynsHSvgUNd_LV2hm&_nc_ohc=o_EIsRA30S8Q7kNvwFe14Tf&_nc_oc=AdmFtj8hx5BeqJ4GXXP9aIjZpx2AWmCjFbp3hypQY9sNwzilC5mZ6FXuXAJTQvAtP3w&_nc_zt=23&_nc_ht=scontent.fmnl4-3.fna&_nc_gid=v1H_6OxwQqcKhts-DPnLzA&oh=00_AflLcR2aJfFVaDsWxUafxYCqsp4bmJQZCWFCLePAB-G9SQ&oe=69399224',
'https://scontent.fmnl4-1.fna.fbcdn.net/v/t39.30808-6/540375246_630405930140732_8512555704293631158_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeHVb21qtU8IhedlYKnOZQunt1PLeIHmEfW3U8t4geYR9QcBpyThzTTSOI9-bdx9mI61vdoNq590g1y6IHLvomJ5&_nc_ohc=I13XMELmEH0Q7kNvwHGokMn&_nc_oc=AdlpoAaZorgWczDHVHzIjRdSJG5DXQ6U176IGDHhRWUapCITUn_WhDSXKwFOYCCRi54&_nc_zt=23&_nc_ht=scontent.fmnl4-1.fna&_nc_gid=CF4EEYHrjV9JaKdvETNHAQ&oh=00_AfkEqToRJoTJUo8k8kD3u5H9byDzNCmh6ABcrQiZ7Hkijg&oe=6939AEC6',
'https://scontent.fmnl4-3.fna.fbcdn.net/v/t39.30808-6/541345647_630405950140730_5414101740025776559_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeFohRfG1X3E-pKBonqi4idWARzKwHIvm3EBHMrAci-bcQqnnmDl3iC_yKCSuGfFNUByi6TRCvptvw5CE49hHTTS&_nc_ohc=JEKe_FmJjeEQ7kNvwFSblsD&_nc_oc=Adl66PAXa2ZCJU8F9I04x7Jyr_NBYTXNKmsxRHmuci8QBahb6NTFfl98EFxBnBJlJI0&_nc_zt=23&_nc_ht=scontent.fmnl4-3.fna&_nc_gid=lGEdKs9oEUg9TOrhUyRdEw&oh=00_AfmuEOKl2yf7DRNGSCInfdoPt13oAMDmwjPZ_0rwcULMrQ&oe=6939BC22',
'https://scontent.fmnl4-1.fna.fbcdn.net/v/t39.30808-6/540702110_630405910140734_2787167556829509894_n.jpg?_nc_cat=103&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeHyV6R8QFmtpwwpg2v6mYTmFwnD5rrt-AgXCcPmuu34CICEhK3OT-4hGzcHA20zUlDZpmhvuJV-9fkzUKb20Z8E&_nc_ohc=T0pCDYdNSJEQ7kNvwEL4Jlo&_nc_oc=AdkwjEIj4D0tQrEeUOlmRnP1Azvm3DhLSi2KLhzbgTdprz670NHagobnw8blgIPlEts&_nc_zt=23&_nc_ht=scontent.fmnl4-1.fna&_nc_gid=0Omfcb_cxXM7HTjZ9e-AmQ&oh=00_AfmEZsa002wC6W9702co01g9jOvjaNfc56uGN84WCPZ4mA&oe=6939AC7C',
'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/540534389_630405850140740_8641815282417382080_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeFKL_RmseRdeUP2CU7gPm2iMEedp9fCuMgwR52n18K4yNhinwb9UBJBuJT0d8CfQWdC6OktZ9SP2HkmS3JRCAkZ&_nc_ohc=7lCcma4W6dkQ7kNvwE-0v67&_nc_oc=AdlIDtTzk4wp4b5tAqvEbJBKAsYR8jFk-UAURqHalKD8jlj2iUQirFSOLoYHluOmDuE&_nc_zt=23&_nc_ht=scontent.fmnl4-2.fna&_nc_gid=n5cKCP1dU5DdfuYvw5naGQ&oh=00_Afn9F4tdVpCZNsTqib11GG_FhVD9djt3CTUD2YDryZJ6nA&oe=69399101',
'https://scontent.fmnl4-3.fna.fbcdn.net/v/t39.30808-6/501272884_553568394491153_6193380807473996914_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeEDtjEQk4eBtgb1HZ5dMrKLw0bmH4aegsrDRuYfhp6Cyvfr1A-myte9y4dy6ms9ZtUSmnc68re8dxgZwAV677tX&_nc_ohc=vrpZNwGLTZ8Q7kNvwELbUaQ&_nc_oc=AdnWjz1lo1APq2C4Y4hbjkku5-Z69GE4M_Jhr2MrK0SI6woAJruW5IzTt1ekJf6Gr4Q&_nc_zt=23&_nc_ht=scontent.fmnl4-3.fna&_nc_gid=HaH5s1Avx9siTaLl-juEHg&oh=00_AfnBCJGh-Xlnpbfmb9IESLIRuDPpoQKr5qWS_sOGmTN3mQ&oe=6939B42F',
'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/500070223_553568371157822_7418979451796951905_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeHNMQ60EYnl5ZiHIuKY7VZ0rAyrcHe-c_esDKtwd75z9zefBPnuE2-q2fPXsL3wfOsHtQorjoQ9JmgnWp8WefZz&_nc_ohc=b03HX5BV4RMQ7kNvwGlazCK&_nc_oc=AdlAnklFesAzIBVfzdF1op1PHw7V11l0DCyU6jPnb_CU-F-UxRN9R0zPTxQxYUzZGV4&_nc_zt=23&_nc_ht=scontent.fmnl4-2.fna&_nc_gid=0wOS5o9OCLlUtvYPNt_lTg&oh=00_AfnFqcH4GekP90OmDF1YYV1aSlEhPjW9-Ymqg14fUatPUA&oe=6939CDC2',
'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/500773301_553568321157827_1107243244634734901_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeGn4mpPqdKr4-Ej6yOsN6mMbmvlHWvWG99ua-Uda9Yb39LMdS2zrT4GlE2OTlG8dOUkU_X2CP7dqqN_AR1zFKSs&_nc_ohc=JlNTZdkxnc0Q7kNvwEp5TAU&_nc_oc=AdluaUJGkqrc_rE-C7D60hvaF4zJYLDZmtMUOtIV2equvlZjoY4EvU5T5thkcKOWNR0&_nc_zt=23&_nc_ht=scontent.fmnl4-2.fna&_nc_gid=QrfKssnvZW7Qhha1-KaH1w&oh=00_AflY-KoUnRY4liTwUh8AwwIgGN8ho_BWrBfi0vUz1soO9Q&oe=6939A4B8',
'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/501077536_553568254491167_755017189383738287_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeEDfXsvVXHYwciBnFEAFHqZWdlUjFEVmhtZ2VSMURWaG4QSIXJKlvukt_RC7R4Kx40yKBQKktayRiYugKiHSO68&_nc_ohc=GlCxck1ggZMQ7kNvwGPu5E5&_nc_oc=Adm20tJLMG5933w5HjnTPCbme0-qH2HjOu1sUTtoMpHmoEFiWYD9QIWKapalNMgMSo4&_nc_zt=23&_nc_ht=scontent.fmnl4-2.fna&_nc_gid=uzKwL6GJzLbEcdHbi38Ytw&oh=00_AfmTsqO3wjsV4n676d28s1ePYJ1a_T-1hkb48j5yyKlmzg&oe=6939A246',
'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/500124980_553568217824504_8849091699213652939_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeHUFHS20QSJJCJq3AwWE_inL5VNAeLiufYvlU0B4uK59i6UJdrtvikp_swfoKFnqraoOwVQYB2hL_Z7-3LuWlQK&_nc_ohc=vuw9FFrgesQQ7kNvwEOrbwg&_nc_oc=AdnBWIvi3UgFd4DqTlEnXYlnSJ18VTxXfhA5usu_suIL0iHBiq9DRRCXZ41pzYhRLM0&_nc_zt=23&_nc_ht=scontent.fmnl4-2.fna&_nc_gid=TVLTH6HUhtfS_8EwwYk7OQ&oh=00_AfmRJxPu_hJmNgeQL7ZQ-Bp8Sc-K2GgNtk4ExljcczegpQ&oe=6939C843',
'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/501532707_553568144491178_2406657919575133505_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeHCcBZWawqnLo3c7hw0BNLj6U5mECtu1jnpTmYQK27WOdCkuSeuc893B606E-9W-2gYxQafcmAl0LdSnLb6CiEh&_nc_ohc=YQS8gQu9ayoQ7kNvwG9oaFy&_nc_oc=AdnU90Vm1ia5VzsFQeoz0YX89z8VZ68Q2X2fsmd2Ab249ki7rC2Sux-vbwPokUvEOzc&_nc_zt=23&_nc_ht=scontent.fmnl4-2.fna&_nc_gid=ZlPaUYdtlaJnAUegG8_qqg&oh=00_Afk8dOHb8iiRWXEx492fkGqThARgyedZcoj7MP77SWAMNg&oe=6939C082',
'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/500062635_553568054491187_429068688245272673_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeGgQcW-q6Tep0j6L4d_clg9hQpjyVI2U8SFCmPJUjZTxAzxhhEwu175AxKRQtvUa-S6Uz5EpJ3yY0Imsg0UX9wW&_nc_ohc=CCIREvK2HYgQ7kNvwEUgkhE&_nc_oc=Adng902UtHBgbv5oLe-17d-CAsLh4BAgprEUJsPxZd4cGPZfk7xjpTx0xcYeIow_bEw&_nc_zt=23&_nc_ht=scontent.fmnl4-2.fna&_nc_gid=FU0S4vRs0VVs0LpIDEN14g&oh=00_AfnWLHkynwv_qAZb1CWrx-7yeiT7H8okLsIvETawK5vNvA&oe=6939C260',
'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/501286911_553568014491191_5194925147492822404_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeGGVWh30iq0AL5z6tfQakphU798lgiDWpFTv3yWCINakffW3Yj_t5k48BHt1AsDaxzYUdVM53BFCyGR-6I9Lhcx&_nc_ohc=ML6gKm2GLFAQ7kNvwHvU25F&_nc_oc=Adn_Zq92fNA4vfepMPbFmGH7ZpZa5kvkRNK-yV2RfjQG0-LbKjD68LRZc9ygSzfO4-4&_nc_zt=23&_nc_ht=scontent.fmnl4-2.fna&_nc_gid=1JYj0DXVLlhH-FxbUH6BzA&oh=00_AfmW-bNla98azJTDubenVBtfOpGyyZdP6vtLSpHmVCyfEQ&oe=693996D0',
'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/500245780_553567987824527_8198138618932458550_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeGzaTtsGMHjpkX-sr8_5ZxeyTAlpAyWHc_JMCWkDJYdz8WMGcwVXmbk_cCAdACZyEtPcuoI8sCy7t-S_NSo6sL7&_nc_ohc=KRrIoGz833gQ7kNvwHUfJbm&_nc_oc=AdnfT7YRGX18xEvgBSWv7Hp-SACSiudJiyLqOSv8FP2W_NxTpS8nKPKp0s1NeAQuCeE&_nc_zt=23&_nc_ht=scontent.fmnl4-2.fna&_nc_gid=W03zAvBIZDRnqDLt3qUSSQ&oh=00_AfkXQG_Ehzzu3xQeUcdhy69Oqgogqwqcn5sZEqZXlCAF1Q&oe=6939A589',
'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/499041568_553567941157865_1654088866597147785_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeFGxbXd2k_WuS1fmm9gkFGMH-873vGbGFIf7zve8ZsYUnkxrYL2L1ApHHJ_zCwap6bvmcHGcFikDaBJfPXY3lU0&_nc_ohc=RZdT-ZCBnOQQ7kNvwFOHWnX&_nc_oc=AdlaUUB14CxEDlUK1YODV4jccjZ9aB3F_R1auIsgETxJoFR1FY9ITdKTWKJ6RRPcdUA&_nc_zt=23&_nc_ht=scontent.fmnl4-7.fna&_nc_gid=wKe3VCH3TifO3kw_zoqx_Q&oh=00_AfmCsE3FobrIYkbliVMnOv3Co1jUlZ-qFKWcQogDVxqD8w&oe=6939CBC6',
'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/500070363_553567921157867_805831039546654633_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeG87RSlVgI_7OcLWSuUGPiXrdwKUSiplPet3ApRKKmU96bHJz9o7bWNoxAQck7LR2V1gB2jF7sER7NQBvvz6pF_&_nc_ohc=OjPS9uruIPgQ7kNvwHkf34l&_nc_oc=Adk31RzVZMGe50enPYGD9-xtcql9vphyrNproZ-9MDiQEYLcVRDcye5YceIjzkcuTXM&_nc_zt=23&_nc_ht=scontent.fmnl4-2.fna&_nc_gid=Hb_XxgBlStEld7t3dlEYWw&oh=00_AfkzHB7kTLArx7Hb3DQbzJwq3HYgOmFPHKZlseAZAzweaw&oe=6939B0E0',

];

const christeningImages = [
'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/505743201_563613330153326_3777516289885480655_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeHkKt3SLjvhlPvA1pB7bYvZyVH1ZNfMQ-nJUfVk18xD6ZTbJMJSqIAOt-Ul0-ZLTQAq7a1E8cCt3CpCO87MtggG&_nc_ohc=_SImAhvExOEQ7kNvwEZCRYz&_nc_oc=AdmvSu1OkX-RVrumUhW_6Nn4zQjSriZy2puxAbu4G9b9kITv-Y2cNMABj2R3DDn4GmQ&_nc_zt=23&_nc_ht=scontent.fmnl4-4.fna&_nc_gid=f7EzlT0i-C8Z1865NvyqRw&oh=00_AflfML_NekSzVQbwQhNxuDRBgcXIby9PkzabNaTBgO2Fww&oe=6939CC62',
'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/505866045_563615263486466_2051166387670395234_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeGR5k7iULKFFIAxDuIgNFN9APm2aR8hH-AA-bZpHyEf4CpgD0jAv3maMdOQe7eKmM-w9As852GmawvSjd3Dk6BD&_nc_ohc=nyvNbT6KqWoQ7kNvwFHemlv&_nc_oc=Admf7FgJY5dyyzzjRFnBcMSc7wiq9Z5Q-gOj-mvwTiWHqYJksywm_O9tv5_teWzmL2c&_nc_zt=23&_nc_ht=scontent.fmnl4-4.fna&_nc_gid=addRCT_ld6ShFMAYzXZUWA&oh=00_AfkVDEojdur845LglcO4Th5_wf-UYWGiePYO6JcG2rwUSA&oe=6939B7DA',
'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/504428909_563615316819794_989257056986365992_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeH_eo85qp_Xsz88Xcy-p49AaCS-93sPYYpoJL73ew9hiko-M9a6ySvb5-Jm9axRgmKDGzacGFRKfdvID40esUcJ&_nc_ohc=Y0FtT7PunY0Q7kNvwG_eEGl&_nc_oc=AdniAEUwYDFrsLp4yklZS7Hyyjj6BhP5c_ho-mxCne_YaIW8-i7FSasiMMkzpKvRAmw&_nc_zt=23&_nc_ht=scontent.fmnl4-7.fna&_nc_gid=V5fDUh1p914-xiOQmBsTmg&oh=00_Afncy2YS9Wf-7NuROYYoF7ZHoFy1lmo4h-aaz1YcPDfM0A&oe=6939B922',
'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/505590334_563615340153125_6959194493379435078_n.jpg?_nc_cat=104&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeE46CjqXHIXpSwNhbs7u30CGFV1atzDbO4YVXVq3MNs7kmdFyJJaqtGhNaL8jkW8VpCnr6oCTPIAox5p4toyGdM&_nc_ohc=Y7fOPJEdQSsQ7kNvwGfWups&_nc_oc=AdmRhE7PQcEzTPGP8wyLYZvYuI0S3emCOoHLkUyX6ceyN1tJriLBC6ALlAsm_cjWCkY&_nc_zt=23&_nc_ht=scontent.fmnl4-7.fna&_nc_gid=m7M2tzUaKx9o2zxczHf6Ng&oh=00_AfnLC61uZyBejz19fhAUdLkm0uhkUEAbgcU1IVmLw0kx_w&oe=6939B5DC',
'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/505863256_563615283486464_8176613169018640079_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeHl1HVtAbtyo9wccchfEDrOTIBE23MU3g1MgETbcxTeDdUd46kkNqjqUdbwPWs5JkWN7kbjTlwoJeiI3qyXkxV0&_nc_ohc=68dQOcKlIXoQ7kNvwG7SJql&_nc_oc=Adn5bAZ12qA-Ws-r9f--9QUU6t2kf_10E53Avu21KEZLJxvXZhswp3FhfQ-9nkeg_EY&_nc_zt=23&_nc_ht=scontent.fmnl4-7.fna&_nc_gid=K92Nq9SYA6P6sdA6J5bDrg&oh=00_AfnYz1dOgRjXCvojokkY_B2YGESnIarSsE5pq94I130_ow&oe=6939B45C',
'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/537784020_624967544017904_4220525975909773369_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeFjlsuljlj2M432BtL7zTDIivpzDFwgRruK-nMMXCBGuyBugqrZlzIOJiQ_hHsBPxMCCd-yFv2dSJsIdv_76vhA&_nc_ohc=uDujZcWISqUQ7kNvwHrJX38&_nc_oc=AdkKsgV7pLBym-4RP92VD8xkWWO_RzkK5QPqq24nNXz0vhw-kpnFMffX0uNpv0HqhWs&_nc_zt=23&_nc_ht=scontent.fmnl4-2.fna&_nc_gid=23UL9gZgjgiU1I7JM0GA-Q&oh=00_AfmudKfYd-fR22unsS5pEoVDTsDZVi9P0So9R8JGrbmEcg&oe=6939A2CB',
'https://scontent.fmnl4-3.fna.fbcdn.net/v/t39.30808-6/538186956_624967527351239_6948197561752104094_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeEsG_JpmEvrlUad2RFRjTTWlseySwFnGNeWx7JLAWcY1x8c7AHho5vMr5eued3iz3hSp9dx0CKBPrwugU54yBTL&_nc_ohc=ZrtFzjbSsGoQ7kNvwEmV9pY&_nc_oc=AdmevX-wEyWJhcv3yQUH7QFAkYVUs1iUbWUohFrieeZSIArIG7Xzqqg17uI43UBmU1U&_nc_zt=23&_nc_ht=scontent.fmnl4-3.fna&_nc_gid=-QKglnc3legkDMKhP_2y_Q&oh=00_AfkYWSBamy9MUHjjULC5BKSlKMNdXRmI1hBgKUtjdut5NQ&oe=6939AF98',
'https://scontent.fmnl4-3.fna.fbcdn.net/v/t39.30808-6/538251574_624967334017925_5279358832535495083_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeEdGxMuGEdEauy3fXTgRosxQKMYConF-ZBAoxgKicX5kJCwyQMOCUDbVaecq4-6etqKvQQ0xUry08d39TQsYmV3&_nc_ohc=mYZRLKEJnLcQ7kNvwG3e7_t&_nc_oc=AdkpUFnLGTFYPP1iaGYrfenJtD0Rh76oDx7lsMoCZYzflUceuxRrO-N-_BHPPOimUtU&_nc_zt=23&_nc_ht=scontent.fmnl4-3.fna&_nc_gid=MkDMGC8a9rmdzt6A2awjtQ&oh=00_AflB7ZuBx65KHj4OmdWcVcF-3KD5sjITYQzxRr8MF3Ie7Q&oe=69399B82',
'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/538408551_624967307351261_5172426053003882943_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeFD5nXSeJTZgnMEYvU8dVHheE2RYc-bypB4TZFhz5vKkGlvjotQderhMz3RkR-Pzk5-c4SgfSm_4GQ2FnBxzuvU&_nc_ohc=0WakH_qhcCkQ7kNvwGI230v&_nc_oc=AdnoPzO7w_sxZIl2vQxxI2bzbqZrYa8EVDGCipCEqHRM_R8NV-71GvBMwSq-ihIlTQw&_nc_zt=23&_nc_ht=scontent.fmnl4-2.fna&_nc_gid=bgKfcosW5rg9VgwBmWZAbg&oh=00_Afkl386lOgpZZUVh4Q2GnWOtGgXKEKwdIHMTNh_mrOJGEQ&oe=6939A159',
'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/538033455_624967237351268_1223155479526702449_n.jpg?_nc_cat=102&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeHedCEFSJLlMEbpSlcYKBXvNgp0VlNUZlo2CnRWU1RmWoyL6TbXGwRL7m7GGDhrVU4ZyaneM8ZA4yp4HR17ZTN4&_nc_ohc=DslwgCbvJNMQ7kNvwFWT4gb&_nc_oc=AdnP2IEZOcpqEdgaLtutV3wVrnTI1HEBNbYoQ3KyTWRjugLx-qWmi1ek8rn_xopXH5o&_nc_zt=23&_nc_ht=scontent.fmnl4-4.fna&_nc_gid=AkcgfhiAWglXBCB1PD1Jwg&oh=00_AflIIDOVfb_6iDp0RpHEcKFSJKFGQK_GSur6ESqTHwt-CA&oe=6939B86F',
'https://scontent.fmnl4-3.fna.fbcdn.net/v/t39.30808-6/538369790_624967240684601_2385810572734746754_n.jpg?_nc_cat=109&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeFpw4LaLnWitb341PqorEQcB7QhP9XW2g4HtCE_1dbaDt1Ool8-qM_jpNecWhhlsX-FLqqPtvSgUHAAuBwKJhh0&_nc_ohc=3Wa7X1dbj-kQ7kNvwHIwEJ3&_nc_oc=AdnDLdygtI_2ATnz53Ycg8yPLyBmRhpbzHlRXeAUB0-rfChhfF2fVVCGtM5tDm4LPFc&_nc_zt=23&_nc_ht=scontent.fmnl4-3.fna&_nc_gid=UbqI-0oOotGfhcH1DjQvsw&oh=00_AfmYJrQ8R6URQbBj54B_W8Dm7wCls-WKa34mX_--78ffTA&oe=6939A2C6',
'https://scontent.fmnl4-1.fna.fbcdn.net/v/t39.30808-6/538186966_624967140684611_4926208343515387255_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeEG2XAi6qFnem1f6R3FZy_YLWZTvjwGJQctZlO-PAYlB1ZEJPR3http3PtDyKAki9SEIItSB_P5UaF0eF3A3X1f&_nc_ohc=YZw4PVKhXrEQ7kNvwGdSx_h&_nc_oc=Adkdfj4-pBCGeoDoQzpc8MLtaSJF8_zfa2nvb3ukpR86NrX0C9oTnLnBRNtHAvfEZ88&_nc_zt=23&_nc_ht=scontent.fmnl4-1.fna&_nc_gid=3CkUFjzuxv2ruRX6tf0pyg&oh=00_Afly7-NYqbM-KtO8LAJdXnTGMod68efLZA1G28gBoGKIxw&oe=69399504',
'https://scontent.fmnl4-7.fna.fbcdn.net/v/t39.30808-6/539388893_624967007351291_5576644750112712485_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeGVMvyUpdtTSBcffaYYweAebCLcs59wGYNsItyzn3AZg38kd8O1MR9j8qrpbng9b5vI2L3WOz_Xx9ljJlx1U78d&_nc_ohc=VqyQufBuSy0Q7kNvwGk-QRm&_nc_oc=AdkwmQviAIePTyBI51x3rtdA-DEQMre_UAzSEsucfrJeYTYej-Q1xQdnCXr6CWa2dwQ&_nc_zt=23&_nc_ht=scontent.fmnl4-7.fna&_nc_gid=1vDk9HYzUr_-rHPXH5ck-g&oh=00_AfkSWa-G7xA0McuQBdo8yn4gyXIMhBWsXpg2jg35FEB4eQ&oe=6939A63E',
'https://scontent.fmnl4-3.fna.fbcdn.net/v/t39.30808-6/539288743_624966987351293_5697330358166614662_n.jpg?_nc_cat=110&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeExrgg4d1s1QSOQLdUzEUCTVEK6PenFyNFUQro96cXI0ZIKi3X2HG5dtkSXmvuTmzGRQkPg_sH7Cj5TWHhLG3e8&_nc_ohc=HBxNRO2gxXkQ7kNvwHYhaV_&_nc_oc=AdnUqLs0U_eP2m-p8ztN6ixKmARPqIdLfBK1mza-LZET22g6DwQmvx0n193WFQPQA58&_nc_zt=23&_nc_ht=scontent.fmnl4-3.fna&_nc_gid=dF_Td8mio6lXOQTg8Yw3GA&oh=00_AfmHkgqrFPWy_NEladtvwrL7SpY-a2RZoR-VuPxUHlMwGA&oe=6939C01E',
'https://scontent.fmnl4-4.fna.fbcdn.net/v/t39.30808-6/539199898_624966950684630_7731443553035957533_n.jpg?_nc_cat=100&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeHBOf2fkaNdNNIYlL0kKiavR4mkYYHAGBdHiaRhgcAYF6PPkx02IitZlrhi-36YOdP3YeGty0UFfZqkcJe-U1VY&_nc_ohc=lsIlEo1xje4Q7kNvwHgssAv&_nc_oc=AdnPJp9oTlghzDB2rVAvLb9icjPPAt-nJ3Uo_uZMXT3mEOQP-2amdTvlvK_4tdzt4gI&_nc_zt=23&_nc_ht=scontent.fmnl4-4.fna&_nc_gid=quIxqwYHmMlgWbm9Nq_Elg&oh=00_AfmeysiVRmF0FzTGK5B3kktXFOT340Y92rCzmW8W_s_Qyg&oe=6939A012',
'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/539851467_624966710684654_7585649403172820271_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeHNAoINAuLpUIY5qk_jDFaijjTZkREV3R6ONNmRERXdHn88vM7XZM3SxTptIiR_w2u3Jn2Cwa_ZPd5WkkQlCrfL&_nc_ohc=qY8HdjlPV1MQ7kNvwGccuNk&_nc_oc=AdkBXbqRO5OWQe5L4FNgYhSxL4OcHvi0x6kRntdx4gcAMlw0OTmnHQMM8Jj9SKSR7Is&_nc_zt=23&_nc_ht=scontent.fmnl4-2.fna&_nc_gid=6aq_UODs0VqlVwAC6ebS-Q&oh=00_Aflx7GwfAs83Rkmgbe-22JQVzSAuK5kOzVxJF6QYKQDizw&oe=6939B5A9',
'https://scontent.fmnl4-1.fna.fbcdn.net/v/t39.30808-6/538625384_624966367351355_806867798810211231_n.jpg?_nc_cat=106&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeE4no-c2fQGlp3lTJy6GSD-VI2yo5xoni5UjbKjnGieLt_L63eshVcdkEN1rG13ccvbU7CsgWBqGuPlSloWlN2M&_nc_ohc=_S-3VbQknFEQ7kNvwEyWYjN&_nc_oc=AdkLg6589LRg3U_kV-NGnbgpanAVTDR_hfrm_EkkvmOqHZMu3oDs3qE_a5fj6qi7KNA&_nc_zt=23&_nc_ht=scontent.fmnl4-1.fna&_nc_gid=SICklbRR3pQ9yXYHgRdrZQ&oh=00_Afmq4Exi4wPZKazfZ74ztpVKxDYNZXeHOeqM1GnQIVdNDQ&oe=6939C87A',
'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/539600418_624966344018024_964130849184406859_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeFYWy7F_AEGnfg-ulqy-EmqYdSjvdDVKERh1KO90NUoRPlafnRueW8eXdqtypJSnHhbkg2sdTpxhjWzJzmoNC-t&_nc_ohc=UN8DK-eY9XYQ7kNvwFJHLwb&_nc_oc=Adma_3SKjhapC17_mvDcgGXD3JnZAxoawf-0p-auV2QV-FoM85rnmC9g9DJksFqVFE0&_nc_zt=23&_nc_ht=scontent.fmnl4-2.fna&_nc_gid=N6GVjJ0yt5GtkQpWHCcdnA&oh=00_AfneoZjg4L6awnTHJl3TQAyqw5DjFl1It_0piU5_lbvEDQ&oe=6939B591',
'https://scontent.fmnl4-2.fna.fbcdn.net/v/t39.30808-6/538142169_624966270684698_7604883112554328127_n.jpg?_nc_cat=105&ccb=1-7&_nc_sid=127cfc&_nc_eui2=AeGZWraGRsVmFdpLsV_txAP6O5r5nHDnFCI7mvmccOcUIjqak_A5Mhwyuc-7ddZIj0qAcOvOaKxuKVxikhQ-kEnu&_nc_ohc=9O6cRFF-_RUQ7kNvwGRDyAG&_nc_oc=AdmteCn5-DgraV4whQCN54jf9HWQ79SzE-GpQ0avyZn6tY7VJ4-NNNbqiec146esRaM&_nc_zt=23&_nc_ht=scontent.fmnl4-2.fna&_nc_gid=Qos7jLyoTW8MeKIIwd4cdg&oh=00_AflPx0uGwYPdGptImVNmkAqHtGScWcTElWDw6DlvsYZH7w&oe=693999C3',


];

const buildImageSeries = (basePath: string, prefix: string, count: number) =>
    Array.from({ length: count }, (_, index) => `${basePath}/${prefix}-${index + 1}.jpg`);

const localEventCoverImages: Record<string, string> = {
    wedding: '/images/events/wedding/wedding-1.jpg',
    birthday: '/images/events/birthday/birthday-1.jpg',
    'creative-community-event': '/images/events/pre-debut/pre-debut-1.jpg',
    christening: '/images/events/prenuptial/prenuptial-1.jpg',
};

const localEventGalleryImages: Record<string, string[]> = {
    wedding: buildImageSeries('/images/events/wedding', 'wedding', 18),
    birthday: buildImageSeries('/images/events/birthday', 'birthday', 19),
    'creative-community-event': buildImageSeries('/images/events/pre-debut', 'pre-debut', 5),
    christening: buildImageSeries('/images/events/prenuptial', 'prenuptial', 19),
};

const modalImages = computed(() => {
    if (selectedEventType.value && localEventGalleryImages[selectedEventType.value]?.length) {
        return localEventGalleryImages[selectedEventType.value];
    }

    if (selectedEventType.value === 'birthday') return birthdayImages;
    if (selectedEventType.value === 'wedding') return weddingImages;
    if (selectedEventType.value === 'creative-community-event') return creativeCommunityEventImages;
    if (selectedEventType.value === 'christening') return christeningImages;
    return [];
});

const openGallery = (eventType: string) => {
    selectedEventType.value = eventType;
    showModal.value = true;
    document.body.style.overflow = 'hidden';
};

const closeModal = () => {
    showModal.value = false;
    selectedEventType.value = null;
    document.body.style.overflow = '';
};

// Limit portfolio images to 6
const portfolioImages = computed(() => {
    return (props.galleryImages || []).slice(0, 6);
});

const getEventDisplayName = (eventType: string | null | undefined) => {
    if (!eventType) return '';
    if (eventType === 'creative-community-event') return 'Pre Debut';
    if (eventType === 'christening') return 'Prenuptial';
    return eventType;
};

const getEventCardTitle = (eventType: LandingImage) => {
    if (eventType.event_type === 'creative-community-event') {
        return 'Pre Debut';
    }

    if (eventType.event_type === 'christening') {
        return 'Prenuptial';
    }

    return eventType.title || getEventDisplayName(eventType.event_type);
};

const getEventCardImage = (eventType: LandingImage) => {
    const eventKey = eventType.event_type || '';
    return localEventCoverImages[eventKey] || eventType.image_url;
};

const heroSlides = computed(() => [
    { eventType: 'wedding', title: 'Wedding', imageUrl: '/images/events/wedding/wedding-1.jpg' },
    { eventType: 'birthday', title: 'Birthday', imageUrl: '/images/events/birthday/birthday-1.jpg' },
    { eventType: 'creative-community-event', title: 'Pre Debut', imageUrl: '/images/events/pre-debut/pre-debut-1.jpg' },
    { eventType: 'christening', title: 'Prenuptial', imageUrl: '/images/events/prenuptial/prenuptial-1.jpg' },
]);

const currentHeroSlide = computed(() => {
    if (!heroSlides.value.length) {
        return {
            eventType: eventImages.value[0]?.event_type || 'wedding',
            title: eventImages.value[0]?.title || getEventDisplayName(eventImages.value[0]?.event_type) || 'Wedding',
            imageUrl: eventImages.value[0]?.image_url || '/images/events/wedding/wedding-1.jpg',
        };
    }

    return heroSlides.value[activeHeroSlide.value];
});

const nextHeroSlide = () => {
    if (!heroSlides.value.length) return;
    activeHeroSlide.value = (activeHeroSlide.value + 1) % heroSlides.value.length;
};

onMounted(() => {
    heroSlideInterval = window.setInterval(() => {
        nextHeroSlide();
    }, 4500);
});

onUnmounted(() => {
    if (heroSlideInterval !== null) {
        clearInterval(heroSlideInterval);
        heroSlideInterval = null;
    }
});
</script>

<template>
    <Head title="Brighter Days Photography PH - Event Management System" />
    
    <div
        class="min-h-screen overflow-hidden relative"
        style="background:
            radial-gradient(circle at 15% 20%, rgba(255, 190, 152, 0.42), transparent 34%),
            radial-gradient(circle at 84% 22%, rgba(240, 165, 153, 0.34), transparent 36%),
            radial-gradient(circle at 72% 82%, rgba(206, 90, 67, 0.30), transparent 40%),
            radial-gradient(circle at 28% 80%, rgba(248, 216, 212, 0.36), transparent 42%),
            linear-gradient(145deg, #F8D8D4 0%, #FFBE98 36%, #F0A599 62%, #F09367 82%, #CE5A43 100%);"
    >
        <!-- Animated Background Elements -->
        <div class="absolute inset-0 overflow-hidden pointer-events-none">
            <div class="absolute top-10 left-8 w-80 h-80 bg-[#FFBE98] rounded-full mix-blend-soft-light filter blur-2xl opacity-44 animate-blob"></div>
            <div class="absolute top-32 right-8 w-80 h-80 bg-[#F0A599] rounded-full mix-blend-overlay filter blur-2xl opacity-26 animate-blob animation-delay-2000"></div>
            <div class="absolute bottom-16 left-1/2 w-80 h-80 bg-[#CE5A43] rounded-full mix-blend-multiply filter blur-2xl opacity-20 animate-blob animation-delay-4000"></div>
            <div class="absolute -bottom-24 -left-10 w-[24rem] h-[24rem] bg-[#F8D8D4] rounded-full mix-blend-soft-light filter blur-3xl opacity-36 animate-blob animation-delay-2000"></div>
        </div>
        <!-- Navigation -->
        <nav class="fixed top-0 left-0 right-0 bg-white/90 dark:bg-gray-900/85 backdrop-blur-md border-b border-[#5A3D22] dark:border-gray-700 z-50">
            <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
                <div class="flex justify-between items-center h-16">
                    <div class="flex items-center">
                            <img src="/images bd/logo.png" alt="Brighter Days Logo" class="w-10 h-10 mr-3" />
                        <span class="text-xl font-bold text-gray-900 dark:text-white">Brighter Days Photography PH</span>
                    </div>
                    <div class="flex items-center gap-4">
                        <Link
                            href="/login"
                            class="px-5 py-2 rounded-lg border border-[#BB8C94] bg-white/55 text-[#741C28] font-semibold shadow-sm hover:bg-[#BB8C94] hover:text-white hover:border-[#BE6674] hover:shadow-md transition-all duration-300"
                        >
                            Log in
                        </Link>
                        <Link
                            v-if="canRegister"
                            href="/register"
                            class="px-5 py-2 rounded-lg bg-gradient-to-r from-[#BB8C94] to-[#BE6674] border border-[#BE6674] text-white font-semibold hover:from-[#BE6674] hover:to-[#741C28] hover:border-[#741C28] hover:shadow-lg transition-all duration-300"
                        >
                            Register
                        </Link>
                    </div>
                </div>
            </div>
        </nav>

        <div v-if="flashSuccess || flashError" class="pt-20 px-4 sm:px-6 lg:px-8 relative z-30">
            <div class="max-w-7xl mx-auto">
                <div
                    class="rounded-xl border px-4 py-3 flex flex-col sm:flex-row sm:items-center sm:justify-between gap-3"
                    :class="flashError ? 'border-red-300 bg-red-50 text-red-800 dark:border-red-700 dark:bg-red-900/30 dark:text-red-200' : 'border-[#B58C3C] bg-[#F5F3ED] text-[#3F2B19] dark:border-[#B58C3C] dark:bg-[#3F2B19] dark:text-[#F5F3ED]'"
                >
                    <p class="text-sm font-medium">{{ flashError || flashSuccess }}</p>
                    <Link
                        v-if="flashReceipt?.url"
                        :href="flashReceipt.url"
                        class="text-sm font-semibold underline decoration-2 underline-offset-2"
                    >
                        View Receipt {{ flashReceipt?.number ? `(${flashReceipt.number})` : '' }}
                    </Link>
                </div>
            </div>
        </div>

        <!-- Hero Section -->
        <div class="pt-24 pb-16 px-4 sm:px-6 lg:px-8 relative">
            <div class="max-w-7xl mx-auto">
                <div class="grid lg:grid-cols-2 gap-12 items-center">
                    <!-- Left Content -->
                    <div class="text-center lg:text-left animate-fade-in-up">
                        <div class="inline-block mb-4">
                            <span class="px-4 py-2 bg-[#863D28] text-[#F3DBB7] rounded-full text-sm font-semibold shadow-sm">
                                ✨ Capturing Life's Special Moments Since 2020
                            </span>
                        </div>
                        <h1 class="text-5xl md:text-6xl lg:text-7xl font-bold text-[#4A2118] mb-6 leading-tight">
                            Brighter Days,
                            <span class="text-[#7A3F35] drop-shadow-[0_2px_8px_rgba(243,219,183,0.55)]">
                                Beautiful Memories
                            </span>
                        </h1>
                        <p class="text-xl text-[#5F5148] mb-8 max-w-2xl mx-auto lg:mx-0">
                            From weddings and birthdays to creative community events and christenings, we specialize in capturing the authentic, candid moments that make every occasion unforgettable. Elegant photography with a natural, timeless feel.
                        </p>
                    </div>

                    <!-- Right Content - Image Showcase -->
                    <div class="relative lg:block hidden">
                        <div class="relative h-[600px]">
                            <!-- Main Image -->
                            <div class="absolute inset-0 rounded-3xl overflow-hidden shadow-2xl transform hover:scale-[1.02] transition-transform duration-500">
                                <div class="absolute inset-0">
                                    <Transition
                                        mode="out-in"
                                        enter-active-class="transition-opacity duration-700"
                                        enter-from-class="opacity-0"
                                        enter-to-class="opacity-100"
                                        leave-active-class="transition-opacity duration-700"
                                        leave-from-class="opacity-100"
                                        leave-to-class="opacity-0"
                                    >
                                        <img
                                            :key="currentHeroSlide.imageUrl"
                                            :src="currentHeroSlide.imageUrl"
                                            :alt="currentHeroSlide.title"
                                            class="w-full h-full object-cover"
                                        />
                                    </Transition>
                                    <div class="absolute inset-0 bg-gradient-to-t from-black/50 to-transparent"></div>
                                    <div class="absolute bottom-8 left-8 text-white">
                                        <p class="text-sm font-semibold mb-1">{{ currentHeroSlide.title }} Photography</p>
                                        <div class="flex items-center">
                                            <div class="flex -space-x-2">
                                                <div class="w-8 h-8 rounded-full bg-[#5A3D22] border-2 border-white"></div>
                                                <div class="w-8 h-8 rounded-full bg-[#3F2B19] border-2 border-white"></div>
                                                <div class="w-8 h-8 rounded-full bg-[#B58C3C] border-2 border-white"></div>
                                            </div>
                                            <span class="ml-3 text-sm">100+ Happy Clients</span>
                                        </div>
                                    </div>
                                    <div class="absolute bottom-8 right-8 flex gap-2">
                                        <button
                                            v-for="(slide, index) in heroSlides"
                                            :key="slide.eventType"
                                            type="button"
                                            class="h-2.5 w-2.5 rounded-full border border-white/70 transition-all"
                                            :class="index === activeHeroSlide ? 'bg-white scale-110' : 'bg-white/40 hover:bg-white/70'"
                                            @click="activeHeroSlide = index"
                                            :aria-label="`Show ${slide.title}`"
                                        />
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Floating Cards -->
                            <div class="absolute -left-8 top-20 bg-white/95 dark:bg-gray-800 rounded-2xl shadow-xl p-4 animate-float transition-transform duration-500 hover:-translate-y-1 hover:shadow-2xl">
                                <div class="flex items-center gap-3">
                                    <div class="w-12 h-12 bg-green-100 dark:bg-green-900/30 rounded-xl flex items-center justify-center">
                                        <svg class="w-6 h-6 text-green-600 dark:text-green-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
                                        </svg>
                                    </div>
                                    <div>
                                        <p class="font-semibold text-gray-900 dark:text-white">Booking Confirmed</p>
                                        <p class="text-sm text-gray-600 dark:text-gray-400">Wedding Package</p>
                                    </div>
                                </div>
                            </div>

                            <div class="absolute -right-8 bottom-40 bg-white/95 dark:bg-gray-800 rounded-2xl shadow-xl p-4 animate-float animation-delay-2000 transition-transform duration-500 hover:-translate-y-1 hover:shadow-2xl">
                                <div class="flex items-center gap-3">
                                    <div class="w-12 h-12 bg-[#3F2B19] dark:bg-[#3F2B19]/30 rounded-xl flex items-center justify-center">
                                        <svg class="w-6 h-6 text-[#3F2B19] dark:text-[#3F2B19]" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 21a4 4 0 01-4-4V5a2 2 0 012-2h4a2 2 0 012 2v12a4 4 0 01-4 4zm0 0h12a2 2 0 002-2v-4a2 2 0 00-2-2h-2.343M11 7.343l1.657-1.657a2 2 0 012.828 0l2.829 2.829a2 2 0 010 2.828l-8.486 8.485M7 17h.01" />
                                        </svg>
                                    </div>
                                    <div>
                                        <p class="font-semibold text-gray-900 dark:text-white">AI Theme Generated</p>
                                        <p class="text-sm text-gray-600 dark:text-gray-400">Elegant & Modern</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Event Types Showcase -->
                <div class="mt-32 relative z-20">
                    <div class="text-center mb-16">
                        <h2 class="text-4xl md:text-5xl font-bold text-[#4A2118] mb-4">
                            Every Moment is
                            <span class="text-[#7A3F35] drop-shadow-[0_2px_8px_rgba(243,219,183,0.55)]"> Beautiful</span>
                        </h2>
                        <p class="text-xl text-[#5F5148] max-w-2xl mx-auto">
                            From intimate ceremonies to grand celebrations, we capture the genuine emotions and candid moments that tell your unique story
                        </p>
                    </div>

                    <div class="grid grid-cols-2 md:grid-cols-4 gap-6">
                        <div v-for="(eventType, index) in eventTypes" :key="eventType.id" 
                             @click="eventType.event_type ? openGallery(eventType.event_type) : null"
                             class="group relative overflow-hidden rounded-2xl aspect-square cursor-pointer bg-gray-900">
                            <img :src="getEventCardImage(eventType)" :alt="eventType.title || eventType.event_type || 'Event'" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" loading="lazy" onerror="this.style.display='none'" />
                            <div class="absolute inset-0 bg-gradient-to-t from-black/60 via-transparent to-transparent transition-all duration-300"
                                 :class="{
                                     'group-hover:from-[#5A3D22]/70': eventType.event_type === 'wedding',
                                     'group-hover:from-[#B58C3C]/70': eventType.event_type === 'birthday',
                                     'group-hover:from-[#3F2B19]/70': eventType.event_type === 'creative-community-event',
                                     'group-hover:from-[#000000]/70': eventType.event_type === 'christening',
                                 }"></div>
                            <div class="absolute bottom-0 left-0 right-0 p-6 text-white transform translate-y-2 group-hover:translate-y-0 transition-transform">
                                <h3 class="text-2xl font-bold mb-1">{{ getEventCardTitle(eventType) }}</h3>
                                <p class="text-sm opacity-0 group-hover:opacity-100 transition-opacity">Click to view gallery</p>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Features Grid -->
                <div class="mt-32 grid grid-cols-1 md:grid-cols-3 gap-8 relative z-20">
                    <div class="group bg-white dark:bg-gray-800 rounded-2xl p-8 shadow-lg hover:shadow-2xl transition-all duration-300 hover:-translate-y-2">
                        <div class="w-14 h-14 bg-gradient-to-br from-[#863D28] to-[#C2613A] rounded-xl flex items-center justify-center mb-6 group-hover:scale-110 transition-transform">
                            <svg class="w-7 h-7 text-[#F3DBB7]" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z" />
                            </svg>
                        </div>
                        <h3 class="text-2xl font-bold text-gray-900 dark:text-white mb-3">Seamless Booking</h3>
                        <p class="text-gray-600 dark:text-gray-300 leading-relaxed">
                            Reserve your special date with ease. Our simple booking system ensures your event photography is secured effortlessly for any occasion.
                        </p>
                    </div>

                    <div class="group bg-white dark:bg-gray-800 rounded-2xl p-8 shadow-lg hover:shadow-2xl transition-all duration-300 hover:-translate-y-2">
                        <div class="w-14 h-14 bg-gradient-to-br from-[#C2613A] to-[#E87E47] rounded-xl flex items-center justify-center mb-6 group-hover:scale-110 transition-transform">
                            <svg class="w-7 h-7 text-[#FCE9DB]" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M7 21a4 4 0 01-4-4V5a2 2 0 012-2h4a2 2 0 012 2v12a4 4 0 01-4 4zm0 0h12a2 2 0 002-2v-4a2 2 0 00-2-2h-2.343M11 7.343l1.657-1.657a2 2 0 012.828 0l2.829 2.829a2 2 0 010 2.828l-8.486 8.485M7 17h.01" />
                            </svg>
                        </div>
                        <h3 class="text-2xl font-bold text-gray-900 dark:text-white mb-3">Custom Themes</h3>
                        <p class="text-gray-600 dark:text-gray-300 leading-relaxed">
                            Create your perfect event aesthetic with AI-powered theme generation. Beautiful color palettes tailored to your vision for any celebration.
                        </p>
                    </div>

                    <div class="group bg-white dark:bg-gray-800 rounded-2xl p-8 shadow-lg hover:shadow-2xl transition-all duration-300 hover:-translate-y-2">
                        <div class="w-14 h-14 bg-gradient-to-br from-[#A47563] to-[#863D28] rounded-xl flex items-center justify-center mb-6 group-hover:scale-110 transition-transform">
                            <svg class="w-7 h-7 text-[#F3DBB7]" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 9V7a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2m2 4h10a2 2 0 002-2v-6a2 2 0 00-2-2H9a2 2 0 00-2 2v6a2 2 0 002 2zm7-5a2 2 0 11-4 0 2 2 0 014 0z" />
                            </svg>
                        </div>
                        <h3 class="text-2xl font-bold text-gray-900 dark:text-white mb-3">Secure Payments</h3>
                        <p class="text-gray-600 dark:text-gray-300 leading-relaxed">
                            Manage your event booking with confidence. Simple payment tracking and secure transaction processing for peace of mind.
                        </p>
                    </div>
                </div>

                <!-- Testimonials -->
                <div class="mt-32 relative z-20">
                    <div class="text-center mb-12">
                        <h2 class="text-4xl md:text-5xl font-bold text-[#F5F3ED] dark:text-white mb-4">
                            What Our Clients <span class="bg-gradient-to-r from-[#5A3D22] to-[#B58C3C] bg-clip-text text-transparent">Are Saying</span>
                        </h2>
                        <p class="text-xl text-[#F5F3ED]/85 dark:text-gray-300">Testimonials from satisfied clients</p>
                    </div>

                    <div class="grid grid-cols-1 md:grid-cols-3 gap-8">
                        <div class="bg-white dark:bg-gray-800 rounded-2xl p-8 shadow-lg hover:shadow-xl transition-shadow border border-gray-200 dark:border-gray-700">
                            <div class="flex items-center gap-1 mb-4">
                                <svg class="w-5 h-5 fill-[#B58C3C]" viewBox="0 0 20 20"><path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/></svg>
                                <svg class="w-5 h-5 fill-[#B58C3C]" viewBox="0 0 20 20"><path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/></svg>
                                <svg class="w-5 h-5 fill-[#B58C3C]" viewBox="0 0 20 20"><path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/></svg>
                                <svg class="w-5 h-5 fill-[#B58C3C]" viewBox="0 0 20 20"><path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/></svg>
                                <svg class="w-5 h-5 fill-[#B58C3C]" viewBox="0 0 20 20"><path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/></svg>
                            </div>
                            <p class="text-gray-600 dark:text-gray-300 mb-6 leading-relaxed">
                                "They captured the genuine joy and love of our wedding day perfectly. Every candid moment, every tear, every laugh - it's all there. We couldn't be happier!"
                            </p>
                            <div class="flex items-center gap-4">
                                <div class="w-12 h-12 rounded-full bg-gradient-to-br from-[#5A3D22] to-[#B58C3C]"></div>
                                <div>
                                    <h4 class="font-bold text-gray-900 dark:text-white">Sarah & James</h4>
                                    <p class="text-sm text-gray-500 dark:text-gray-400">Garden Wedding, 2024</p>
                                </div>
                            </div>
                        </div>

                        <div class="bg-white dark:bg-gray-800 rounded-2xl p-8 shadow-lg hover:shadow-xl transition-shadow border border-gray-200 dark:border-gray-700">
                            <div class="flex items-center gap-1 mb-4">
                                <svg class="w-5 h-5 fill-[#B58C3C]" viewBox="0 0 20 20"><path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/></svg>
                                <svg class="w-5 h-5 fill-[#B58C3C]" viewBox="0 0 20 20"><path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/></svg>
                                <svg class="w-5 h-5 fill-[#B58C3C]" viewBox="0 0 20 20"><path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/></svg>
                                <svg class="w-5 h-5 fill-[#B58C3C]" viewBox="0 0 20 20"><path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/></svg>
                                <svg class="w-5 h-5 fill-[#B58C3C]" viewBox="0 0 20 20"><path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/></svg>
                            </div>
                            <p class="text-gray-600 dark:text-gray-300 mb-6 leading-relaxed">
                                "The photos are absolutely breathtaking! They have a beautiful, bright style that perfectly captured the elegance of our beach ceremony. Pure magic!"
                            </p>
                            <div class="flex items-center gap-4">
                                <div class="w-12 h-12 rounded-full bg-gradient-to-br from-[#B58C3C] to-[#5A3D22]"></div>
                                <div>
                                    <h4 class="font-bold text-gray-900 dark:text-white">Michael & Ana</h4>
                                    <p class="text-sm text-gray-500 dark:text-gray-400">Beach Wedding, 2024</p>
                                </div>
                            </div>
                        </div>

                        <div class="bg-white dark:bg-gray-800 rounded-2xl p-8 shadow-lg hover:shadow-xl transition-shadow border border-gray-200 dark:border-gray-700">
                            <div class="flex items-center gap-1 mb-4">
                                <svg class="w-5 h-5 fill-[#B58C3C]" viewBox="0 0 20 20"><path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/></svg>
                                <svg class="w-5 h-5 fill-[#B58C3C]" viewBox="0 0 20 20"><path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/></svg>
                                <svg class="w-5 h-5 fill-[#B58C3C]" viewBox="0 0 20 20"><path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/></svg>
                                <svg class="w-5 h-5 fill-[#B58C3C]" viewBox="0 0 20 20"><path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/></svg>
                                <svg class="w-5 h-5 fill-[#B58C3C]" viewBox="0 0 20 20"><path d="M10 15l-5.878 3.09 1.123-6.545L.489 6.91l6.572-.955L10 0l2.939 5.955 6.572.955-4.756 4.635 1.123 6.545z"/></svg>
                            </div>
                            <p class="text-gray-600 dark:text-gray-300 mb-6 leading-relaxed">
                                "Natural, elegant, and timeless. They captured all the little moments we didn't even notice. Our photos tell our love story beautifully!"
                            </p>
                            <div class="flex items-center gap-4">
                                <div class="w-12 h-12 rounded-full bg-gradient-to-br from-[#3F2B19] to-[#3F2B19]"></div>
                                <div>
                                    <h4 class="font-bold text-gray-900 dark:text-white">Emma & David</h4>
                                    <p class="text-sm text-gray-500 dark:text-gray-400">Church Wedding, 2023</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <!-- Footer -->
        <footer
            class="relative mt-32 overflow-hidden z-20 text-[#F8D8D4]"
            style="background:
                radial-gradient(circle at 18% 22%, rgba(198,97,58,0.18), transparent 34%),
                radial-gradient(circle at 84% 20%, rgba(229,194,167,0.10), transparent 38%),
                linear-gradient(150deg, #5A251A 0%, #6E3121 34%, #863D28 68%, #863D28 100%);"
        >
            <div class="absolute inset-0 bg-gradient-to-br from-[#3A1710]/42 via-[#4B2016]/18 to-[#5C291C]/30"></div>
            <div class="relative max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
                <div class="grid grid-cols-1 md:grid-cols-4 gap-12 mb-12">
                    <div class="md:col-span-2">
                        <div class="flex items-center mb-6">
                            <svg class="w-10 h-10 text-[#FFE1D6] mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 9a2 2 0 012-2h.93a2 2 0 001.664-.89l.812-1.22A2 2 0 0110.07 4h3.86a2 2 0 011.664.89l.812 1.22A2 2 0 0018.07 7H19a2 2 0 012 2v9a2 2 0 01-2 2H5a2 2 0 01-2-2V9z" />
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 13a3 3 0 11-6 0 3 3 0 016 0z" />
                            </svg>
                            <span class="text-2xl font-bold text-[#FFF0EB]">Brighter Days Photography PH</span>
                        </div>
                        <p class="text-[#F7E3DE] mb-6 leading-relaxed max-w-md">
                            Professional event photography management system for all your special occasions. Capturing moments that last a lifetime.
                        </p>
                        <div class="flex gap-4">
                            <a href="https://web.facebook.com/BrighterDaysPhotog" target="_blank" rel="noopener noreferrer" class="w-10 h-10 rounded-full border border-[#F0A599]/70 bg-[#F09367]/35 hover:bg-[#F0A599] hover:border-[#F0A599] flex items-center justify-center transition-all duration-300">
                                <svg class="w-5 h-5 text-[#FFF5F2]" fill="currentColor" viewBox="0 0 24 24"><path d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z"/></svg>
                            </a>
                        </div>
                    </div>
                    <div>
                        <h3 class="font-bold text-[#FFF0EB] mb-6 text-lg">Quick Links</h3>
                        <ul class="space-y-3">
                            <li><Link href="/login" class="text-[#F7E3DE] hover:text-[#FFF5F2] transition-colors flex items-center group">
                                <svg class="w-4 h-4 mr-2 group-hover:translate-x-1 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
                                </svg>
                                Login
                            </Link></li>
                            <li><Link href="/register" class="text-[#F7E3DE] hover:text-[#FFF5F2] transition-colors flex items-center group">
                                <svg class="w-4 h-4 mr-2 group-hover:translate-x-1 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
                                </svg>
                                Register
                            </Link></li>
                            <li><a href="#" class="text-[#F7E3DE] hover:text-[#FFF5F2] transition-colors flex items-center group">
                                <svg class="w-4 h-4 mr-2 group-hover:translate-x-1 transition-transform" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5l7 7-7 7" />
                                </svg>
                                Packages
                            </a></li>
                        </ul>
                    </div>
                    <div>
                        <h3 class="font-bold text-[#FFF0EB] mb-6 text-lg">Contact Us</h3>
                        <ul class="space-y-4 text-[#F7E3DE]">
                            <li class="flex items-start">
                                <svg class="w-5 h-5 mr-3 text-[#FFD0C1] flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                                </svg>
                                <span>mr.brightshots@gmail.com</span>
                            </li>
                            <li class="flex items-start">
                                <svg class="w-5 h-5 mr-3 text-[#FFD0C1] flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M3 5a2 2 0 012-2h3.28a1 1 0 01.948.684l1.498 4.493a1 1 0 01-.502 1.21l-2.257 1.13a11.042 11.042 0 005.516 5.516l1.13-2.257a1 1 0 011.21-.502l4.493 1.498a1 1 0 01.684.949V19a2 2 0 01-2 2h-1C9.716 21 3 14.284 3 6V5z" />
                                </svg>
                                <span>0977 217 9168</span>
                            </li>
                            <li class="flex items-start">
                                <svg class="w-5 h-5 mr-3 text-[#FFD0C1] flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
                                </svg>
                                <div>
                                    <div class="font-semibold text-[#FFF0EB] mb-1">Address</div>
                                    <span>Dama De Noche, Marikina City, Philippines, 1810</span>
                                </div>
                            </li>
                            <li class="flex items-start">
                                <svg class="w-5 h-5 mr-3 text-[#FFD0C1] flex-shrink-0 mt-0.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 20l-5.447-2.724A1 1 0 013 16.382V5.618a1 1 0 011.447-.894L9 7m0 13l6-3m-6 3V7m6 10l4.553 2.276A1 1 0 0021 18.382V7.618a1 1 0 00-.553-.894L15 4m0 13V4m0 0L9 7" />
                                </svg>
                                <div>
                                    <div class="font-semibold text-[#FFF0EB] mb-1">Service Area</div>
                                    <span>Rizal · Cavite · Batangas · Urdaneta · Bulacan · Manila</span>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="pt-8 border-t border-[#F0A599]/45">
                    <div class="flex flex-col md:flex-row justify-between items-center gap-4">
                        <p class="text-[#F1D6D0] text-sm">&copy; 2025 Brighter Days Photography PH. All rights reserved.</p>
                        <div class="flex gap-6 text-sm text-[#F1D6D0]">
                            <a href="#" class="hover:text-[#FFF5F2] transition-colors">Privacy Policy</a>
                            <a href="#" class="hover:text-[#FFF5F2] transition-colors">Terms of Service</a>
                            <a href="#" class="hover:text-[#FFF5F2] transition-colors">Cookie Policy</a>
                        </div>
                    </div>
                </div>
            </div>
        </footer>

        <!-- Gallery Modal -->
        <Transition
            enter-active-class="transition-opacity duration-300"
            enter-from-class="opacity-0"
            enter-to-class="opacity-100"
            leave-active-class="transition-opacity duration-300"
            leave-from-class="opacity-100"
            leave-to-class="opacity-0"
        >
            <div v-if="showModal" class="fixed inset-0 z-50 flex items-center justify-center p-4 bg-black/90" @click.self="closeModal">
                <div class="relative w-full max-w-7xl max-h-[90vh] overflow-auto bg-gray-900 rounded-3xl p-8">
                    <!-- Close button -->
                    <button @click="closeModal" class="absolute top-4 right-4 z-10 w-12 h-12 flex items-center justify-center rounded-full border border-[#BE6674] bg-[#BB8C94]/85 hover:bg-[#BE6674] text-white shadow-md transition-all duration-300">
                        <svg class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M6 18L18 6M6 6l12 12" />
                        </svg>
                    </button>

                    <!-- Modal Header -->
                    <div class="text-center mb-8">
                        <h2 class="text-4xl font-bold text-white mb-2">
                            {{ selectedEventType === 'wedding' ? 'Wedding' : selectedEventType === 'birthday' ? 'Birthday' : selectedEventType === 'creative-community-event' ? 'Pre Debut' : 'Prenuptial' }} Gallery
                        </h2>
                        <p class="text-gray-400">{{ modalImages.length }} beautiful moments captured</p>
                    </div>

                    <!-- Gallery Grid -->
                    <div class="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4">
                        <div v-for="(image, index) in modalImages" :key="index" class="relative overflow-hidden rounded-xl aspect-square group bg-gray-800">
                            <img :src="image" :alt="`${selectedEventType} photo ${index + 1}`" class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" loading="lazy" />
                            <div class="absolute inset-0 bg-gradient-to-t from-black/50 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300"></div>
                        </div>
                    </div>
                </div>
            </div>
        </Transition>
    </div>
</template>
